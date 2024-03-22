
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/23/14, 14:41:35
// ----------------------------------------------------
// Method: Object Method: [LSS_Inventory].Input.Inspection_LB
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	Mods_2018_04  //Fix error where $Pos_l might be less than zero when User in group(Current user;"Design Access Group"))
End if 
Case of 
		
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284($Query_txt)
		$Query_txt:=[LSS_Inspection:164]LSS_InspectionTypeId_s:3
		Begin SQL
			select [LSS_refInspectionType].[LSS_Description_txt] 
			from [LSS_refInspectionType]
			where [LSS_refInspectionType].[LSS_InspectionTypeId_s] = :$Query_txt
			into :LB_Detail2_txt;
		End SQL
		
		Case of 
			: ([LSS_Inspection:164]LSS_Approved_L:43=0)
				LB_Detail9_pct:=LB_Detail9_pct*0
			: ([LSS_Inspection:164]LSS_Approved_L:43=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail9_pct)
			: ([LSS_Inspection:164]LSS_Approved_L:43=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail9_pct)
				
		End case 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Modified record:C314([LSS_Inventory:165]))
			FM_SaveInventoryInput
		Else 
			CANCEL TRANSACTION:C241
		End if 
		
		
		C_TEXT:C284($InputForm_txt)
		
		LSS_SelectInpsectionInputForm(->$InputForm_txt; ->LSS_InspectionRow_L)
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $ol; $ot; $or; $ob)
		If (LSS_InspectionRow_L>0)
			LSS_DisplayInspection($InputForm_txt)
		End if 
		LSS_SetUpReviewButton
		LSS_PermissionDELInventory
		OBJECT SET VISIBLE:C603(*; "bDelete"; LSS_AllowInventoryDelete_B)
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "Inspection_LB"; $wl; $wt; $wr; $wb)
		UNLOAD RECORD:C212([LSS_Inspection:164])
		READ ONLY:C145([LSS_Inspection:164])
		
		OBJECT MOVE:C664(*; "Inspection_LB"; 0; 0; $or-$wr; $ob-$wb)
		
		LSS_SetPrevNextButtons(LSS_InventoryRow_L; Records in selection:C76([LSS_Inventory:165]))
		REDRAW:C174(Inspection_LB)
		LISTBOX SELECT ROW:C912(*; "Inspection_LB"; LSS_InspectionRow_L)
		
		OBJECT SET SCROLL POSITION:C906(*; "Inspection_LB"; LSS_InspectionRow_L)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Records in set:C195("ListboxSet0")<2)
			C_LONGINT:C283($LBCol_L)
			
			LSS_SelectInpsectionInputForm(->$InputForm_txt; ->LSS_InspectionRow_L)
			
			If (LSS_InspectionRow_L>0)
				OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection@"; False:C215)
				If (Current user:C182="Designer")
					OBJECT SET ENABLED:C1123(LSS_ExportInspection_L; True:C214)
					OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection@"; True:C214)
					
				End if 
				OBJECT SET VISIBLE:C603(*; "LSS_Edit_L"; True:C214)
				OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; True:C214)
				OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
				If (LSS_AllowInspectionEdit_B) | (User in group:C338(Current user:C182; "Design Access Group"))
					OBJECT SET ENABLED:C1123(*; "LSS_Edit_L"; True:C214)
					
					OBJECT SET TITLE:C194(*; "LSS_Edit_L"; "Edit")
				Else 
					OBJECT SET ENABLED:C1123(*; "LSS_Edit_L"; True:C214)
					
					OBJECT SET TITLE:C194(*; "LSS_Edit_L"; "Display")
				End if 
				
				If ((LSS_AllowNewInspection_b & ([LSS_Inspection:164]LSS_Approved_L:43=BMS Approved)) | (User in group:C338(<>CurrentUser_Name; "Design Access Group")))
					OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; True:C214)
					OBJECT SET ENABLED:C1123(*; "LSS_Duplicate_L"; True:C214)
					
					OBJECT SET TITLE:C194(*; "LSS_Duplicate_L"; "Duplicate")
				Else 
					OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
				End if 
				LSS_SetUpReviewButton
				
			Else 
				OBJECT SET VISIBLE:C603(*; "LSS_Edit_L"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection_L"; False:C215)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*; "LSS_Edit_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; True:C214)
			OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
			OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection_L"; False:C215)
			
		End if 
		
End case 
