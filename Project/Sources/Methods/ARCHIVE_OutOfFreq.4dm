//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: ARCHIVE_OutOfFreq
// Description
// Copied from M_InspSchedule
// **************
//  N O T    I M P L E M E N T E D     Y E T   !!!!!!!!!
//  FUNCTIONS  fCombineInsp fUpforInsp fCombineUWInsp DO NOT WORK WITH THE ARCHIVE TABLE !!!!!!!!!

// **************
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/24/11, 12:02:46
	// First Release
	Mods_2011_10
End if 
If (False:C215)
	//GP: M_inspSchedule
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	
	Mods_2004_CM11
	// Modified by: costasmanousakis-(Designer)-(4/4/08 17:00:33)
	Mods_2008_CM_5403  //Apply sort
	Mods_2009_03  //CJM  r001   `03/06/09, 12:55:45`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(12/30/09 12:47:49)
	Mods_2009_12
	//  ` Include NonNfCombineUWInspBI bridges needing inspections - added var o8=UW routine, o9=UWSpec -
	//  ` use new method fCombineUWInsp ;
	//  ` Added var SIA_INSPECTIONMONTH_d to be used in a quick report when using SIA_NextInspDate
	// Modified by: Costas Manousakis-(Designer)-(5/13/14 10:39:40)
	Mods_2014_05_bug
	//  `Adjusted  logic to allow running report if reason and date are not unique in the  selection
End if 

C_LONGINT:C283($t)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($leeway)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($Waive)
C_DATE:C307($d)
C_LONGINT:C283($Month)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Year)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($tempwin)
C_LONGINT:C283(n1; n2; n3; n4; o1; o2; o3; o4; o5; o6; o7; o8; o9; p1; p2; p3)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(CB_NBI; CBComplexBrg; CBWaiver)  //Command Replaced was o_C_INTEGER

//CENTER_WINDOW (420;340;4)
//Run it only if we have single Reason and Date
ARRAY TEXT:C222($archReasons_atxt; 0)
ARRAY DATE:C224($archDates_ad; 0)
DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveReason_s:223; $archReasons_atxt)
DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveDate_d:224; $archDates_ad)
C_BOOLEAN:C305($proceed_b)
$proceed_b:=False:C215

Case of 
	: (Records in selection:C76([BridgeMHDNBISArchive:139])=0)
		ALERT:C41("Please select some records before running this report.")
	: ((Size of array:C274($archReasons_atxt)=1) & (Size of array:C274($archDates_ad)=1))
		$proceed_b:=True:C214
	Else 
		CONFIRM:C162("Multiple Archive Reasons ("+String:C10(Size of array:C274($archReasons_atxt))+")  and/or Archive Dates ("+String:C10(Size of array:C274($archDates_ad))+") found! Run the report anyway?"; "Run"; "Cancel")
		$proceed_b:=(OK=1)
End case 


