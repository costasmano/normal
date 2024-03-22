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