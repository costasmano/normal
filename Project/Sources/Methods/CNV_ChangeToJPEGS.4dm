//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/15/16, 12:02:44
//----------------------------------------------------
//Method: CNV_ChangeToJPEGS
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_08  // 
	//Modified by: Chuck Miller (8/15/16 12:02:45)
	
End if 
C_TEXT:C284($NewFolderPath_txt; $BlobDocumentPath_txt; $ProcessedDocumentPath_txt)
ARRAY TEXT:C222($Files_atxt; 0)
$BlobDocumentPath_txt:=Select document:C905(""; ""; "Select Combined Blob Document"; Multiple files:K24:7; $Files_atxt)
$BlobDocumentPath_txt:=$Files_atxt{1}
C_PICTURE:C286($Picture_pct)
C_BLOB:C604($NewPicture_blb)
C_TIME:C306($StartTime_tm; $RemainingTime_tm; $Elapsed_tm)
If (Test path name:C476($BlobDocumentPath_txt)=Is a document:K24:1)
	
	ARRAY TEXT:C222($Paths_atxt; 0)
	ARRAY LONGINT:C221($InspectionIDs_aL; 0)
	ARRAY LONGINT:C221($PhotoIDs_aL; 0)
	ARRAY TEXT:C222($PictureExtension_atxt; 0)
	C_BLOB:C604($Exported_blb)
	C_LONGINT:C283($Offset_L; $size_L)
	C_TEXT:C284($PhotoID_txt)
	DOCUMENT TO BLOB:C525($BlobDocumentPath_txt; $Exported_blb)
	$Offset_L:=0
	BLOB TO VARIABLE:C533($Exported_blb; $Paths_atxt; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $InspectionIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PhotoIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PictureExtension_atxt; $Offset_L)
	C_LONGINT:C283($ImportLoop_L; $Position_L; $RemotePosition_L; $win)
	$ProcessedDocumentPath_txt:=Replace string:C233($BlobDocumentPath_txt; "ALL_Converted"; "ALL_ToJpegs")
	ARRAY TEXT:C222($ProcessedPaths_atxt; 0)
	ARRAY LONGINT:C221($ProcessedInspectionIDs_aL; 0)
	ARRAY LONGINT:C221($ProcessedPhotoIDs_aL; 0)
	ARRAY TEXT:C222($ProcessedPictureExtension_atxt; 0)
	
	If (Test path name:C476($ProcessedDocumentPath_txt)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($ProcessedDocumentPath_txt; $Exported_blb)
		$Offset_L:=0
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPaths_atxt; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedInspectionIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPhotoIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPictureExtension_atxt; $Offset_L)
	End if 
	$Size_L:=Size of array:C274($Paths_atxt)
	$StartTime_tm:=Current time:C178
	$win:=ut_OpenNewWindow(500; 200; 5; 4; "Changing to jpegs")
	
	C_LONGINT:C283($Skipped_L)
	$Skipped_L:=0
	For ($ImportLoop_L; 1; Size of array:C274($Paths_atxt))
		If (Find in array:C230($ProcessedPhotoIDs_aL; $PhotoIDs_aL{$ImportLoop_L})>0)
			$Size_L:=$Size_L-1
			$Skipped_L:=$Skipped_L+1
		Else 
			
			If ($PictureExtension_atxt{$ImportLoop_L}="PNG")
				APPEND TO ARRAY:C911($ProcessedPaths_atxt; $Paths_atxt{$ImportLoop_L})
				APPEND TO ARRAY:C911($ProcessedInspectionIDs_aL; $InspectionIDs_aL{$ImportLoop_L})
				APPEND TO ARRAY:C911($ProcessedPhotoIDs_aL; $PhotoIDs_aL{$ImportLoop_L})
				APPEND TO ARRAY:C911($ProcessedPictureExtension_atxt; $PictureExtension_atxt{$ImportLoop_L})
				
			Else   // we have one to convert form blob to jpeg
				$PhotoID_txt:=String:C10($PhotoIDs_aL{$ImportLoop_L})
				GOTO XY:C161(5; 2)
				MESSAGE:C88("Updating "+String:C10($importLoop_L-$Skipped_L)+" out of "+String:C10($Size_L))
				GOTO XY:C161(5; 5)
				GOTO XY:C161(5; 6)
				MESSAGE:C88("Processing standard photo ID "+$PhotoID_txt)
				
				GOTO XY:C161(5; 7)
				$RemainingTime_tm:=(($Size_L/($importLoop_L-$Skipped_L))-1)*(Current time:C178-$StartTime_tm)
				MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
				GOTO XY:C161(5; 9)
				
				$Elapsed_tm:=Current time:C178-$StartTime_tm
				MESSAGE:C88("Elapsed time is "+Time string:C180($Elapsed_tm))
				
				APPEND TO ARRAY:C911($ProcessedPaths_atxt; $Paths_atxt{$ImportLoop_L})
				APPEND TO ARRAY:C911($ProcessedInspectionIDs_aL; $InspectionIDs_aL{$ImportLoop_L})
				APPEND TO ARRAY:C911($ProcessedPhotoIDs_aL; $PhotoIDs_aL{$ImportLoop_L})
				APPEND TO ARRAY:C911($ProcessedPictureExtension_atxt; $PictureExtension_atxt{$ImportLoop_L})
				
				If (Test path name:C476($Paths_atxt{$ImportLoop_L}+$PhotoID_txt+".txt")=Is a document:K24:1)
					DOCUMENT TO BLOB:C525($Paths_atxt{$ImportLoop_L}+$PhotoID_txt+".txt"; $NewPicture_blb)
					BLOB TO PICTURE:C682($NewPicture_blb; $Picture_pct; "IMAGE/JPEG")
					WRITE PICTURE FILE:C680($Paths_atxt{$ImportLoop_L}+$PhotoID_txt+".jpg"; $Picture_pct)
					
					DELETE DOCUMENT:C159($Paths_atxt{$ImportLoop_L}+$PhotoID_txt+".txt")
					
				End if 
				SET BLOB SIZE:C606($Exported_blb; 0)
				VARIABLE TO BLOB:C532($ProcessedPaths_atxt; $Exported_blb; *)
				VARIABLE TO BLOB:C532($ProcessedInspectionIDs_aL; $Exported_blb; *)
				VARIABLE TO BLOB:C532($ProcessedPhotoIDs_aL; $Exported_blb; *)
				VARIABLE TO BLOB:C532($ProcessedPictureExtension_atxt; $Exported_blb; *)
				BLOB TO DOCUMENT:C526($ProcessedDocumentPath_txt; $Exported_blb)
				
			End if 
			
		End if 
		
	End for 
	
End if 
//End CNV_ChangeToJPEGS

