//%attributes = {"invisible":true}
// Method: Method: INSP_PrintQAForm_OM
// Description
//  ` Object method for the button that prints Inspection Evaluation form from the inspection list in the 
//  ` Combined Inspections list.
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//Modified by: Kenny Yang-(Designer) `10/25/10, 17:18:41   `\ 
	// ----------------------------------------------------
	
	Mods_2010_12
	// Modified by: Costas Manousakis-(Designer)-(6/20/12 14:47:50)
	Mods_2012_06
	//  `Befoire getting the cell position of the listbox, check if there is anything in the hilite set
	//  `button available to Area Engineers
	Mods_2013_05  //``` *** BUG FIX *****
	//  `Set name of listbox changed to LBSetBrgInsp
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
		C_TEXT:C284($currUser_txt)
		$currUser_txt:=<>CurrentUser_Name
		If (($currUser_txt="Designer") | User in group:C338($currUser_txt; "Application Admin") | User in group:C338($currUser_txt; "Area Engineers"))
			OBJECT SET VISIBLE:C603(*; "PrintQAButton@"; True:C214)
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		
		C_LONGINT:C283($rec_L; $column_l)
		$rec_L:=Records in set:C195("LBSetBrgInsp")
		
		If ($rec_L>0)
			LISTBOX GET CELL POSITION:C971(*; "Inspections"; $column_l; $rec_L)
		End if 
		
		If ($rec_L<1) | ($rec_L>Records in selection:C76([Combined Inspections:90]))
			ALERT:C41("You Must select an inspection to Print the QA Form")
		Else 
			ut_Read_Write_Tables("READ"; ->[Inspections:27]; ->[Combined Inspections:90]; ->[BMS Inspections:44]; ->[ElementsSafety:29]; ->[Standard Photos:36]; ->[Field Trip:43]; ->[BMS Field Trip:56]; ->[Cond Units:45])
			ut_Read_Write_Tables("READ"; ->[Inspection Type:31]; ->[Bridge MHD NBIS:1])
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			SET FIELD RELATION:C919([ElementsSafety:29]InspID:4; Manual:K51:3; Manual:K51:3)
			C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
			COPY NAMED SELECTION:C331([Combined Inspections:90]; "COMBISNPSPREPRINT")
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			UNLOAD RECORD:C212([Combined Inspections:90])
			LOAD RECORD:C52([Combined Inspections:90])
			//ONE RECORD SELECT([Combined Inspections])
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
					G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
					//QUERY([Combined Inspections];[Combined Inspections]NBISInspID=[Inspections]InspID)
					LOAD RECORD:C52([Combined Inspections:90])
					If ([Combined Inspections:90]BMSInspID:3>0)
						QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
						LOAD RECORD:C52([BMS Inspections:44])
						DISPL_CUs
						QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
					Else 
						UNLOAD RECORD:C212([BMS Inspections:44])
						UNLOAD RECORD:C212([Cond Units:45])
						UNLOAD RECORD:C212([BMS Field Trip:56])
						REDUCE SELECTION:C351([BMS Inspections:44]; 0)
						REDUCE SELECTION:C351([Cond Units:45]; 0)
						REDUCE SELECTION:C351([BMS Field Trip:56]; 0)
						
					End if 
					RELATE ONE:C42([Inspections:27]Insp Type:6)
					CONFIRM:C162("Printing QA form for "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
					If (OK=1)
						PRINT_QAFORM
					End if 
					
				Else 
					ALERT:C41("Not allowed to Print this Inspection!")
					CANCEL:C270  //exit form
					UNLOAD RECORD:C212([Inspections:27])
				End if   //if user allowed
				
				G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
				
				GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			Else 
				ALERT:C41("There are database link problems with this inspection record!! Record cannot be l"+"oaded!!")
			End if 
			ut_Read_Write_Tables("WRITE"; ->[Inspections:27]; ->[Combined Inspections:90]; ->[BMS Inspections:44]; ->[ElementsSafety:29]; ->[Standard Photos:36]; ->[Field Trip:43]; ->[BMS Field Trip:56]; ->[Cond Units:45])
			ut_Read_Write_Tables("WRITE"; ->[Inspection Type:31]; ->[Bridge MHD NBIS:1])
			SET FIELD RELATION:C919([ElementsSafety:29]InspID:4; Structure configuration:K51:2; Structure configuration:K51:2)
			
			INSP_UpdateInspList
			
			USE NAMED SELECTION:C332("COMBISNPSPREPRINT")
			CLEAR NAMED SELECTION:C333("COMBISNPSPREPRINT")
			
		End if 
End case 