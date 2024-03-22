//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/16/16, 13:46:52
//----------------------------------------------------
//Method: CNV_CheckDocuments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_08  // 
	//Modified by: Chuck Miller (8/16/16 13:46:56)
	
End if 
C_TEXT:C284($BlobDocumentPath_txt; $PathToDocumentPath_txt; $FinalDocumentPath_txt)
ARRAY TEXT:C222($Files_atxt; 0)
$BlobDocumentPath_txt:=Select document:C905(""; ""; "Select Combined Blob Document"; Multiple files:K24:7; $Files_atxt)
$BlobDocumentPath_txt:=$Files_atxt{1}
$PathToDocumentPath_txt:=Select folder:C670("Select folder containting converted documents")
If (Test path name:C476($PathToDocumentPath_txt)=Is a folder:K24:2)
	C_PICTURE:C286($Picture_pct)
	C_BLOB:C604($NewPicture_blb)
	C_TIME:C306($StartTime_tm; $RemainingTime_tm)
	If (Test path name:C476($BlobDocumentPath_txt)=Is a document:K24:1)
		ARRAY TEXT:C222($Paths_atxt; 0)
		ARRAY LONGINT:C221($InspectionIDs_aL; 0)
		ARRAY LONGINT:C221($PhotoIDs_aL; 0)
		ARRAY TEXT:C222($PictureExtension_atxt; 0)
		C_BLOB:C604($Exported_blb)
		C_LONGINT:C283($Offset_L; $Position_L)
		
		DOCUMENT TO BLOB:C525($BlobDocumentPath_txt; $Exported_blb)
		$Offset_L:=0
		BLOB TO VARIABLE:C533($Exported_blb; $Paths_atxt; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $InspectionIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $PhotoIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $PictureExtension_atxt; $Offset_L)
		C_LONGINT:C283($YearLoop_L; $MonthLoop_L; $InspectionLoop_L; $DocumentLoop_L)
		ARRAY TEXT:C222($YearFolders_atxt; 0)
		ARRAY TEXT:C222($MonthFolders_atxt; 0)
		ARRAY TEXT:C222($InspectionFolders_atxt; 0)
		ARRAY TEXT:C222($Documents_atxt; 0)
		FOLDER LIST:C473($PathToDocumentPath_txt; $YearFolders_atxt)
		C_BOOLEAN:C305($FoundOne_B)
		C_BOOLEAN:C305($skipped_B)
		C_TEXT:C284($ImageDocName_txt; $Extension_txt; $YearPath_txt; $MonthPath_txt; $Inspectionpath_txt)
		C_BOOLEAN:C305($Changed_B)
		$Changed_B:=False:C215
		ARRAY LONGINT:C221($ReprocessPhotIds_aL; 0)
		C_LONGINT:C283($DocumentSize_L)
		For ($YearLoop_L; 1; Size of array:C274($YearFolders_atxt))
			$YearPath_txt:=$PathToDocumentPath_txt+$YearFolders_atxt{$YearLoop_L}
			ARRAY TEXT:C222($InspectionFolders_atxt; 0)
			FOLDER LIST:C473($YearPath_txt; $MonthFolders_atxt)
			For ($MonthLoop_L; 1; Size of array:C274($MonthFolders_atxt))
				$MonthPath_txt:=$YearPath_txt+Folder separator:K24:12+$MonthFolders_atxt{$MonthLoop_L}
				ARRAY TEXT:C222($InspectionFolders_atxt; 0)
				FOLDER LIST:C473($MonthPath_txt; $InspectionFolders_atxt)
				For ($InspectionLoop_L; 1; Size of array:C274($InspectionFolders_atxt))
					$Inspectionpath_txt:=$MonthPath_txt+Folder separator:K24:12+$InspectionFolders_atxt{$InspectionLoop_L}
					ARRAY TEXT:C222($Documents_atxt; 0)
					DOCUMENT LIST:C474($Inspectionpath_txt; $Documents_atxt)
					For ($DocumentLoop_L; 1; Size of array:C274($Documents_atxt))
						$FoundOne_B:=True:C214
						$skipped_B:=False:C215
						$DocumentSize_L:=Get document size:C479($Inspectionpath_txt+$Documents_atxt{$DocumentLoop_L})
						
						Case of 
							: (Position:C15("JPG"; $Documents_atxt{$DocumentLoop_L})>0)
								$ImageDocName_txt:=Replace string:C233($Documents_atxt{$DocumentLoop_L}; ".JPG"; "")
								$Extension_txt:="JPG"
							: (Position:C15("PNG"; $Documents_atxt{$DocumentLoop_L})>0)
								$ImageDocName_txt:=Replace string:C233($Documents_atxt{$DocumentLoop_L}; ".PNG"; "")
								$Extension_txt:="PNG"
							: (Position:C15("txt"; $Documents_atxt{$DocumentLoop_L})>0)
								$ImageDocName_txt:=Replace string:C233($Documents_atxt{$DocumentLoop_L}; ".txt"; "")
								$Extension_txt:="txt"
								APPEND TO ARRAY:C911($ReprocessPhotIds_aL; Num:C11($ImageDocName_txt))
							: (Position:C15(".ds_"; $Documents_atxt{$DocumentLoop_L})>0)
								$FoundOne_B:=False:C215
								
								
							Else 
								$skipped_B:=True:C214
								$Extension_txt:="???"
								$ImageDocName_txt:=Substring:C12($Documents_atxt{$DocumentLoop_L}; 1; Position:C15("."; $Documents_atxt{$DocumentLoop_L})-1)
						End case 
						If ($FoundOne_B)
							$Position_L:=Find in array:C230($PhotoIDs_aL; Num:C11($ImageDocName_txt))
							If ($Position_L>0)
								
							Else 
								If (Find in array:C230($ReprocessPhotIds_aL; Num:C11($ImageDocName_txt))>0)
								Else 
									APPEND TO ARRAY:C911($ReprocessPhotIds_aL; Num:C11($ImageDocName_txt))
								End if 
							End if 
						Else 
							$Changed_B:=True:C214
							APPEND TO ARRAY:C911($Paths_atxt; $FinalDocumentPath_txt)
							APPEND TO ARRAY:C911($InspectionIDs_aL; Num:C11($InspectionFolders_atxt{$InspectionLoop_L}))
							APPEND TO ARRAY:C911($PhotoIDs_aL; Num:C11($ImageDocName_txt))
							APPEND TO ARRAY:C911($PictureExtension_atxt; $Extension_txt)
							
							
						End if 
						
					End for 
					
					
				End for 
			End for 
		End for 
		
		
	End if 
	
End if   //End CNV_CheckDocuments

