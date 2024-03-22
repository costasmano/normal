//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/28/16, 12:10:27
//----------------------------------------------------
//Method: ut_CopyConvtertedPDFs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/28/16 12:10:30)
	
End if 
Compiler_CNV
C_TEXT:C284($MoveToPicturesFolderPath_txt; $FileName_txt; $CopyToPath_txt; $Line_txt; $PL_DirectorySep_s; $ConvertedFolderPath_txt; $ExportFileWithBlob_txt; $SavedPicturesFolderPath_txt; $DocumentName_txt; $CopyToPath_txt; $NewFolderPath_txt)
C_TEXT:C284($BlobDocumentPath_txt; $ProcessedDocumentPath_txt)
C_PICTURE:C286($Picture_pct)
C_BLOB:C604($Blob_blb)

$MoveToPicturesFolderPath_txt:=Select folder:C670("Select folder that has Converted Files")
ARRAY TEXT:C222($Files_atxt; 0)
C_LONGINT:C283($Loop_L; $InspectionID_L; $PhotoID_L; $Position_L)
$BlobDocumentPath_txt:=Select document:C905(""; ""; "Select Combined Blob Document"; Multiple files:K24:7; $Files_atxt)
$BlobDocumentPath_txt:=$Files_atxt{1}
$SavedPicturesFolderPath_txt:=Select folder:C670("Select folder that has Saved Pictures ")
If (Test path name:C476($SavedPicturesFolderPath_txt)=Is a folder:K24:2)
	ARRAY TEXT:C222($Folders_atxt; 0)
	FOLDER LIST:C473($SavedPicturesFolderPath_txt; $Folders_atxt)
End if 
$ExportFileWithBlob_txt:=$SavedPicturesFolderPath_txt+"Export_blob.txt"
ARRAY TEXT:C222($Paths_atxt; 0)
ARRAY TEXT:C222($PictureExtension_atxt; 0)
ARRAY LONGINT:C221($InspectionIDs_aL; 0)
ARRAY LONGINT:C221($PhotoIDs_aL; 0)
C_BLOB:C604($Exported_blb)
C_LONGINT:C283($Offset_L)
ARRAY TEXT:C222($SkippedPaths_atxt; 0)
ARRAY TEXT:C222($SkippedPictureExtension_atxt; 0)
ARRAY LONGINT:C221($SkippedInspectionIDs_aL; 0)
ARRAY LONGINT:C221($SkippedPhotoIDs_aL; 0)

