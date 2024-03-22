//%attributes = {"invisible":true}
//Method: LSS_ImportInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/10/16, 11:41:47
	//----------------------------------------------------
	Mods_2016_03_bug  // 
	//Modified by: administrator (3/10/16 11:41:48)
	// Modified by: Costas Manousakis-(Designer)-(12/21/20 16:40:54)
	Mods_2020_12_bug
	// make sure the inspection inventory ID matches the current Inv ID in addition to the structure number
	
End if 
C_BOOLEAN:C305($vImport_B)
CONFIRM:C162("Import inspection for structure: "+[LSS_Inventory:165]LSS_StructureNumber_s:6)
$vImport_B:=(OK=1)

If ($vImport_B)
	SET CHANNEL:C77(10; "")
	C_TEXT:C284($TypeOfExport_txt; $StructureExported_txt; $InspectionID_txt)
	RECEIVE VARIABLE:C81($TypeOfExport_txt)
	If ($TypeOfExport_txt="LSS_Inspection")
		RECEIVE VARIABLE:C81($StructureExported_txt)
		If ($StructureExported_txt=[LSS_Inventory:165]LSS_StructureNumber_s:6)
			RECEIVE VARIABLE:C81($InspectionID_txt)
			QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=$InspectionID_txt)
			C_BOOLEAN:C305($Replace_B; $RecordFound_B; $CreateNewIDs_B; $Proceed_B)
			$Replace_B:=True:C214
			$RecordFound_B:=False:C215
			$CreateNewIDs_B:=False:C215
			$Proceed_B:=True:C214
			If (In transaction:C397)
				FM_SaveInventoryInput
			End if 
			If (Records in selection:C76([LSS_Inspection:164])=1)
				$RecordFound_B:=True:C214
				CONFIRM:C162("Do you want to replace or create a new inspection"; "Replace"; "Create New")
				$Replace_B:=(OK=1)
				If ($Replace_B)
					C_LONGINT:C283($Choice_L)
					
					START TRANSACTION:C239
					ONE RECORD SELECT:C189([LSS_Inspection:164])
					$Choice_L:=ut_LoadRecordInteractiveV2(->[LSS_Inspection:164])
					If ($Choice_L=1)
						ut_SetReadWrite("Write"; ->[LSS_Inspection:164]; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
						ut_SetReadWrite("Write"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
						
						If (Not:C34(LSS_ControlDeleteOfInspection))
							VALIDATE TRANSACTION:C240
							ALERT:C41("Inspection record deleted")
						Else 
							CANCEL TRANSACTION:C241
							$Proceed_B:=False:C215
						End if 
					Else 
						$Proceed_B:=False:C215
					End if 
				Else 
					$CreateNewIDs_B:=True:C214
				End if 
			End if 
			If ($Proceed_B)
				ALERT:C41("Begin import of LSS Inspection record")
				
				START TRANSACTION:C239
				RECEIVE RECORD:C79([LSS_Inspection:164])
				If ($CreateNewIDs_B)
					C_LONGINT:C283($ID_L)
					
					Inc_Sequence("LSS_InspectionId_s"; ->$ID_L)
					[LSS_Inspection:164]LSS_InspectionId_s:1:=String:C10($ID_L; <>KeyMask_s)
					
				End if 
				[LSS_Inspection:164]LSS_InventoryId_s:2:=[LSS_Inventory:165]LSS_InventoryId_s:1
				SAVE RECORD:C53([LSS_Inspection:164])
				C_TEXT:C284($NewInspID_txt)
				
				$NewInspID_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
				LSS_ReceiveRecords($CreateNewIDs_B)
				
				VALIDATE TRANSACTION:C240
				START TRANSACTION:C239
				LSS_InitChangeStacks
				LSS_SelectInspectionsForInvItem
				LSS_SetPrevNextButtons(LSS_InventoryRow_L; Records in selection:C76([LSS_Inventory:165]))
				ARRAY TEXT:C222($InspIDS_atxt; 0)
				SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $InspIDS_atxt)
				
				LSS_InspectionRow_L:=Find in array:C230($InspIDS_atxt; $NewInspID_txt)
				LISTBOX SELECT ROW:C912(*; "Inspection_LB"; LSS_InspectionRow_L)
				OBJECT SET SCROLL POSITION:C906(*; "Inspection_LB"; LSS_InspectionRow_L)
				ALERT:C41("Import of LSS Inspection record completed")
			End if 
		Else 
			ALERT:C41("You have a selected to import structure number "+$StructureExported_txt+" You must be in structure to perform import")
		End if 
		
	End if 
	
	SET CHANNEL:C77(11)
End if 
//End LSS_ImportInspection