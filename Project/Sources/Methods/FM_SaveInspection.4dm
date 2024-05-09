//%attributes = {"invisible":true}
// Method: FM_SaveInspection
// Description
// Save an LSS Inspection report
// Parameters
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 09/11/14, 16:26:16
	// ----------------------------------------------------
	Mods_2015_08_bug  //Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 16:00:19)
	Mods_2016_02_bug  // Added short message when saving and updarting picture sequences
	//Modified by: administrator (2/9/16 17:29:36)
	Mods_2020_01_bug  //Modfied way lss pictures are resequenced to follow model on tin images 
	//Modified by: CJ (1/23/20 16:35:21
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 18:32:41)
	Mods_2020_04
	//  `execute the image sorting method in the subform.
	// Modified by: Costas Manousakis-(Designer)-(2024-03-07 13:26:13)
	Mods_2024_LSS_1
	//  `update next sched inspection date if the insp date # 0 (date cannot be future date) 
	//  `and insp type=@1 or @2(initial or routine)
	//  ` also make structure active if it is not
	
End if 
If (LSS_PhotoUpdateSeq_b)
	
	If (False:C215)
		LSS_ResequenceInspPhotos
		
	Else 
		EXECUTE METHOD IN SUBFORM:C1085("LSSImagesSubForm"; "NTI_ApplyImageSort")
	End if 
End if 

If (Modified record:C314([LSS_Inspection:164]))
	LSS_InspectionRecSave  //modif 6/15/15 - moved code into new method LSS_InspectionRecSave
End if 

//If (LSS_PhotoUpdateSeq_b)
//SHORT_MESSAGE ("Saving New Photo Sequences....")
//LSS_ResequencePictures ("Save")
//CLOSE WINDOW
//End if 

LSS_AccessibilitySave  // moved code into new method LSS_AccessibilitySave

//start of Mods_2024_LSS_1

If ([LSS_Inspection:164]LSS_ContractNo_L:60>0) & ([LSS_Inspection:164]LSS_AssignmentNo_L:61=0)
	ALERT:C41("Saving Inspection without an Assignment Number! Please correct!")
End if 

//update next sched insp date on inventory record if insp date > 0 and insp type = 01 or 02
//     ignore if inspection has been marked as completed
//also set status to Active if it is proposed
If ([LSS_Inspection:164]LSS_InspectionDate_d:4>!00-00-00!) & \
([LSS_Inspection:164]LSS_InspectionDate_d:4<=Current date:C33) & \
(([LSS_Inspection:164]LSS_InspectionTypeId_s:3="@1") | ([LSS_Inspection:164]LSS_InspectionTypeId_s:3="@2"))
	
	//check if the next sched will not change
	C_BOOLEAN:C305($updateInv_b)
	C_LONGINT:C283($cycle_L)
	$cycle_L:=[LSS_Inventory:165]LSS_Cycle_L:39
	If ($cycle_L=0)
		//set to default - and mark to update
		//$Cycle_L:=Num(ut_GetSysParameter ("LSS_DefaultCycle";"4"))
		$cycle_L:=Storage:C1525.LSS_defaultcycle.value
		$updateInv_b:=True:C214
	End if 
	
	C_DATE:C307($newDate_d)  //
	$newDate_d:=[LSS_Inventory:165]LSS_NextSchedInsp_d:40
	If ([LSS_Inventory:165]LSS_NextSchedInsp_d:40#Add to date:C393([LSS_Inspection:164]LSS_InspectionDate_d:4; $Cycle_L; 0; 0))
		//need to update date
		$newDate_d:=Add to date:C393([LSS_Inspection:164]LSS_InspectionDate_d:4; $Cycle_L; 0; 0)
		$updateInv_b:=True:C214
	End if 
	C_TEXT:C284($status_txt)
	$status_txt:=[LSS_Inventory:165]LSS_Status_s:35
	
	If ([LSS_Inventory:165]LSS_Status_s:35#"Active")
		$status_txt:="Active"
		$updateInv_b:=True:C214
	End if 
	
	
	If ($updateInv_b)
		C_BOOLEAN:C305($autoone; $automany)
		GET AUTOMATIC RELATIONS:C899($autoone; $automany)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		C_BOOLEAN:C305($roInv_b)
		$roInv_b:=Read only state:C362([LSS_Inventory:165])
		If (ut_LoadRecordInteractive(->[LSS_Inventory:165]))
			[LSS_Inventory:165]LSS_Cycle_L:39:=$cycle_L
			[LSS_Inventory:165]LSS_NextSchedInsp_d:40:=$newDate_d
			[LSS_Inventory:165]LSS_Status_s:35:=$status_txt
			SAVE RECORD:C53([LSS_Inventory:165])
			
			If ($roInv_b)
				UNLOAD RECORD:C212([LSS_Inventory:165])
				READ ONLY:C145([LSS_Inventory:165])
				LOAD RECORD:C52([LSS_Inventory:165])
			End if 
			
		Else 
			ALERT:C41("Could not update inventory record for "+[LSS_Inventory:165]LSS_StructureNumber_s:6+"!"+\
				" You can do this at a later time by saving this inspection report")
		End if 
		
		SET AUTOMATIC RELATIONS:C310($autoone; $automany)
		
	End if 
	
	
End if 

//end of Mods_2024_LSS_1


If (LSS_DuplicateRecordError_B | LSS_Error_B)
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	CANCEL:C270
Else 
	If (In transaction:C397)
		VALIDATE TRANSACTION:C240
	End if 
End if 

//End FM_SaveInspection