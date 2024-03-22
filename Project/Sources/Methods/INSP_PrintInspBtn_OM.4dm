//%attributes = {"invisible":true}
// Method: INSP_PrintInspBtn_OM
// Description
//  ` Object method for the button that prints inspections from the inspection list in the 
//  ` Combined Inspections list.
// 
// Parameters
// $1 : $FormEvent_L (Optional)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 9/1/10, 14:29:59
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(1/21/11 15:58:09)
	Mods_2011_01
	//` RR
	// Modified by: costasmanousakis-(Designer)-(4/13/11 15:12:42)
	Mods_2011_04
	//  `Added code to build the TeamMember area
	// Modified by: Costas Manousakis-(Designer)-(6/20/12 14:47:50)
	Mods_2012_06
	//  `Made button visible to all
	//  `Befoire getting the cell position of the listbox, check if there is anything in the hilite set
	// Modified by: Costas Manousakis-(Designer)-(7/9/12 12:28:31)
	Mods_2012_07
	//  `Removed the "CANCEL" command if the inspection should not be printed
	Mods_2012_12  //r001 ` Code for new inspection types
	//Modified by: Charles Miller (12/13/12 13:07:35)
	// Modified by: Costas Manousakis-(Designer)-(1/3/13 11:18:08)
	Mods_2013_01
	//  `Added RRS, RRF, RRD, RRO types
	//  `Added call for RR@ types to INSP_LoadElmLabelsforReport
	// Modified by: Costas Manousakis-(Designer)-(4/12/13 16:17:18)
	Mods_2013_04
	//  `Use new INSP_Read_Write_Tables
	// Modified by: Costas Manousakis-(Designer)-(5/16/13 16:47:05)
	Mods_2013_05
	//  `separate cases for Tunnels and Redraw window
	Mods_2013_05  //``` *** BUG FIX *****
	//  `Set name of listbox changed to LBSetBrgInsp for bridge inspections LBSetTunnelInsp for Tunnel
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 12:12:25)
	Mods_2013_10
	//  `initialize INSP_PageCountDone_b;vbInspectionLocked vars here
	// Modified by: Costas Manousakis-(Designer)-(6/6/14 14:14:10)
	Mods_2014_06_bug
	//  `load tunnelinfo before tables are set to RW
	// Modified by: Costas Manousakis-(Designer)-(10/15/14 16:48:48)
	Mods_2014_10_bug
	//  `Load [TunnelInspection] record before calling the Print method
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 11:49:52)
	Mods_2015_02
	//  `Added Tunnel Damage TDA , Tunnel Other TOT
	// Modified by: Costas Manousakis-(Designer)-(4/1/15 17:06:57)
	Mods_2015_04
	//  `added check for the NBEs
	// Modified by: Costas Manousakis-(Designer)-(9/29/15 17:48:04)
	Mods_2015_09_bug
	//  `removed case for "RRR" inspection which was with "RT@" case
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 13:32:10)
	Mods_2016_10
	//  `added call to NTI_INIT before printing tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(3/9/17 16:08:18)
	Mods_2017_03
	//  ` use INSP_PrintInspType
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		//C_TEXT($currUser_txt)
		//$currUser_txt:=◊CurrentUser_Name
		//If (($currUser_txt="Designer") | (User in group($currUser_txt;"Application Admin")))
		//SET VISIBLE(*;"PrintInsp@";True)
		//End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		
		If (INSP_Inspection_list_txt="TUNNEL")
			C_LONGINT:C283($rec_L; $column_l)
			$rec_L:=Records in set:C195("LBSetTunnelInsp")
			
			If ($rec_L>0)
				LISTBOX GET CELL POSITION:C971(*; "TunnelInspections"; $column_l; $rec_L)
			End if 
		Else 
			C_LONGINT:C283($rec_L; $column_l)
			$rec_L:=Records in set:C195("LBSetBrgInsp")
			
			If ($rec_L>0)
				LISTBOX GET CELL POSITION:C971(*; "Inspections"; $column_l; $rec_L)
			End if 
			
		End if 
		If ($rec_L<1) | ($rec_L>Records in selection:C76([Combined Inspections:90]))
			ALERT:C41("You Must select an inspection to Print")
		Else 
			C_BOOLEAN:C305(INSP_PageCountDone_b; vbInspectionLocked)
			vbInspectionLocked:=True:C214
			INSP_PageCountDone_b:=False:C215
			INSP_Read_Write_Tables("READ")
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			SET FIELD RELATION:C919([ElementsSafety:29]InspID:4; Manual:K51:3; Manual:K51:3)
			C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
			COPY NAMED SELECTION:C331([Combined Inspections:90]; "COMBISNPSPREPRINT")
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			UNLOAD RECORD:C212([Combined Inspections:90])
			LOAD RECORD:C52([Combined Inspections:90])
			ONE RECORD SELECT:C189([Combined Inspections:90])
			vCurrentCombID_L:=[Combined Inspections:90]ID:6
			//Get the current record
			SET CURSOR:C469(4)
			//SET AUTOMATIC RELATIONS(False;False)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
			C_BOOLEAN:C305(vAllRelationsOK_B)
			vCurrentPontisID_L:=[BMS Inspections:44]Inspection ID:1
			vAllRelationsOK_B:=True:C214
			If ([Combined Inspections:90]BMSInspID:3>0)
				If (vCurrentPontisID_L#[Combined Inspections:90]BMSInspID:3)
					vAllRelationsOK_B:=False:C215
				End if 
				If ([BMS Inspections:44]BIN:2#[Combined Inspections:90]BIN:1)
					vAllRelationsOK_B:=False:C215
				End if 
			End if 
			If (vAllRelationsOK_B)
				LOAD RECORD:C52([Inspections:27])
				
				C_BOOLEAN:C305($vbUserAllowed)
				C_TEXT:C284($CurrUser_txt)
				$CurrUser_txt:=<>CurrentUser_Name
				$vbUserAllowed:=User in group:C338($CurrUser_txt; "MHDInspectionRWAccess")
				//allow access if User is in group or if Inspection is approved.
				$vbUserAllowed:=($vbUserAllowed | ([Inspections:27]InspApproved:167=BMS Approved))
				$vbUserAllowed:=$vbUserAllowed | (User in group:C338($CurrUser_txt; "MHDInspectionROAccess") & [Inspections:27]InspComplete:168 & ([Inspections:27]Insp Type:6#"DV@"))
				$vbUserAllowed:=$vbUserAllowed | User in group:C338($CurrUser_txt; "InspectionAllAccess")
				$vbUserAllowed:=$vbUserAllowed | (([Inspections:27]Insp Type:6="FRZ") & [Inspections:27]InspComplete:168 & ([Inspections:27]InspReviewed:12=BMS Approved))
				
				If ($vbUserAllowed)
					QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
					LOAD RECORD:C52([Combined Inspections:90])
					If ([Combined Inspections:90]BMSInspID:3>0)
						QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
						LOAD RECORD:C52([BMS Inspections:44])
						If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
							PON_ListElements
							CLEAR SET:C117("PON_LISTINSPELEMS")  // we do not need the set created in PON_ListElements
						Else 
							DISPL_CUs
						End if 
						
						QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
					Else 
						UNLOAD RECORD:C212([BMS Inspections:44])
						UNLOAD RECORD:C212([Cond Units:45])
						UNLOAD RECORD:C212([BMS Field Trip:56])
						REDUCE SELECTION:C351([BMS Inspections:44]; 0)
						REDUCE SELECTION:C351([Cond Units:45]; 0)
						REDUCE SELECTION:C351([BMS Field Trip:56]; 0)
						
					End if 
					INSP_PrintInspType
					
				Else 
					ALERT:C41("Not allowed to Print this Inspection!")
					UNLOAD RECORD:C212([Inspections:27])
				End if   //if user allowed
				
				G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
				
				GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			Else 
				ALERT:C41("There are database link problems with this inspection record!! Record cannot be l"+"oaded!!")
			End if 
			
			QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)  //load tunnelinfo before tables are set to RW
			INSP_Read_Write_Tables("WRITE")
			
			SET FIELD RELATION:C919([ElementsSafety:29]InspID:4; Structure configuration:K51:2; Structure configuration:K51:2)
			
			INSP_UpdateInspList
			
			USE NAMED SELECTION:C332("COMBISNPSPREPRINT")
			CLEAR NAMED SELECTION:C333("COMBISNPSPREPRINT")
			
		End if 
		REDRAW WINDOW:C456
End case 