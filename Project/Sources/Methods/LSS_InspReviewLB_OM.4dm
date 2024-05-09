//%attributes = {"invisible":true}
//Method: LSS_InspReviewLB_OM
//Description
// object method for the listbox in inspection review screen
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 14:26:54
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
	C_LONGINT:C283(LSS_InspReviewLB_OM; $0)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(11/29/18 14:28:04)
	Mods_2018_11
	//  `use method LSS_SetUpReviewButton
	// Modified by: Costas Manousakis-(Designer)-(2024-03-13 19:05:18)
	Mods_2024_LSS_1
	//  `allow copying of structure numbers when using right-click on the str num column.
End if 
//
C_LONGINT:C283($LBCol_L; LSS_InspectionRow_L)
Case of 
	: (Form event code:C388=On Header Click:K2:40)
		$0:=LSS_SortInspReviewLB
		
	: (Form event code:C388=On Display Detail:K2:22)
		QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=[LSS_Inspection:164]LSS_InventoryId_s:2)
		QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=[LSS_Inspection:164]LSS_InspectionTypeId_s:3)
		v_167_002_txt:=[LSS_refInspectionType:167]LSS_Description_txt:2
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; LSS_InspectionRow_L)
			If (LSS_InspectionRow_L>0)
				GOTO SELECTED RECORD:C245([LSS_Inspection:164]; LSS_InspectionRow_L)
				QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=[LSS_Inspection:164]LSS_InventoryId_s:2)
				
				C_TEXT:C284($InputForm_txt)
				
				LSS_SelectInpsectionInputForm(->$InputForm_txt; ->LSS_InspectionRow_L)
				C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
				GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
				OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $ol; $ot; $or; $ob)
				If (LSS_InspectionRow_L>0)
					LSS_DisplayInspection($InputForm_txt)
				End if 
				InDoubleClick_B:=False:C215
				SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
				OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $wl; $wt; $wr; $wb)
				OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; [LSS_Inspection:164]LSS_Complete_b:39)
				UNLOAD RECORD:C212([LSS_Inspection:164])
				READ ONLY:C145([LSS_Inspection:164])
				
				OBJECT MOVE:C664(*; "Inspection_LB"; 0; 0; $or-$wr; $ob-$wb)
				
				REDRAW:C174(Inspection_LB)
				
				LISTBOX SELECT ROW:C912(*; "Inspection_LB"; LSS_InspectionRow_L)
				OBJECT SET SCROLL POSITION:C906(*; "Inspection_LB"; LSS_InspectionRow_L)
				ut_SetReadWrite("read"; ->[LSS_Inspection:164])
				
				WIN_SetWindowTitle(->[LSS_Inspection:164])
			Else 
				InDoubleClick_B:=False:C215
			End if 
		End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; LSS_InspectionRow_L)
		
		LSS_SelectInpsectionInputForm(->$InputForm_txt; ->LSS_InspectionRow_L)
		
		If ((LSS_InspectionRow_L>0) & (Records in set:C195("InspReviewSelect")>0))
			OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection@"; False:C215)
			If (Current user:C182="Designer")
				OBJECT SET ENABLED:C1123(LSS_ExportInspection_L; True:C214)  // **replaced _ o _ENABLE BUTTON(LSS_ExportInspection_L)
				OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection@"; True:C214)
				
			End if 
			//SET VISIBLE(*;"LSS_Edit_L";True)
			OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; True:C214)
			//SET VISIBLE(*;"LSS_Duplicate_L";False)
			//If (LSS_AllowInspectionEdit_B) | (User in group(Current user;"Design Access Group"))
			//
			//ENABLE BUTTON(*;"LSS_Edit_L")
			//BUTTON TEXT(*;"LSS_Edit_L";"Edit")
			//Else 
			//ENABLE BUTTON(*;"LSS_Edit_L")
			//BUTTON TEXT(*;"LSS_Edit_L";"Display")
			//End if 
			
			//If ((LSS_AllowNewInspection_b & ([LSS_Inspection]LSS_Approved_L=BMS Approved )) | (User in group(◊CurrentUser_Name;"Design Access Group")))
			//SET VISIBLE(*;"LSS_Duplicate_L";True)
			//ENABLE BUTTON(*;"LSS_Duplicate_L")
			//BUTTON TEXT(*;"LSS_Duplicate_L";"Duplicate")
			//Else 
			//SET VISIBLE(*;"LSS_Duplicate_L";False)
			//End if 
			LSS_SetUpReviewButton
			
		Else 
			OBJECT SET VISIBLE:C603(*; "LSS_Edit_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection_L"; False:C215)
		End if 
		
		//start of Mods_2024_LSS_1
		
		If (Contextual click:C713 & ($LBCol_L=1))
			C_TEXT:C284($copymenu_txt)
			$copymenu_txt:="...;Copy selected Structure numbers"
			C_LONGINT:C283($choice_L)
			$choice_L:=Pop up menu:C542($copymenu_txt)
			//ut_Send2Clipboard ("\n"+String($choice_L))
			If ($choice_L=2)
				
				ARRAY TEXT:C222($strnums_atxt; Records in set:C195("InspReviewSelect"))
				ARRAY TEXT:C222($invIDs_atxt; Records in set:C195("InspReviewSelect"))
				
				COPY NAMED SELECTION:C331([LSS_Inspection:164]; "$LSSINV_PRECUT")
				COPY SET:C600("InspReviewSelect"; "$temphiliteset")
				USE SET:C118("InspReviewSelect")
				SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $invIDs_atxt; [LSS_Inventory:165]LSS_StructureNumber_s:6; $strnums_atxt)
				USE NAMED SELECTION:C332("$LSSINV_PRECUT")
				CLEAR NAMED SELECTION:C333("$LSSINV_PRECUT")
				SET TEXT TO PASTEBOARD:C523(ut_ArrayToText(->$strnums_atxt; "\n"))
				COPY SET:C600("$temphiliteset"; "InspReviewSelect")
				CLEAR SET:C117("$temphiliteset")
			End if 
			
		End if 
		//end of Mods_2024_LSS_1
		
End case 

//End LSS_InspReviewLB_OM