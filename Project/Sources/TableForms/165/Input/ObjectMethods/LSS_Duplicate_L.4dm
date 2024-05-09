
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/23/14, 15:22:36
// ----------------------------------------------------
// Method: Object Method: [LSS_Inventory];"Input".Duplicate button
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	
	// Modified by: manousakisc-(Designer)-(3/19/2024 18:06:15)
	Mods_2024_03_bug
	//  `disabled all calls related to activity log
	
	// Modified by: Costas Manousakis-(Designer)-(2024-04-10 13:35:21)
	Mods_2024_LSS_1
	//  `initialize the contract and assignment number
	
End if 

C_LONGINT:C283($LBCol_L; $LBRow_L; $Key_L; $Loop_L; $InnerLoop_L)


LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; $LBRow_L)
If ($LBRow_L>0)
	
	If (Not:C34(LSS_AllowInspectionEdit_B) | (User in group:C338(Current user:C182; "Design Access Group")))
		CONFIRM:C162("Do you "+Current user:C182+" want to duplicate the inspection")
		If (OK=1)
			LSS_AllowInspectionEdit_B:=True:C214
			C_TEXT:C284($QueryBy_txt)
			$QueryBy_txt:=""
			Case of 
				: ([LSS_Inventory:165]LSS_Category_s:2="Sign") | ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
					$QueryBy_txt:="HS"
				: ([LSS_Inventory:165]LSS_Category_s:2="Light") | ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
					$QueryBy_txt:="LI"
				: ([LSS_Inventory:165]LSS_Category_s:2="Signal") | ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
					$QueryBy_txt:="SI"
					
				: ([LSS_Inventory:165]LSS_Category_s:2="ITS") | ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
					$QueryBy_txt:="IT"
					
			End case 
			$QueryBy_txt:=$QueryBy_txt+"%"
			ARRAY TEXT:C222($Description_atxt; 0)
			CLEAR VARIABLE:C89($Description_atxt)
			ARRAY TEXT:C222($Key_atxt; 0)
			CLEAR VARIABLE:C89($Key_atxt)
			Begin SQL
				select [LSS_refInspectionType].[LSS_Description_txt],
				[LSS_refInspectionType].[LSS_InspectionTypeId_s]
				from 
				[LSS_refInspectionType]
				where [LSS_refInspectionType].[LSS_InspectionTypeId_s] like :$QueryBy_txt
				into :$Description_atxt,
				:$Key_atxt;
				
				
			End SQL
			
			// start of Mods_2024_03_bug
			// end of Mods_2024_03_bug
			
			C_TEXT:C284($Category_txt)
			
			If (Not:C34(In transaction:C397))
				START TRANSACTION:C239
			End if 
			LOAD RECORD:C52([LSS_Inspection:164])
			C_LONGINT:C283($Position_L)
			C_TEXT:C284($NewInspectionTypeID_txt)
			$NewInspectionTypeID_txt:=[LSS_Inspection:164]LSS_InspectionTypeId_s:3
			$Position_L:=Find in array:C230($Key_atxt; [LSS_Inspection:164]LSS_InspectionTypeId_s:3)
			If ($Description_atxt{$Position_L}="Initial@")
				$Position_L:=Find in array:C230($Description_atxt; "Routine@")
				If ($Position_L>0)
					$NewInspectionTypeID_txt:=$Key_atxt{$Position_L}
				End if 
			End if 
			If ($Position_L>0)
				C_TEXT:C284($ErrorMethodCalled_txt)
				$ErrorMethodCalled_txt:=Method called on error:C704
				ON ERR CALL:C155("LSS_ErrorMethod")
				v_164_001_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
				C_LONGINT:C283($Key_L)
				SHORT_MESSAGE("Copying Inspection...")
				Inc_Sequence("LSS_InspectionId_s"; ->$Key_L)
				DUPLICATE RECORD:C225([LSS_Inspection:164])
				[LSS_Inspection:164]LSS_InspectionDate_d:4:=Current date:C33
				[LSS_Inspection:164]LSS_CreatedBy_s:45:=Current user:C182
				[LSS_Inspection:164]LSS_CreatedISODate_s:46:=ISODateTime(Current date:C33(*); Current time:C178(*))
				[LSS_Inspection:164]LSS_InspectionId_s:1:=String:C10($Key_L; <>KeyMask_s)
				[LSS_Inspection:164]LSS_InspectionTypeId_s:3:=$NewInspectionTypeID_txt
				[LSS_Inspection:164]LSS_ConsultantName_txt:10:=<>PERS_MyCompany_txt
				[LSS_Inspection:164]LSS_ModifiedBy_s:47:=""
				[LSS_Inspection:164]LSS_ModifiedISODate_s:48:=""
				[LSS_Inspection:164]LSS_Approved_L:43:=0
				[LSS_Inspection:164]LSS_ApprovedDate_d:44:=!00-00-00!
				[LSS_Inspection:164]LSS_Complete_b:39:=False:C215
				[LSS_Inspection:164]LSS_CompleteDate_d:40:=!00-00-00!
				[LSS_Inspection:164]LSS_DateOfPhotos_d:30:=!00-00-00!
				[LSS_Inspection:164]LSS_Photos_b:29:=False:C215
				[LSS_Inspection:164]LSS_ReviewDate_d:42:=!00-00-00!
				[LSS_Inspection:164]LSS_Reviewed_L:41:=0
				//start of Mods_2024_LSS_1
				[LSS_Inspection:164]LSS_ContractNo_L:60:=0
				[LSS_Inspection:164]LSS_AssignmentNo_L:61:=0
				//end of Mods_2024_LSS_1
				[LSS_Inspection:164]LSS_CondFoundationPrev_s:13:=[LSS_Inspection:164]LSS_CondFoundationCurr_s:12
				[LSS_Inspection:164]LSS_CondLuminairePrev_s:23:=[LSS_Inspection:164]LSS_CondLuminaireCurr_s:22
				[LSS_Inspection:164]LSS_CondOverallPrev_s:25:=[LSS_Inspection:164]LSS_CondOverallCurr_s:24
				[LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19:=[LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18
				[LSS_Inspection:164]LSS_CondStructurePrev_s:15:=[LSS_Inspection:164]LSS_CondStructureCurr_s:14
				[LSS_Inspection:164]LSS_CondTrafficSafetyPrev_s:21:=[LSS_Inspection:164]LSS_CondTrafficSafetyPrev_s:21
				[LSS_Inspection:164]LSS_StructAttachmentsPrev_s:17:=[LSS_Inspection:164]LSS_StructAttachmentsCurr_s:16
				
				LSS_SetPersonnel
				[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=0
				If (GRP_UserInGroup("LSS_TeamLeader"; <>CurrentUser_PID)=1)
					[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=<>CurrentUser_PID
				End if 
				C_LONGINT:C283($currentPM_L)
				$currentPM_L:=[LSS_Inspection:164]LSS_ProjectManagerId_L:9
				If (Size of array:C274(LSS_ProjManagers_atxt)>0)
					If (Find in array:C230(LSS_ProjManagerIDs_aL; $currentPM_L)>0)
						
					Else 
						[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=LSS_ProjManagerIDs_aL{1}
					End if 
					
				Else 
					[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=0
				End if 
				
				// start of Mods_2024_03_bug
				// end of Mods_2024_03_bug
				
				SAVE RECORD:C53([LSS_Inspection:164])
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_InspectionId_s:3=v_164_001_txt)
				If (Records in selection:C76([LSS_Accessibility:159])>0)
					MESSAGE:C88(Char:C90(13)+String:C10(Records in selection:C76([LSS_Accessibility:159]))+" Accessibility Items...")
				End if 
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_Accessibility:159]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_Accessibility:159]))
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					
					GOTO RECORD:C242([LSS_Accessibility:159]; $RecordNumbers_aL{$Loop_l})
					DUPLICATE RECORD:C225([LSS_Accessibility:159])
					[LSS_Accessibility:159]LSS_InspectionId_s:3:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					Inc_Sequence("LSS_AccessibilityId_s"; ->$Key_L)
					[LSS_Accessibility:159]LSS_AccessibilityId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					
					SAVE RECORD:C53([LSS_Accessibility:159])
					// end of Mods_2024_03_bug
				End for 
				
				
				QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=v_164_001_txt)
				If (Records in selection:C76([LSS_DMeter:161])>0)
					MESSAGE:C88(Char:C90(13)+"D Meter...")
				End if 
				
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_DMeter:161]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_DMeter:161]))
					
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					GOTO RECORD:C242([LSS_DMeter:161]; $RecordNumbers_aL{$Loop_l})
					DUPLICATE RECORD:C225([LSS_DMeter:161])
					[LSS_DMeter:161]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					
					Inc_Sequence("LSS_DMeterId_s"; ->$Key_L)
					[LSS_DMeter:161]LSS_DMeterId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					SAVE RECORD:C53([LSS_DMeter:161])
					// end of Mods_2024_03_bug
				End for 
				
				QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=v_164_001_txt)
				If (Records in selection:C76([LSS_ElementInspection:163])>0)
					MESSAGE:C88(Char:C90(13)+String:C10(Records in selection:C76([LSS_ElementInspection:163]))+" Inspection Elements...")
				End if 
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_ElementInspection:163]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_ElementInspection:163]))
					MESSAGE:C88(String:C10($Loop_l; " #####..."))
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					GOTO RECORD:C242([LSS_ElementInspection:163]; $RecordNumbers_aL{$Loop_l})
					DUPLICATE RECORD:C225([LSS_ElementInspection:163])
					[LSS_ElementInspection:163]LSS_InspectionId_s:3:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					
					Inc_Sequence("LSS_ElementInspectionId_s"; ->$Key_L)
					[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					SAVE RECORD:C53([LSS_ElementInspection:163])
					// end of Mods_2024_03_bug
				End for 
				
				
				QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=v_164_001_txt)
				If (Records in selection:C76([LSS_Photos:166])>0)
					MESSAGE:C88(Char:C90(13)+String:C10(Records in selection:C76([LSS_Photos:166]))+" Images...")
				End if 
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_Photos:166]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_Photos:166]))
					MESSAGE:C88(String:C10($Loop_l; " #####..."))
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					GOTO RECORD:C242([LSS_Photos:166]; $RecordNumbers_aL{$Loop_l})
					DUPLICATE RECORD:C225([LSS_Photos:166])
					[LSS_Photos:166]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					
					Inc_Sequence("LSS_PhotoId_s"; ->$Key_L)
					[LSS_Photos:166]LSS_PhotoId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					SAVE RECORD:C53([LSS_Photos:166])
					// end of Mods_2024_03_bug
				End for 
				
				
				QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_InspectionId_s:2=v_164_001_txt)
				If (Records in selection:C76([LSS_SignPanel:172])>0)
					MESSAGE:C88(Char:C90(13)+String:C10(Records in selection:C76([LSS_SignPanel:172]))+" Sign Panels...")
				End if 
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_SignPanel:172]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_SignPanel:172]))
					MESSAGE:C88(String:C10($Loop_l; " #####..."))
					
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					GOTO RECORD:C242([LSS_SignPanel:172]; $RecordNumbers_aL{$Loop_l})
					DUPLICATE RECORD:C225([LSS_SignPanel:172])
					[LSS_SignPanel:172]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					
					Inc_Sequence("LSS_SignPanelId_s"; ->$Key_L)
					[LSS_SignPanel:172]LSS_SignPanelId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					SAVE RECORD:C53([LSS_SignPanel:172])
					// end of Mods_2024_03_bug
				End for 
				
				QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_InspectionId_s:2=v_164_001_txt)
				If (Records in selection:C76([LSS_TowerDistance:174])>0)
					MESSAGE:C88(Char:C90(13)+String:C10(Records in selection:C76([LSS_TowerDistance:174]))+" Tower Distances...")
				End if 
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_TowerDistance:174]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_TowerDistance:174]))
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					GOTO RECORD:C242([LSS_TowerDistance:174]; $RecordNumbers_aL{$Loop_l})
					DUPLICATE RECORD:C225([LSS_TowerDistance:174])
					[LSS_TowerDistance:174]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					
					Inc_Sequence("LSS_TowerDistanceId_s"; ->$Key_L)
					[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					SAVE RECORD:C53([LSS_TowerDistance:174])
					// end of Mods_2024_03_bug
				End for 
				
				QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=v_164_001_txt)
				If (Records in selection:C76([LSS_UT:175])>0)
					MESSAGE:C88(Char:C90(13)+String:C10(Records in selection:C76([LSS_UT:175]))+" UT Tests...")
				End if 
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_UT:175]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_UT:175]))
					MESSAGE:C88(String:C10($Loop_l; " #####..."))
					
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					GOTO RECORD:C242([LSS_UT:175]; $RecordNumbers_aL{$Loop_l})
					v_175_001_txt:=[LSS_UT:175]LSS_UTId_s:1
					DUPLICATE RECORD:C225([LSS_UT:175])
					[LSS_UT:175]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					
					Inc_Sequence("LSS_UTId_s"; ->$Key_L)
					[LSS_UT:175]LSS_UTId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					SAVE RECORD:C53([LSS_UT:175])
					// end of Mods_2024_03_bug
					QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=v_175_001_txt)
					ARRAY LONGINT:C221($RecordNumbers1_aL; 0)
					LONGINT ARRAY FROM SELECTION:C647([LSS_UtResult:176]; $RecordNumbers1_aL)
					For ($InnerLoop_l; 1; Records in selection:C76([LSS_UtResult:176]))
						// start of Mods_2024_03_bug
						// end of Mods_2024_03_bug
						GOTO RECORD:C242([LSS_UtResult:176]; $RecordNumbers1_aL{$InnerLoop_l})
						DUPLICATE RECORD:C225([LSS_UtResult:176])
						[LSS_UtResult:176]LSS_UTId_s:2:=[LSS_UT:175]LSS_UTId_s:1
						C_LONGINT:C283($Key_L)
						
						Inc_Sequence("LSS_UTResultId_s"; ->$Key_L)
						[LSS_UtResult:176]LSS_UTResultId_s:1:=String:C10($Key_L; <>KeyMask_s)
						
						// start of Mods_2024_03_bug
						SAVE RECORD:C53([LSS_UtResult:176])
						// end of Mods_2024_03_bug
						
					End for 
				End for 
				
				QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_InspectionId_s:2=v_164_001_txt)
				If (Records in selection:C76([LSS_VerticalClearance:177])>0)
					MESSAGE:C88(Char:C90(13)+"Vertical Clearances...")
				End if 
				ARRAY LONGINT:C221($RecordNumbers_aL; 0)
				LONGINT ARRAY FROM SELECTION:C647([LSS_VerticalClearance:177]; $RecordNumbers_aL)
				For ($Loop_l; 1; Records in selection:C76([LSS_VerticalClearance:177]))
					MESSAGE:C88(String:C10($Loop_l; " #####..."))
					// start of Mods_2024_03_bug
					// end of Mods_2024_03_bug
					GOTO RECORD:C242([LSS_VerticalClearance:177]; $RecordNumbers_aL{$Loop_l})
					DUPLICATE RECORD:C225([LSS_VerticalClearance:177])
					[LSS_VerticalClearance:177]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
					C_LONGINT:C283($Key_L)
					
					Inc_Sequence("LSS_VerticalClearanceId_s"; ->$Key_L)
					[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1:=String:C10($Key_L; <>KeyMask_s)
					
					// start of Mods_2024_03_bug
					SAVE RECORD:C53([LSS_VerticalClearance:177])
					// end of Mods_2024_03_bug
				End for 
				CLOSE WINDOW:C154
			Else 
				ALERT:C41("You may not duplicate this inspection as there is a problem with the inspection type!")
				UNLOAD RECORD:C212([LSS_Inspection:164])
				CANCEL TRANSACTION:C241
			End if 
			If (In transaction:C397)
				VALIDATE TRANSACTION:C240
				START TRANSACTION:C239
			End if 
			C_TEXT:C284($NewInspID_txt)
			$NewInspID_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
			
			LSS_InitChangeStacks
			LSS_SelectInspectionsForInvItem
			LSS_SetPrevNextButtons(LSS_InventoryRow_L; Records in selection:C76([LSS_Inventory:165]))
			ARRAY TEXT:C222($InspIDS_atxt; 0)
			SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $InspIDS_atxt)
			
			LSS_InspectionRow_L:=Find in array:C230($InspIDS_atxt; $NewInspID_txt)
			LISTBOX SELECT ROW:C912(*; "Inspection_LB"; LSS_InspectionRow_L)
			OBJECT SET SCROLL POSITION:C906(*; "Inspection_LB"; LSS_InspectionRow_L)
			ON ERR CALL:C155($ErrorMethodCalled_txt)
		End if 
		
	End if 
End if 