If ($proceed_b)
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Dialogs:21]; "InspDialog1"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; 4; $Title_txt; "ut_CloseCancel")
	//$tempwin:=Open form window([Dialogs];"InspDialog1";4)
	DIALOG:C40([Dialogs:21]; "InspDialog1")
	CLOSE WINDOW:C154($Win_l)
	C_DATE:C307(SIA_INSPECTIONMONTH_d)
	SIA_INSPECTIONMONTH_d:=!00-00-00!
	
	If (Ok=1)
		//Get current date from server
		$d:=Date:C102(Request:C163("Enter Effective date"; String:C10($archDates_ad{1})))
		$Month:=Month of:C24($d)
		$Year:=Year of:C25($d)
		$Waive:=(CBWaiver=1)
		//Fix scope
		Case of 
			: (n1=1)  //Get any bridge      
			: (n2=1)  //Get State Bridges
				ALERT:C41("Wiil Not Search for State Bridges! Search must be performed before this method is"+" called!")
				//QUERY SELECTION BY FORMULA([BridgeMHDNBISArchive];fStateBridge )
			: (n3=1)  //Get State or NBI Bridges
				ALERT:C41("Wiil Not Search for State or NBI Bridges! Search must be performed before this me"+"thod is"+" called!")
				//QUERY SELECTION BY FORMULA([BridgeMHDNBISArchive];(fStateBridge  | [BridgeMHDNBISArchive]FHWARecord))
			: (n4=1)  //Get Town and MUN Bridges
				ALERT:C41("Wiil Not Search for Town and MUN Bridges! Search must be performed before this me"+"thod is"+" called!")
				//QUERY SELECTION BY FORMULA([BridgeMHDNBISArchive];fMUNBridge )
				//      QUERY SELECTION BY FORMULA([BridgeMHDNBISArchive];fMUNBridge  | fTWNBridge )
			: (n4=1)  //Get MUN Bridges
				ALERT:C41("Wiil Not Search for MUN Bridges! Search must be performed before this method is"+" called!")
				//QUERY SELECTION BY FORMULA([BridgeMHDNBISArchive];fMUNBridge )
			: (n5=1)  //Get TWN Bridges
				ALERT:C41("Wiil Not Search for Town Bridges! Search must be performed before this method is"+" called!")
				//QUERY SELECTION BY FORMULA([BridgeMHDNBISArchive];([BridgeMHDNBISArchive]Item8 Owner="MUN"))
		End case 
		CREATE EMPTY SET:C140([BridgeMHDNBISArchive:139]; "SCHEDINSPREQDSET")
		If (CBInspReqd=1)
			SET QUERY DESTINATION:C396(Into set:K19:2; "SCHEDINSPREQDSET")
			QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]InspRequired:226=True:C214)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End if 
		
		If (CB_NBI=1)
			QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]FHWARecord:173=True:C214)
		End if 
		If (CBComplexBrg=1)
			QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]Complex Bridge:177=True:C214)
		End if 
		If (Records in set:C195("SCHEDINSPREQDSET")>0)
			CREATE SET:C116([BridgeMHDNBISArchive:139]; "SCHEDINSPECTIONS")
			UNION:C120("SCHEDINSPECTIONS"; "SCHEDINSPREQDSET"; "SCHEDINSPECTIONS")
			USE SET:C118("SCHEDINSPECTIONS")
			CLEAR SET:C117("SCHEDINSPECTIONS")
		End if 
		CLEAR SET:C117("SCHEDINSPREQDSET")
		//Determine inspection type
		Case of 
			: (o1=1)  //Combined inspection
				$t:=7
			: (o2=1)  //Routine inspection
				$t:=1
			: (o3=1)  //Fracture critical inspection
				$t:=2
			: (o4=1)  //Other special inspection
				$t:=3
			: (o5=1)  //Critical Member
				$t:=4
			: (o6=1)  //Closed bridge
				$t:=5
			: (o7=1)  //Combined UW Underwater
				$t:=6
		End case 
		Case of 
			: (p1=1)  //Out of frequency
				CENTER_WINDOW(220; 250; 4)
				DIALOG:C40([Dialogs:21]; "InspDialog3")
				CLOSE WINDOW:C154
				$leeway:=vLeeway
				If (Ok=1)
					QUERY SELECTION BY FORMULA:C207([BridgeMHDNBISArchive:139]; ARCHIVE_fOutOfFreq($t; $leeway; $Waive; $d))
				End if 
			: (p2=1)  //This month's inspection
				ALERT:C41("This Method work only for Out of Frequency checks. !!")
				If (False:C215)
					SIA_INSPECTIONMONTH_d:=Date:C102(String:C10($Month)+"/1/"+String:C10($Year))
					Case of 
						: ($t=7)
							QUERY SELECTION BY FORMULA:C207([BridgeMHDNBISArchive:139]; fCombineInsp($Year; $Month; 0; 0; $Waive))
						: ($t=6)
							QUERY SELECTION BY FORMULA:C207([BridgeMHDNBISArchive:139]; fCombineUWInsp($Year; $Month; 0; 0; $Waive))
						Else 
							QUERY SELECTION BY FORMULA:C207([BridgeMHDNBISArchive:139]; fUpforInsp($Year; $Month; 0; 0; $t; $Waive))
					End case 
					
				End if 
				
			: (p3=1)  //User specified inspection      
				ALERT:C41("This Method work only for Out of Frequency checks. !!")
				
				If (False:C215)
					CENTER_WINDOW(260; 200; 4)
					DIALOG:C40([Dialogs:21]; "InspDialog2")
					CLOSE WINDOW:C154
					If (Ok=1)
						$Year:=vYear
						$Month:=aMonths
						SIA_INSPECTIONMONTH_d:=Date:C102(String:C10($Month)+"/1/"+String:C10($Year))
						If (CBwholeyear=1)
							$Month:=0
							SIA_INSPECTIONMONTH_d:=Date:C102("1/1/"+String:C10($Year))
						End if 
						Case of 
							: ($t=7)
								QUERY SELECTION BY FORMULA:C207([BridgeMHDNBISArchive:139]; fCombineInsp($Year; $Month; 0; 0; $Waive))
							: ($t=6)
								QUERY SELECTION BY FORMULA:C207([BridgeMHDNBISArchive:139]; fCombineUWInsp($Year; $Month; 0; 0; $Waive))
							Else 
								QUERY SELECTION BY FORMULA:C207([BridgeMHDNBISArchive:139]; fUpforInsp($Year; $Month; 0; 0; $t; $Waive))
						End case 
					End if 
				End if 
				
		End case 
		// 
	End if 
	
End if 