//%attributes = {"invisible":true}
//Method: NTI_ListInspImages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/16, 17:14:32
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
QUERY:C277([TIN_Insp_Images:186]; [TIN_Insp_Images:186]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
NTI_UpdateNextImgSeq
ORDER BY:C49([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5; >; [TIN_Insp_Images:186]SequenceNum:6; >)

//End NTI_ListInspImages