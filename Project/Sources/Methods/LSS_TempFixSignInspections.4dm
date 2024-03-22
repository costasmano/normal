//%attributes = {"invisible":true}
//Method: LSS_TempFixSignInspections
//Description
// temp method to fix Sign "HS" inspections because the wrong field was being used
// for the Sign Panel & Illumination rating (was  [LSS_Inspection]LSS_CondLuminaire
// should be [LSS_Inspection]LSS_CondSignPanels
// find all inspections that are for HS type structures and NOT imported (inspID # "IMPORT@"
// set [LSS_Inspection]LSS_CondSignPanels=[LSS_Inspection]LSS_CondLuminaire
// and Log changes
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/24/16, 17:30:51
	// ----------------------------------------------------
	//Created : 
	Mods_2016_02_bug
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	CONFIRM:C162("Run this method which sets  [LSS_Inspection]LSS_CondSignPanels=[LSS_Inspection]LSS_CondLuminaire ?"; "Run"; "Cancel")
	If (OK=1)
		QUERY:C277([LSS_Inspection:164]; [LSS_Inventory:165]LSS_InventoryType_s:28="HS"; *)
		QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1#"IMPORT@")
		C_LONGINT:C283($InspRecs_L; $RecordsMod_L)
		$InspRecs_L:=Records in selection:C76([LSS_Inspection:164])
		$RecordsMod_L:=0
		CONFIRM:C162("Found "+String:C10($InspRecs_L)+" inspection records. Continue?"; "Yes"; "Cancel")
		If (OK=1)
			If (Type:C295(ptr_Changes)#Array 2D:K8:24)
				ARRAY POINTER:C280(ptr_Changes; 0; 0)
			End if 
			FIRST RECORD:C50([LSS_Inspection:164])
			SHORT_MESSAGE("Inspection "+[LSS_Inspection:164]LSS_InspectionId_s:1)
			While (Not:C34(End selection:C36([LSS_Inspection:164])))
				If (ut_LoadRecordInteractive(->[LSS_Inspection:164]))
					MESSAGE:C88(Char:C90(13)+"Inspection "+[LSS_Inspection:164]LSS_InspectionId_s:1)
					InitChangeStack(1)
					If ([LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18="")
						If ([LSS_Inspection:164]LSS_CondLuminaireCurr_s:22#"")
							[LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18:=[LSS_Inspection:164]LSS_CondLuminaireCurr_s:22
						End if 
					End if 
					If ([LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19="")
						If ([LSS_Inspection:164]LSS_CondLuminairePrev_s:23#"")
							[LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19:=[LSS_Inspection:164]LSS_CondLuminairePrev_s:23
						End if 
					End if 
					
					If ([LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18#Old:C35([LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18))
						PushChange(1; ->[LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18)
					End if 
					If ([LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19#Old:C35([LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19))
						PushChange(1; ->[LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19)
					End if 
					If (Modified record:C314([LSS_Inspection:164]))
						$RecordsMod_L:=$RecordsMod_L+1
					End if 
					FlushGrpChgs(1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; 0)
					SAVE RECORD:C53([LSS_Inspection:164])
					
				End if 
				NEXT RECORD:C51([LSS_Inspection:164])
				
			End while 
			CLOSE WINDOW:C154
			ALERT:C41("Scanned "+String:C10($InspRecs_L)+" inspection records; Modified "+String:C10($RecordsMod_L)+"!")
			
		End if 
	End if 
End if 
//End LSS_TempFixSignInspections