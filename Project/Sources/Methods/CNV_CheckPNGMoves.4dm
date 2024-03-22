//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/16/16, 12:20:06
//----------------------------------------------------
//Method: CNV_CheckPNGMoves
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_08  // 
	//Modified by: Chuck Miller (8/16/16 12:20:17)
	
End if 
ARRAY TEXT:C222($Files_atxt; 0)
C_TEXT:C284($BlobDocumentPath_txt; $PNGDocumentPath_txt)
$BlobDocumentPath_txt:=Select document:C905(""; ""; "Select Combined Blob Document"; Multiple files:K24:7; $Files_atxt)
$BlobDocumentPath_txt:=$Files_atxt{1}
If (Test path name:C476($BlobDocumentPath_txt)=Is a document:K24:1)
	ARRAY TEXT:C222($Files_atxt; 0)
	C_LONGINT:C283($Offset_L)
	$PNGDocumentPath_txt:=Select document:C905(""; ""; "Select PNG Moved Document"; Multiple files:K24:7; $Files_atxt)
	$PNGDocumentPath_txt:=$Files_atxt{1}
	If (Test path name:C476($PNGDocumentPath_txt)=Is a document:K24:1)
		ARRAY TEXT:C222($Paths_atxt; 0)
		ARRAY TEXT:C222($PictureExtension_atxt; 0)
		ARRAY LONGINT:C221($InspectionIDs_aL; 0)
		ARRAY LONGINT:C221($PhotoIDs_aL; 0)
		
		DOCUMENT TO BLOB:C525($BlobDocumentPath_txt; $Exported_blb)
		$Offset_L:=0
		BLOB TO VARIABLE:C533($Exported_blb; $Paths_atxt; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $InspectionIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $PhotoIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $PictureExtension_atxt; $Offset_L)
		
		DOCUMENT TO BLOB:C525($PNGDocumentPath_txt; $Exported_blb)
		$Offset_L:=0
		ARRAY TEXT:C222($ProcessedPaths_atxt; 0)
		ARRAY LONGINT:C221($ProcessedInspectionIDs_aL; 0)
		ARRAY LONGINT:C221($ProcessedPhotoIDs_aL; 0)
		ARRAY TEXT:C222($ProcessedPictureExtension_atxt; 0)
		
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPaths_atxt; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedInspectionIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPhotoIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPictureExtension_atxt; $Offset_L)
		C_BOOLEAN:C305($Changes_B)
		C_TEXT:C284($ChangesMade_txt)
		$Changes_B:=False:C215
		C_LONGINT:C283($Loop_L)
		For ($Loop_L; 1; Size of array:C274($ProcessedPaths_atxt))
			If (Find in array:C230($PhotoIDs_aL; $ProcessedPhotoIDs_aL{$Loop_L})>0)
				
				
				
			Else 
				$Changes_B:=True:C214
				APPEND TO ARRAY:C911($Paths_atxt; $ProcessedPaths_atxt{$Loop_L})
				APPEND TO ARRAY:C911($InspectionIDs_aL; $ProcessedInspectionIDs_aL{$Loop_L})
				APPEND TO ARRAY:C911($PhotoIDs_aL; $ProcessedPhotoIDs_aL{$Loop_L})
				APPEND TO ARRAY:C911($PictureExtension_atxt; "PNG")
				$ChangesMade_txt:=$ChangesMade_txt+$ProcessedPaths_atxt{$Loop_L}+Char:C90(Tab:K15:37)
				$ChangesMade_txt:=$ChangesMade_txt+String:C10($ProcessedInspectionIDs_aL{$Loop_L})+Char:C90(Tab:K15:37)
				$ChangesMade_txt:=$ChangesMade_txt+String:C10($ProcessedPhotoIDs_aL{$Loop_L})+Char:C90(Tab:K15:37)
				$ChangesMade_txt:=$ChangesMade_txt+$ProcessedPictureExtension_atxt{$Loop_L}+Char:C90(Carriage return:K15:38)
				
			End if 
		End for 
		If ($Changes_B)
			C_TIME:C306($Doc_tm)
			$Doc_tm:=Create document:C266("")
			SEND PACKET:C103($Doc_tm; $ChangesMade_txt)
			CLOSE DOCUMENT:C267($Doc_tm)
			SET BLOB SIZE:C606($Exported_blb; 0)
			VARIABLE TO BLOB:C532($Paths_atxt; $Exported_blb; *)
			VARIABLE TO BLOB:C532($InspectionIDs_aL; $Exported_blb; *)
			VARIABLE TO BLOB:C532($PhotoIDs_aL; $Exported_blb; *)
			VARIABLE TO BLOB:C532($PictureExtension_atxt; $Exported_blb; *)
			BLOB TO DOCUMENT:C526($BlobDocumentPath_txt; $Exported_blb)
			
			
		End if 
		
	End if 
End if 
//End CNV_CheckPNGMoves