If (Test path name:C476($BlobDocumentPath_txt)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($BlobDocumentPath_txt; $Exported_blb)
	$Offset_L:=0
	BLOB TO VARIABLE:C533($Exported_blb; $Paths_atxt; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $InspectionIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PhotoIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PictureExtension_atxt; $Offset_L)
	$ProcessedDocumentPath_txt:=Replace string:C233($BlobDocumentPath_txt; "ALL_Converted"; "CopyConvertedPNG")
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
End if 
If (Size of array:C274($Paths_atxt)=0)
	ALERT:C41("Can not run without paths")
Else 
	C_LONGINT:C283($Size_L; $win)
	$win:=ut_OpenNewWindow(500; 200; 5; 4; "copying Saved Pictures")
	
	$Line_txt:="Start Process on "+String:C10(Current date:C33; 7)+" at "+String:C10(Current time:C178; HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)
	$Line_txt:=$Line_txt+"Photo ID"+Char:C90(Tab:K15:37)+"Inspection ID"+Char:C90(Tab:K15:37)+"Picture Size"+Char:C90(Tab:K15:37)+"Status"+Char:C90(Carriage return:K15:38)
	C_TIME:C306($Doc_tm)
	$DocumentName_txt:="CopyPictureLog_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
	
	CNV_Doc_tm:=Create document:C266($SavedPicturesFolderPath_txt+$DocumentName_txt)
	SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
	$Line_txt:=""
	
	//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
	If (Is Windows:C1573)
		$PL_DirectorySep_s:="\\"
	Else 
		$PL_DirectorySep_s:=":"
	End if 
	ARRAY TEXT:C222($Documents_atxt; 0)
	
	
	C_LONGINT:C283($Size_L; $FolderList_L)
	$Size_L:=Size of array:C274($Documents_atxt)
	C_TIME:C306($StartTime_tm; $RemainingTime_tm; $Elapsed_tm)
	$StartTime_tm:=Current time:C178
	For ($FolderList_L; 1; Size of array:C274($Folders_atxt))
		$NewFolderPath_txt:=$SavedPicturesFolderPath_txt+$Folders_atxt{$FolderList_L}+":"
		DOCUMENT LIST:C474($NewFolderPath_txt; $Documents_atxt)
		$Size_L:=Size of array:C274($Documents_atxt)
		For ($Loop_L; 1; Size of array:C274($Documents_atxt))
			//If (Position(".PNG";$Documents_atxt{$Loop_L})>0)
			
			If (Position:C15("."; $Documents_atxt{$Loop_L})=1)
			Else 
				ARRAY TEXT:C222($Parts_atxt; 0)
				ut_NewTextToArray($Documents_atxt{$Loop_L}; ->$Parts_atxt; ".")
				//$InspectionID_L:=Num($Parts_atxt{1})
				$PhotoID_L:=Num:C11($Parts_atxt{1})
				QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=$PhotoID_L)
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Standard Photos:36]InspID:1)
				$CopyToPath_txt:=CNV_CreateNewPath(String:C10([Standard Photos:36]InspID:1); $MoveToPicturesFolderPath_txt)
				//$CopyToPath_txt:=CNV_CreatePath ($PL_DirectorySep_s;$MoveToPicturesFolderPath_txt)
				$Line_txt:=String:C10($PhotoID_L)+Char:C90(Tab:K15:37)+String:C10([Inspections:27]InspID:2)+Char:C90(Tab:K15:37)
				$Position_L:=Find in array:C230($PhotoIDs_aL; $PhotoID_L)
				
				GOTO XY:C161(5; 2)
				MESSAGE:C88("Updating "+String:C10($Loop_L)+" out of "+String:C10($Size_L))
				GOTO XY:C161(5; 5)
				GOTO XY:C161(5; 6)
				MESSAGE:C88("Processing standard photo ID "+$Parts_atxt{1})
				
				GOTO XY:C161(5; 7)
				$RemainingTime_tm:=(($Size_L/$Loop_L)-1)*(Current time:C178-$StartTime_tm)
				MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
				GOTO XY:C161(5; 9)
				
				$Elapsed_tm:=Current time:C178-$StartTime_tm
				MESSAGE:C88("Elapsed time is "+Time string:C180($Elapsed_tm))
				
				//READ PICTURE FILE($NewFolderPath_txt+$Documents_atxt{$Loop_L};$Picture_pct)
				//SET BLOB SIZE($Blob_blb;0)
				//PICTURE TO BLOB($Picture_pct;$Blob_blb;"IMAGE/PNG")
				$Line_txt:=$Line_txt+String:C10(Get document size:C479($NewFolderPath_txt+$Documents_atxt{$Loop_L}))+Char:C90(Tab:K15:37)
				
				SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
				If (Is Windows:C1573)
					$CopyToPath_txt:=Replace string:C233($CopyToPath_txt; ":"; $PL_DirectorySep_s; 999)
				Else 
					$CopyToPath_txt:=Replace string:C233($CopyToPath_txt; "\\"; $PL_DirectorySep_s; 999)
				End if 
				ON ERR CALL:C155("CNV_CopyError")
				If (Test path name:C476($CopyToPath_txt+$Parts_atxt{1}+".txt")=Is a document:K24:1)
					DELETE DOCUMENT:C159($CopyToPath_txt+$Parts_atxt{1}+".txt")
					//COPY DOCUMENT($NewFolderPath_txt+$Documents_atxt{$Loop_L};$CopyToPath_txt+$Parts_atxt{2}+".png")
				End if 
				
				Repeat 
					TryAgain_L:=2
					
					ON ERR CALL:C155("CNV_CopyError")
					COPY DOCUMENT:C541($NewFolderPath_txt+$Documents_atxt{$Loop_L}; $CopyToPath_txt+$Parts_atxt{1}+"."+$Parts_atxt{2}; *)
					ON ERR CALL:C155("")
				Until (TryAgain_L=2) | (TryAgain_L=3) | (TryAgain_L=4)
				If (TryAgain_L=2)
					SEND PACKET:C103(CNV_Doc_tm; String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37)+$Documents_atxt{$Loop_L}+Char:C90(Tab:K15:37)+$NewFolderPath_txt+Char:C90(Tab:K15:37)+$CopyToPath_txt+Char:C90(Carriage return:K15:38))
				Else 
					SEND PACKET:C103(CNV_Doc_tm; Char:C90(Carriage return:K15:38)+String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37)+$Documents_atxt{$Loop_L}+Char:C90(Tab:K15:37)+$NewFolderPath_txt+Char:C90(Tab:K15:37)+$CopyToPath_txt+"Unknown error code listed above"+Char:C90(Carriage return:K15:38))
				End if 
				
				//BLOB TO DOCUMENT($CopyToPath_txt+$Parts_atxt{1}+"_"+$Parts_atxt{2}+".txt";$Blob_blb)
				
				APPEND TO ARRAY:C911($ProcessedPaths_atxt; $CopyToPath_txt)
				APPEND TO ARRAY:C911($ProcessedInspectionIDs_aL; Num:C11($Parts_atxt{1}))
				APPEND TO ARRAY:C911($ProcessedPhotoIDs_aL; Num:C11($Parts_atxt{2}))
				APPEND TO ARRAY:C911($ProcessedPictureExtension_atxt; $PictureExtension_atxt{$Loop_L})
				SET BLOB SIZE:C606($Exported_blb; 0)
				VARIABLE TO BLOB:C532($ProcessedPaths_atxt; $Exported_blb; *)
				VARIABLE TO BLOB:C532($ProcessedInspectionIDs_aL; $Exported_blb; *)
				VARIABLE TO BLOB:C532($ProcessedPhotoIDs_aL; $Exported_blb; *)
				VARIABLE TO BLOB:C532($ProcessedPictureExtension_atxt; $Exported_blb; *)
				BLOB TO DOCUMENT:C526($ProcessedDocumentPath_txt; $Exported_blb)
				
				ON ERR CALL:C155("")
				SEND PACKET:C103(CNV_Doc_tm; Char:C90(Carriage return:K15:38))
				
				//End if 
				
			End if 
		End for 
		
	End for 
	DOCUMENT TO BLOB:C525($BlobDocumentPath_txt; $Exported_blb)
	$Offset_L:=0
	BLOB TO VARIABLE:C533($Exported_blb; $Paths_atxt; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $InspectionIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PhotoIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PictureExtension_atxt; $Offset_L)
	C_BOOLEAN:C305($CHANGE_B)
	$CHANGE_B:=False:C215
	$Doc_tm:=Create document:C266("")
	For ($Loop_L; 1; Size of array:C274($SkippedPaths_atxt))
		
		SEND PACKET:C103($Doc_tm; $SkippedPaths_atxt{$Loop_L}+Char:C90(Tab:K15:37))
		SEND PACKET:C103($Doc_tm; String:C10($SkippedInspectionIDs_aL{$Loop_L})+Char:C90(Tab:K15:37))
		SEND PACKET:C103($Doc_tm; String:C10($SkippedPhotoIDs_aL{$Loop_L})+Char:C90(Tab:K15:37))
		SEND PACKET:C103($Doc_tm; $SkippedPictureExtension_atxt{$Loop_L}+Char:C90(Tab:K15:37))
		
		If (Find in array:C230($PhotoIDs_aL; $SkippedPhotoIDs_aL{$Loop_L})>0)
			
		Else 
			APPEND TO ARRAY:C911($Paths_atxt; $SkippedPaths_atxt{$Loop_L})
			APPEND TO ARRAY:C911($InspectionIDs_aL; $SkippedInspectionIDs_aL{$Loop_L})
			APPEND TO ARRAY:C911($PhotoIDs_aL; $SkippedPhotoIDs_aL{$Loop_L})
			APPEND TO ARRAY:C911($PictureExtension_atxt; "PNG")
			$CHANGE_B:=True:C214
		End if 
	End for 
	If ($CHANGE_B)
		SET BLOB SIZE:C606($Exported_blb; 0)
		VARIABLE TO BLOB:C532($Paths_atxt; $Exported_blb; *)
		VARIABLE TO BLOB:C532($InspectionIDs_aL; $Exported_blb; *)
		VARIABLE TO BLOB:C532($PhotoIDs_aL; $Exported_blb; *)
		VARIABLE TO BLOB:C532($PictureExtension_atxt; $Exported_blb; *)
		
		BLOB TO DOCUMENT:C526($BlobDocumentPath_txt; $Exported_blb)
		
	End if 
End if 
//End ut_CopyConvtertedPDFs
