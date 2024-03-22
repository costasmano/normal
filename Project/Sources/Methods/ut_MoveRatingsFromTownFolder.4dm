//%attributes = {"invisible":true}
//Method: ut_MoveRatingsFromTownFolder
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/28/17, 11:43:50
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//

C_TEXT:C284($ReportPath_txt; $Error_txt; $TownPath_txt; $PathForProperties_txt; $DocBDEPT_txt; $DocBIN_txt; $FinalFolder_txt)
C_BOOLEAN:C305($locked_B; $invisible_B; $Error_B)
C_DATE:C307($CreatedOn_d; $ModifiedOn_d)
C_TIME:C306($Created_tm; $Modified_tm; $doc_tm)
$ReportPath_txt:=Select folder:C670("Select report folder")
If (OK=1)
	$ReportPath_txt:=$ReportPath_txt+"MoveRatingReports_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"
	$Doc_tm:=Create document:C266($ReportPath_txt)
	$TownPath_txt:=Select folder:C670("Select Town Folder to start")
	If (OK=1)
		ARRAY TEXT:C222($TownFolders_atxt; 0)
		CLEAR VARIABLE:C89($TownFolders_atxt)
		FOLDER LIST:C473($TownPath_txt; $TownFolders_atxt)
		
		C_LONGINT:C283($TownLoop_L; $DocumentLoop_l; $Progress_L)
		C_TEXT:C284($TownPrefix_txt)
		ARRAY TEXT:C222($BridgeBin_atxt; 0)
		CLEAR VARIABLE:C89($BridgeBin_atxt)
		ARRAY TEXT:C222($BridgeBDEPT_atxt; 0)
		CLEAR VARIABLE:C89($BridgeBDEPT_atxt)
		
		Begin SQL
			select 
			[Bridge MHD NBIS].[BIN],
			[Bridge MHD NBIS].[BDEPT]
			from
			[Bridge MHD NBIS]
			into
			:$BridgeBin_atxt,
			:$BridgeBDEPT_atxt;
		End SQL
		$Progress_L:=Progress New
		For ($TownLoop_L; 1; Size of array:C274($TownFolders_atxt))
			Progress SET TITLE($Progress_L; "Moving Misplaced Reports...")
			Progress SET MESSAGE($progress_L; "Processing "+$TownFolders_atxt{$TownLoop_L})
			$TownPrefix_txt:=Substring:C12($TownFolders_atxt{$TownLoop_L}; 1; 3)
			ARRAY TEXT:C222($Documents_atxt; 0)
			CLEAR VARIABLE:C89($Documents_atxt)
			DOCUMENT LIST:C474($TownPath_txt+$TownFolders_atxt{$TownLoop_L}; $Documents_atxt)
			
			For ($DocumentLoop_l; 1; Size of array:C274($Documents_atxt))
				Progress SET PROGRESS($Progress_L; $DocumentLoop_l/Size of array:C274($Documents_atxt); "Processing Document "+$Documents_atxt{$DocumentLoop_l})
				$PathForProperties_txt:=$TownPath_txt+$TownFolders_atxt{$TownLoop_L}+Folder separator:K24:12+$Documents_atxt{$DocumentLoop_l}
				GET DOCUMENT PROPERTIES:C477($PathForProperties_txt; $locked_B; $invisible_B; $CreatedOn_d; $Created_tm; $ModifiedOn_d; $Modified_tm)
				If (Not:C34($invisible_B))
					$Error_txt:=""
					If (Substring:C12($Documents_atxt{$DocumentLoop_l}; 1; 3)=$TownPrefix_txt)
						
						
						If (MR_CheckandResetDocumentLock($PathForProperties_txt; False:C215))
							$DocBDEPT_txt:=Substring:C12($Documents_atxt{$DocumentLoop_l}; 1; 6)
							$DocBIN_txt:=Substring:C12($Documents_atxt{$DocumentLoop_l}; 8; 3)
							$FinalFolder_txt:=$TownPath_txt+$TownFolders_atxt{$TownLoop_L}+Folder separator:K24:12+$DocBDEPT_txt+"_"+$DocBIN_txt
							Case of 
								: (Find in array:C230($BridgeBin_atxt; $DocBIN_txt)<0)
									$Error_B:=True:C214
								: (Find in array:C230($BridgeBDEPT_atxt; $DocBDEPT_txt)<0)
									$Error_B:=True:C214
								Else 
									$Error_B:=False:C215
									4DError_b:=False:C215
									ON ERR CALL:C155("4D_Errors")
									If (Test path name:C476($FinalFolder_txt)=Is a folder:K24:2)
										
									Else 
										CREATE FOLDER:C475($FinalFolder_txt)
									End if 
									If (Not:C34(4DError_b))
										ON ERR CALL:C155("4D_Errors")
										MOVE DOCUMENT:C540($PathForProperties_txt; $FinalFolder_txt+Folder separator:K24:12+$Documents_atxt{$DocumentLoop_l})
										
										If (4DError_b)
											$Error_txt:="4D error in moving document occured First description line is "+SQL_InternalDescriptions_atxt{1}+" Notify MADOT BMS Support"+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+$PathForProperties_txt
											4DError_b:=False:C215
										Else 
											If (MR_CheckandResetDocumentLock($FinalFolder_txt+Folder separator:K24:12+$Documents_atxt{$DocumentLoop_l}; True:C214))
											End if 
										End if 
									Else 
										$Error_txt:="Could not create folder"+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+$FinalFolder_txt+Char:C90(Carriage return:K15:38)
									End if 
									
							End case 
						Else 
							$Error_txt:="Could not reset lock status for "+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+$PathForProperties_txt+Char:C90(Carriage return:K15:38)
							
						End if 
						
					Else 
						$Error_txt:="Mismatched document and town"+Char:C90(Tab:K15:37)+$TownPrefix_txt+Char:C90(Tab:K15:37)+$PathForProperties_txt+Char:C90(Carriage return:K15:38)
					End if 
					If ($Error_txt#"")
						SEND PACKET:C103($doc_tm; $Error_txt)
					End if 
				End if 
				
				
				
				
			End for 
			
			
		End for 
		
		
		
		
		Progress QUIT(-1)
		
	End if 
End if 
CLOSE DOCUMENT:C267($doc_tm)

//End ut_MoveRatingsFromTownFolder