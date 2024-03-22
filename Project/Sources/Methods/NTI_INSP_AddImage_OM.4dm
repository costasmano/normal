//%attributes = {"invisible":true}
//Method: NTI_INSP_AddImage_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/16, 11:50:09
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 10:10:23)
	Mods_2016_08_bug
	//  `added READ WRITE([TIN_Insp_Images])
	// Modified by: Costas Manousakis-(Designer)-(9/13/18 10:00:22)
	Mods_2018_09_bug
	//  `added FORM SET INPUT([TIN_Insp_Images];"Input") 
	
End if 
//
ARRAY LONGINT:C221($ImgRecords_aL; 0)
ARRAY INTEGER:C220($ImgSequences_aL; 0)
ARRAY TEXT:C222($imgType_atxt; 0)
SELECTION TO ARRAY:C260([TIN_Insp_Images:186]; $ImgRecords_aL; [TIN_Insp_Images:186]SequenceNum:6; $ImgSequences_aL; [TIN_Insp_Images:186]ImageType:5; $imgType_atxt)
READ WRITE:C146([TIN_Insp_Images:186])
FORM SET INPUT:C55([TIN_Insp_Images:186]; "Input")
ADD RECORD:C56([TIN_Insp_Images:186])

If (OK=1)
	C_TEXT:C284($newType_txt)
	C_LONGINT:C283($newSeq_L; $newID_L; $TypePos_L; $InsertPos_L; $loop_L)
	$newType_txt:=[TIN_Insp_Images:186]ImageType:5
	$newSeq_L:=[TIN_Insp_Images:186]SequenceNum:6
	$newID_L:=Record number:C243([TIN_Insp_Images:186])
	$TypePos_L:=Find in array:C230($imgType_atxt; $newType_txt)
	$InsertPos_L:=Size of array:C274($imgType_atxt)+1  //assume at bottom
	If ($TypePos_L>0)
	Else 
		//a new type
		$TypePos_L:=1  //start from the top
	End if 
	For ($loop_L; $TypePos_L; Size of array:C274($imgType_atxt))
		If ($imgType_atxt{$loop_L}>$newType_txt)
			$InsertPos_L:=$loop_L
			$loop_L:=Size of array:C274($imgType_atxt)+1
		End if 
	End for 
	INSERT IN ARRAY:C227($ImgRecords_aL; $InsertPos_L)
	$ImgRecords_aL{$InsertPos_L}:=$newID_L
	CREATE SELECTION FROM ARRAY:C640([TIN_Insp_Images:186]; $ImgRecords_aL)
	//QUERY WITH ARRAY([TIN_Insp_Images]ImageID;$ImgRecords_aL)
	NTI_UpdateNextImgSeq
	//NTI_ListInspImages 
End if 
ARRAY LONGINT:C221($ImgRecords_aL; 0)
ARRAY INTEGER:C220($ImgSequences_aL; 0)
ARRAY TEXT:C222($imgType_atxt; 0)

//End NTI_INSP_AddImage_OM