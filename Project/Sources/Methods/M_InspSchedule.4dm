//%attributes = {"invisible":true}
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
	// Modified by: Costas Manousakis-(Designer)-(9/11/13 11:22:08)
	Mods_2013_09
	//  `Added handling tunnel inspections
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

C_BOOLEAN:C305(BRGList_TunnelsOnly_b)
ARRAY TEXT:C222($RecordTypes_atxt; 0)
ARRAY TEXT:C222($TunneTypes_atxt; 0)
DISTINCT VALUES:C339([Bridge MHD NBIS:1]Item8 BridgeCat:207; $RecordTypes_atxt)
BRGList_TunnelsOnly_b:=False:C215
C_LONGINT:C283($arrIndx_L)
$arrIndx_L:=Find in array:C230($RecordTypes_atxt; "BTS")
If ($arrIndx_L>0)
	APPEND TO ARRAY:C911($TunneTypes_atxt; "BTS")
End if 
$arrIndx_L:=Find in array:C230($RecordTypes_atxt; "TNL")
If ($arrIndx_L>0)
	APPEND TO ARRAY:C911($TunneTypes_atxt; "TNL")
End if 
BRGList_TunnelsOnly_b:=(Size of array:C274($TunneTypes_atxt)=Size of array:C274($RecordTypes_atxt))

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
	$d:=Current date:C33(*)
	$Month:=Month of:C24($d)
	$Year:=Year of:C25($d)
	$Waive:=(CBWaiver=1)
	//Fix scope
	Case of 
		: (n1=1)  //Get any bridge      
		: (n2=1)  //Get State Bridges
			QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fStateBridge)
		: (n3=1)  //Get State or NBI Bridges
			QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; (fStateBridge | [Bridge MHD NBIS:1]FHWARecord:174))
		: (n4=1)  //Get Town and MUN Bridges
			QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fMUNBridge)
			//      QUERY SELECTION BY FORMULA([Bridge MHD NBIS];fMUNBridge  | fTWNBridge )
			//: (n4=1)  `Get MUN Bridges
			// QUERY SELECTION BY FORMULA([Bridge MHD NBIS];fMUNBridge )
			//: (n5=1)  `Get TWN Bridges
			// QUERY SELECTION BY FORMULA([Bridge MHD NBIS];fTWNBridge )
	End case 
	CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "SCHEDINSPREQDSET")
	If (CBInspReqd=1)
		SET QUERY DESTINATION:C396(Into set:K19:2; "SCHEDINSPREQDSET")
		QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspRequired:227=True:C214)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
	End if 
	
	If (CB_NBI=1)
		QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	End if 
	If (CBComplexBrg=1)
		QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Complex Bridge:178=True:C214)
	End if 
	If (Records in set:C195("SCHEDINSPREQDSET")>0)
		CREATE SET:C116([Bridge MHD NBIS:1]; "SCHEDINSPECTIONS")
		UNION:C120("SCHEDINSPECTIONS"; "SCHEDINSPREQDSET"; "SCHEDINSPECTIONS")
		USE SET:C118("SCHEDINSPECTIONS")
		CLEAR SET:C117("SCHEDINSPECTIONS")
	End if 
	CLEAR SET:C117("SCHEDINSPREQDSET")
	//Determine inspection type
	
	If (BRGList_TunnelsOnly_b)
		Case of 
			: (o1=1)  //Combined Tunnel inspection
				$t:=28
			: (o2=1)  //Tunnel Routine inspection
				$t:=21
			: (o3=1)  //Tunnel Overhead Items
				$t:=22
			: (o4=1)  //Tunnel Special1
				$t:=23
			: (o5=1)  //Tunnel Special 2
				$t:=24
			: (o6=1)  //Tunnel Special3
				$t:=25
			: (o7=1)  //Tunnel Other
				$t:=26
			: (o8=1)  //Tunnel Closed
				$t:=27
		End case 
		
	Else 
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
		
	End if 
	
	Case of 
		: (p1=1)  //Out of frequency
			CENTER_WINDOW(220; 250; 4)
			DIALOG:C40([Dialogs:21]; "InspDialog3")
			CLOSE WINDOW:C154
			$leeway:=vLeeway
			If (Ok=1)
				QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fOutofFreq($t; $leeway; $Waive))
			End if 
		: (p2=1)  //This month's inspection
			SIA_INSPECTIONMONTH_d:=Date:C102(String:C10($Month)+"/1/"+String:C10($Year))
			Case of 
				: ($t=7)
					QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fCombineInsp($Year; $Month; 0; 0; $Waive))
				: ($t=6)
					QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fCombineUWInsp($Year; $Month; 0; 0; $Waive))
				: ($t=28)  //Tunnel inspections
					QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fCombineInsp($Year; $Month; 0; 0; $Waive))
				Else 
					QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fUpforInsp($Year; $Month; 0; 0; $t; $Waive))
			End case 
			
		: (p3=1)  //User specified inspection      
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
						QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fCombineInsp($Year; $Month; 0; 0; $Waive))
					: ($t=6)
						QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fCombineUWInsp($Year; $Month; 0; 0; $Waive))
					: ($t=28)  //Tunnel inspections
						QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fCombineInsp($Year; $Month; 0; 0; $Waive))
					Else 
						QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; fUpforInsp($Year; $Month; 0; 0; $t; $Waive))
				End case 
			End if 
	End case 
	C_TEXT:C284(GEN_SORTLISTCMD_txt)
	If (GEN_SORTLISTCMD_txt#"")
		EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
	End if 
	
	RegionTitle
End if 