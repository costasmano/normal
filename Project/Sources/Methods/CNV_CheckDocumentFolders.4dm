//%attributes = {"invisible":true}

//----------------------------------------------------
//User name(OS): Chuck Miller
//Date and time: 08/16/16, 13:46:52
//----------------------------------------------------
//Method: CNV_CheckDocuments
//Description
//
//Parameters
//----------------------------------------------------
If (False:C215)
	Mods_2016_08  //
	//Modified by: Chuck Miller(8/16/16 13:46:56)
	
End if 
ARRAY LONGINT:C221($InspectionIDs_aL; 0)
ARRAY DATE:C224($Inspection_ad; 0)
ARRAY LONGINT:C221($PhotoID_aL; 0)
ARRAY LONGINT:C221($PhotoInspID_aL; 0)
Begin SQL
	select
	[Inspections].[InspID], 
	[Inspections].[Insp Date]
	from 
	[Inspections]
	into
	:$InspectionIDs_aL,
	:$Inspection_ad;
	
	select
	[Standard Photos].[StdPhotoID], 
	[Standard Photos].[InspID]
	from
	[Standard Photos]
	into :$PhotoID_aL,
	:$PhotoInspID_aL;
End SQL

C_LONGINT:C283($RecordCount_L; $RecordPosition_L)

C_TIME:C306($Doc_tm)
C_LONGINT:C283($ReportCount_L; $OriginalSize_L)
C_BLOB:C604($SizeReport_blb)
SET BLOB SIZE:C606($SizeReport_blb; 0)
C_LONGINT:C283($Count_L)
TEXT TO BLOB:C554("Inspection ID"+Char:C90(Tab:K15:37)+"Doc Name"+Char:C90(Tab:K15:37)+"Old Path"+Char:C90(Tab:K15:37)+"New Path"+Char:C90(Carriage return:K15:38); $SizeReport_blb; Mac text without length:K22:10; *)

$Doc_tm:=Create document:C266("")
CLOSE DOCUMENT:C267($Doc_tm)
C_TEXT:C284($ReportPath_txt)
$ReportPath_txt:=document
C_TEXT:C284($RptStatus_txt; $BlobDocumentPath_txt; $PathToDocumentPath_txt; $FinalDocumentPath_txt; $FolderSeparator_txt)
$FolderSeparator_txt:=":"
C_BLOB:C604($RecordData_blb)
SET BLOB SIZE:C606($RecordData_blb; 0)

ARRAY TEXT:C222($Files_atxt; 0)

