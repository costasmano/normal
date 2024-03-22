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
C_TEXT:C284($StartOriginalPath_txt; $StartNewPath_txt; $DocumentName_txt)
C_BOOLEAN:C305(SQLConnectionMade_b; SQLError_b)

SQLConnectionMade_b:=False:C215
SQLError_b:=False:C215
Compiler_clone
Compiler_SQL

clone_ControlConnect
If (SQLConnectionMade_b)
	$StartOriginalPath_txt:=Select folder:C670("Select folder containing converted documents [Converted]")
	$StartNewPath_txt:=Select folder:C670("Select folder to move converted documents to [MoveTo] ")
	Case of 
		: (Test path name:C476($StartOriginalPath_txt)#Is a folder:K24:2)
		: (Test path name:C476($StartNewPath_txt)#Is a folder:K24:2)
		Else 
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
			
			SQL LOGOUT:C872
			C_LONGINT:C283($RecordCount_L; $RecordPosition_L)
			
			C_TIME:C306($Doc_tm; $Errordoc_tm)
			C_LONGINT:C283($ReportCount_L; $OriginalSize_L)
			C_BLOB:C604($SizeReport_blb)
			SET BLOB SIZE:C606($SizeReport_blb; 0)
			C_LONGINT:C283($Count_L)
			$DocumentName_txt:="MoveToLog_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 14)+".txt"
			$Doc_tm:=Create document:C266($StartNewPath_txt+$DocumentName_txt)
			$Errordoc_tm:=Create document:C266($StartNewPath_txt+Replace string:C233($DocumentName_txt; "MoveToLog"; "MoveToErrorLog"))
			
			SEND PACKET:C103($Doc_tm; "Inspection ID"+Char:C90(Tab:K15:37)+"Doc Name"+Char:C90(Tab:K15:37)+"Old Path"+Char:C90(Tab:K15:37)+"New Path"+Char:C90(Carriage return:K15:38))
			SEND PACKET:C103($Errordoc_tm; "Inspection ID"+Char:C90(Tab:K15:37)+"Doc Name"+Char:C90(Tab:K15:37)+"Old Path"+Char:C90(Tab:K15:37)+"New Path"+Char:C90(Tab:K15:37)+"Status"+Char:C90(Carriage return:K15:38))
			
			C_TEXT:C284($RptStatus_txt; $BlobDocumentPath_txt; $PathToDocumentPath_txt; $FinalDocumentPath_txt; $FolderSeparator_txt)
			$FolderSeparator_txt:=":"
			
			ARRAY TEXT:C222($Files_atxt; 0)
			
			C_LONGINT:C283($YearLoop_L; $MonthLoop_L; $InspectionLoop_L; $DocumentLoop_L)
			ARRAY TEXT:C222($YearFolders_atxt; 0)
			ARRAY TEXT:C222($MonthFolders_atxt; 0)
			ARRAY TEXT:C222($InspectionFolders_atxt; 0)
			ARRAY TEXT:C222($Documents_atxt; 0)
			FOLDER LIST:C473($StartOriginalPath_txt; $YearFolders_atxt)
			C_BOOLEAN:C305($FoundOne_B)
			C_BOOLEAN:C305($skipped_B)
			C_TEXT:C284($ImageDocName_txt; $Extension_txt; $YearPath_txt; $MonthPath_txt; $Inspectionpath_txt; $oldPath_txt; $Newpath_txt; $InspectionYear_txt; $InspectionID_txt; $InspectionMonth_txt)
			C_BOOLEAN:C305($MoveDocument_B)
			$MoveDocument_B:=False:C215
			ARRAY LONGINT:C221($ReprocessPhotIds_aL; 0)
			C_LONGINT:C283($DocumentSize_L; $Position_L; $Pos_L; $Start_L)
			SORT ARRAY:C229($YearFolders_atxt; >)
			
			C_BOOLEAN:C305($Complete_B)
			$Complete_B:=False:C215
			C_TEXT:C284($request_txt)
			
			Repeat 
				$request_txt:=Request:C163("Enter starting Year"; "2007")
				If ($request_txt="ALL")
					CONFIRM:C162("Process all years "; "Proceed"; "Try again")
					If (OK=1)
						$start_L:=1
						$Complete_B:=True:C214
					End if 
				Else 
					$Start_L:=Find in array:C230($YearFolders_atxt; $request_txt)
					If ($Start_L>0)
						CONFIRM:C162("Process years from "+$YearFolders_atxt{$Start_L}; "Proceed"; "Try again")
						If (OK=1)
							$Complete_B:=True:C214
						End if 
						
					End if 
				End if 
			Until ($Complete_B)
			
			For ($YearLoop_L; $start_L; Size of array:C274($YearFolders_atxt))
				$YearPath_txt:=$StartOriginalPath_txt+$YearFolders_atxt{$YearLoop_L}
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
								If ($Pos_L<0)
									$Pos_L:=$Position_L
								End if 
								If ($Pos_L>0)
									$InspectionYear_txt:=String:C10(Year of:C25($Inspection_ad{$Pos_L}); "0000")
									$InspectionMonth_txt:=String:C10(Month of:C24($Inspection_ad{$Pos_L}); "00")
									$InspectionID_txt:=String:C10($PhotoInspID_aL{$Position_L})
									
									$NewPath_txt:=CNV_CreateNewPath($InspectionID_txt; $StartNewPath_txt)
									
									$NewPath_txt:=$NewPath_txt+$Documents_atxt{$DocumentLoop_L}
									$oldPath_txt:=$Inspectionpath_txt+":"+$Documents_atxt{$DocumentLoop_L}
									If ($NewPath_txt=$oldPath_txt)
									Else 
										Repeat 
											TryAgain_L:=2
											CNV_Doc_tm:=$Errordoc_tm
											ON ERR CALL:C155("CNV_CopyError")
											COPY DOCUMENT:C541($oldPath_txt; $NewPath_txt; *)
											ON ERR CALL:C155("")
										Until (TryAgain_L=2) | (TryAgain_L=3) | (TryAgain_L=4)
										If (TryAgain_L=2)
											SEND PACKET:C103($doc_tm; $InspectionID_txt+Char:C90(Tab:K15:37)+$Documents_atxt{$DocumentLoop_L}+Char:C90(Tab:K15:37)+$oldPath_txt+Char:C90(Tab:K15:37)+$NewPath_txt+Char:C90(Carriage return:K15:38))
										Else 
											SEND PACKET:C103($Errordoc_tm; Char:C90(Carriage return:K15:38)+$InspectionID_txt+Char:C90(Tab:K15:37)+$Documents_atxt{$DocumentLoop_L}+Char:C90(Tab:K15:37)+$oldPath_txt+Char:C90(Tab:K15:37)+$NewPath_txt+"Unknown error code listed above"+Char:C90(Carriage return:K15:38))
										End if 
									End if 
								Else 
									SEND PACKET:C103($Errordoc_tm; String:C10($PhotoInspID_aL{$Position_L})+Char:C90(Tab:K15:37)+$Documents_atxt{$DocumentLoop_L}+Char:C90(Tab:K15:37)+$oldPath_txt+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+"Inspection ID not Found"+Char:C90(Carriage return:K15:38))
								End if 
							Else 
								SEND PACKET:C103($Errordoc_tm; "Unknown"+Char:C90(Tab:K15:37)+$Documents_atxt{$DocumentLoop_L}+Char:C90(Tab:K15:37)+$oldPath_txt+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+"Image ID not Found"+Char:C90(Carriage return:K15:38))
							End if 
						End for 
					End for 
				End for 
				
			End for 
			CLOSE DOCUMENT:C267($Doc_tm)
			CLOSE DOCUMENT:C267($Errordoc_tm)
			
	End case 
End if 
// End CNV_CheckDocuments

