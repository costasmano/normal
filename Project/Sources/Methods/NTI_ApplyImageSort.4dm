//%attributes = {"invisible":true}
//Method: NTI_ApplyImageSort
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/16, 15:53:34
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	// Modified by: Costas Manousakis-(Designer)-(4/29/19 13:29:43)
	Mods_2019_04
	//  `changes to allow use of this method in TIN and Bridge inspections
	// Modified by: Costas Manousakis-(Designer)-(1/31/20 17:02:02)
	Mods_2020_01
	//  `changes to allow use in LSS_ inspections
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 13:10:57)
	Mods_2020_04
	//  `added the missing test when called from LSS_Inspection forms
	//  `added setting of LSS_PhotoUpdateSeq_b for LSS
	
End if 
//
C_POINTER:C301($myTable_ptr; $ImgTypeField_ptr; $SeqFldPtr; $InspTblIDField_ptr; $TableInspIDField_ptr; $TableIDField_ptr)
$myTable_ptr:=Current form table:C627
//change table if we are on a 'parent form'
Case of 
	: (Table:C252($myTable_ptr)=Table:C252(->[TIN_Inspections:184]))
		$myTable_ptr:=->[TIN_Insp_Images:186]
		
	: (Table:C252($myTable_ptr)=Table:C252(->[Inspections:27]))
		$myTable_ptr:=->[Standard Photos:36]
		
	: (Table:C252($myTable_ptr)=Table:C252(->[LSS_Inspection:164]))
		$myTable_ptr:=->[LSS_Photos:166]
		
End case 

Case of 
		
	: (Table:C252($myTable_ptr)=Table:C252(->[Standard Photos:36]))
		$ImgTypeField_ptr:=->[Standard Photos:36]PictType:5
		$SeqFldPtr:=->[Standard Photos:36]SeqNum:6
		$InspTblIDField_ptr:=->[Inspections:27]InspID:2
		$TableInspIDField_ptr:=->[Standard Photos:36]InspID:1
		$TableIDField_ptr:=->[Standard Photos:36]StdPhotoID:7
		
	: (Table:C252($myTable_ptr)=Table:C252(->[TIN_Insp_Images:186]))
		$ImgTypeField_ptr:=->[TIN_Insp_Images:186]ImageType:5
		$SeqFldPtr:=->[TIN_Insp_Images:186]SequenceNum:6
		$InspTblIDField_ptr:=->[TIN_Inspections:184]InspectionID:2
		$TableInspIDField_ptr:=->[TIN_Insp_Images:186]InspectionID:1
		$TableIDField_ptr:=->[TIN_Insp_Images:186]ImageID:2
		
	: (Table:C252($myTable_ptr)=Table:C252(->[LSS_Photos:166]))
		$ImgTypeField_ptr:=->[LSS_Photos:166]LSS_PhotoType_s:3
		$SeqFldPtr:=->[LSS_Photos:166]LSS_PhotoSequence_L:6
		$InspTblIDField_ptr:=->[LSS_Inspection:164]LSS_InspectionId_s:1
		$TableInspIDField_ptr:=->[LSS_Photos:166]LSS_InspectionId_s:2
		$TableIDField_ptr:=->[LSS_Photos:166]LSS_PhotoId_s:1
		
End case 

FIRST RECORD:C50($myTable_ptr->)
C_LONGINT:C283($startSeq_L; $RecCount_L)
C_TEXT:C284($StartType_txt)
$startSeq_L:=1
$StartType_txt:=$ImgTypeField_ptr->

//start the bar
C_OBJECT:C1216($Progress_o)
$Progress_o:=ProgressNew("Re-Sequencing Images"; Records in selection:C76($myTable_ptr->); False:C215; "Image"; 3)

$RecCount_L:=1

While (Not:C34(End selection:C36($myTable_ptr->)))
	If (ut_LoadRecordInteractive($myTable_ptr))
		//update progress
		UpdateProgressNew($Progress_o; $RecCount_L)
		
		If ($SeqFldPtr->#$startSeq_L)
			$SeqFldPtr->:=$startSeq_L
			
			If (Table:C252($myTable_ptr)=Table:C252(->[LSS_Photos:166]))
				LogChanges($SeqFldPtr; $TableIDField_ptr; $TableIDField_ptr; $TableIDField_ptr; 0)
				
			Else 
				LogChanges($SeqFldPtr; $InspTblIDField_ptr; $TableInspIDField_ptr; $TableIDField_ptr; 2)
				
			End if 
			
			SAVE RECORD:C53($myTable_ptr->)
		End if 
		NEXT RECORD:C51($myTable_ptr->)
		$RecCount_L:=$RecCount_L+1
		If ($ImgTypeField_ptr->=$StartType_txt)
			//still same type
			$startSeq_L:=$startSeq_L+1
		Else 
			//new type
			$startSeq_L:=1
			$StartType_txt:=$ImgTypeField_ptr->
		End if 
		OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; False:C215)
		NTI_ImageSortNeeded_b:=False:C215
		LSS_PhotoUpdateSeq_b:=False:C215
		
	Else 
		ALERT:C41("Could not complete Re-Sequencing of Images due to a locked Record!")
		LAST RECORD:C200($myTable_ptr->)
		OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; True:C214)
		
	End if 
End while 
//quit progress
Progress QUIT(OB Get:C1224($Progress_o; "progress"; Is longint:K8:6))

C_POINTER:C301($lB_ptr)
$lB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Photos_LB")
REDRAW:C174($lB_ptr->)
OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; False:C215)
//REDRAW WINDOW
//End NTI_ApplyImageSort