$PathToDocumentPath_txt:=Select folder:C670("Select folder containing convered documents")
If (Test path name:C476($PathToDocumentPath_txt)=Is a folder:K24:2)
	C_PICTURE:C286($Picture_pct)
	C_BLOB:C604($NewPicture_blb)
	C_TIME:C306($StartTime_tm; $RemainingTime_tm)
	
	C_LONGINT:C283($YearLoop_L; $MonthLoop_L; $InspectionLoop_L; $DocumentLoop_L)
	ARRAY TEXT:C222($YearFolders_atxt; 0)
	ARRAY TEXT:C222($MonthFolders_atxt; 0)
	ARRAY TEXT:C222($InspectionFolders_atxt; 0)
	ARRAY TEXT:C222($Documents_atxt; 0)
	FOLDER LIST:C473($PathToDocumentPath_txt; $YearFolders_atxt)
	C_BOOLEAN:C305($FoundOne_B)
	C_BOOLEAN:C305($skipped_B)
	C_TEXT:C284($ImageDocName_txt; $Extension_txt; $YearPath_txt; $MonthPath_txt; $Inspectionpath_txt; $oldPath_txt; $Newpath_txt; $InspectionYear_txt; $InpsectionID_txt; $InspectionMonth_txt)
	C_BOOLEAN:C305($MoveDocument_B)
	$MoveDocument_B:=False:C215
	ARRAY LONGINT:C221($ReprocessPhotIds_aL; 0)
	C_LONGINT:C283($DocumentSize_L; $Position_L; $Pos_L)
	
	For ($YearLoop_L; 1; Size of array:C274($YearFolders_atxt))
		$YearPath_txt:=$PathToDocumentPath_txt+$YearFolders_atxt{$YearLoop_L}
		ARRAY TEXT:C222($InspectionFolders_atxt; 0)
		FOLDER LIST:C473($YearPath_txt; $MonthFolders_atxt)
		For ($MonthLoop_L; 1; Size of array:C274($MonthFolders_atxt))
			$MonthPath_txt:=$YearPath_txt+$FolderSeparator_txt+$MonthFolders_atxt{$MonthLoop_L}
			
			ARRAY TEXT:C222($InspectionFolders_atxt; 0)
			FOLDER LIST:C473($MonthPath_txt; $InspectionFolders_atxt)
			For ($InspectionLoop_L; 1; Size of array:C274($InspectionFolders_atxt))
				$Inspectionpath_txt:=$MonthPath_txt+$FolderSeparator_txt+$InspectionFolders_atxt{$InspectionLoop_L}
				ARRAY TEXT:C222($Documents_atxt; 0)
				DOCUMENT LIST:C474($Inspectionpath_txt; $Documents_atxt)
				
				For ($DocumentLoop_L; 1; Size of array:C274($Documents_atxt))
					
					MESSAGE:C88("Processing "+$MonthPath_txt+" "+String:C10($DocumentLoop_L)+" out of "+String:C10(Size of array:C274($Documents_atxt)))
					$FoundOne_B:=True:C214
					$skipped_B:=False:C215
					$ImageDocName_txt:=Substring:C12($Documents_atxt{$DocumentLoop_L}; 1; Position:C15("."; $Documents_atxt{$DocumentLoop_L})-1)
					
					$Position_L:=Find in array:C230($PhotoID_aL; Num:C11($ImageDocName_txt))
					If ($Position_L>0)
						$Pos_L:=Find in array:C230($InspectionIDs_aL; $PhotoInspID_aL{$Position_L})
						If ($Pos_L>0)
							$InspectionYear_txt:=String:C10(Year of:C25($Inspection_ad{$Pos_L}); "0000")
							$InspectionMonth_txt:=String:C10(Month of:C24($Inspection_ad{$Pos_L}); "00")
							$InpsectionID_txt:=String:C10($PhotoInspID_aL{$Position_L})
							
							$NewPath_txt:=$PathToDocumentPath_txt+$InspectionYear_txt
							
							If (Test path name:C476($NewPath_txt)=Is a folder:K24:2)
							Else 
								CREATE FOLDER:C475($NewPath_txt)
								
							End if 
							
							$NewPath_txt:=$PathToDocumentPath_txt+$InspectionYear_txt+":"+$InspectionMonth_txt
							
							If (Test path name:C476($NewPath_txt)=Is a folder:K24:2)
							Else 
								CREATE FOLDER:C475($NewPath_txt)
								
							End if 
							
							$NewPath_txt:=$PathToDocumentPath_txt+$InspectionYear_txt+":"+$InspectionMonth_txt+":"+$InpsectionID_txt
							
							If (Test path name:C476($NewPath_txt)=Is a folder:K24:2)
							Else 
								CREATE FOLDER:C475($NewPath_txt)
								
							End if 
							$NewPath_txt:=$NewPath_txt+":"+$Documents_atxt{$DocumentLoop_L}
							$oldPath_txt:=$Inspectionpath_txt+":"+$Documents_atxt{$DocumentLoop_L}
							If ($NewPath_txt=$oldPath_txt)
							Else 
								MOVE DOCUMENT:C540($oldPath_txt; $NewPath_txt)
								
								TEXT TO BLOB:C554($InpsectionID_txt+Char:C90(Tab:K15:37)+$Documents_atxt{$DocumentLoop_L}+Char:C90(Tab:K15:37)+$oldPath_txt+Char:C90(Tab:K15:37)+$NewPath_txt+Char:C90(Carriage return:K15:38); $SizeReport_blb; Mac text without length:K22:10; *)
								
								BLOB TO DOCUMENT:C526($ReportPath_txt; $SizeReport_blb)
								
								
							End if 
						Else 
							
						End if 
					End if 
				End for 
			End for 
		End for 
		
	End for 
	
	
	
	
	
	
End if 
// End CNV_CheckDocuments

