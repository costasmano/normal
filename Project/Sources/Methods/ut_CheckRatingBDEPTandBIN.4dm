//%attributes = {"invisible":true}
//Method: ut_CheckRatingBDEPTandBIN
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
C_BOOLEAN:C305($CreateandMoveEtc_B)
CONFIRM:C162("Logged in to share as walter"; "Yes"; "No")

$CreateandMoveEtc_B:=OK=1

C_LONGINT:C283($TownDirectoryPosition_L)
C_TEXT:C284($ReportPath_txt; $Error_txt; $TownPath_txt; $PathForProperties_txt; $DocBDEPT_txt; $DocBIN_txt; $FinalFolder_txt; $FolderNameP1_txt; $FolderNameP2_txt; $baseSpec_txt)
$baseSpec_txt:="mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present"  //ut_GetSysParameter ("SCRRPT_StartLocation";"mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
C_TEXT:C284($Directory_txt; $OldPath_txt; $Townfolder_txt)
C_LONGINT:C283($Loop_L; $BDEPTPosition_L; $BINPosition_L)
ARRAY TEXT:C222($DirectoryParts_atxt; 0)
ut_NewTextToArray($baseSpec_txt; ->$DirectoryParts_atxt; "/")
$Directory_txt:=$DirectoryParts_atxt{2}
For ($Loop_L; 3; Size of array:C274($DirectoryParts_atxt))
	$Directory_txt:=$Directory_txt+Folder separator:K24:12+$DirectoryParts_atxt{$Loop_L}
	If (Test path name:C476($Directory_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($Directory_txt)
	End if 
End for 

C_BOOLEAN:C305($locked_B; $invisible_B; $Error_B)
C_DATE:C307($CreatedOn_d; $ModifiedOn_d)
C_TIME:C306($Created_tm; $Modified_tm; $doc_tm)
$ReportPath_txt:=Select folder:C670("Select report folder"; 10)
If (OK=1)
	$ReportPath_txt:=$ReportPath_txt+"BDEPTandBINReports_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"
	$Doc_tm:=Create document:C266($ReportPath_txt)
	$TownPath_txt:=Select folder:C670("Select Town Folder to start"; 11)
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
		C_OBJECT:C1216($TownProgress_obj; $TownFilesProgress_obj)
		
		ARRAY TEXT:C222($CompletePaths_atxt; 0)
		SORT ARRAY:C229($TownFolders_atxt; >)
		C_LONGINT:C283($CompSize_L; $PartSize_L)
		C_OBJECT:C1216($TownProgress_obj)
		$TownProgress_obj:=ProgressNew("Scanning Towns"; Size of array:C274($TownFolders_atxt); False:C215; " Towns"; 3)
		
		For ($TownLoop_L; 2; Size of array:C274($TownFolders_atxt))
			//update progress
			UpdateProgressNew($TownProgress_obj; $TownLoop_L)
			$TownPrefix_txt:=Substring:C12($TownFolders_atxt{$TownLoop_L}; 1; 3)
			DOCUMENT LIST:C474($TownPath_txt+$TownFolders_atxt{$TownLoop_L}; $CompletePaths_atxt; Ignore invisible:K24:16+Recursive parsing:K24:13)
			$CompSize_L:=Size of array:C274($CompletePaths_atxt)
			//start the bar
			C_OBJECT:C1216($TownFilesProgress_obj)
			$TownFilesProgress_obj:=ProgressNew("Scanning Files in "+$TownPrefix_txt; $CompSize_L; False:C215; " Files"; 3)
			
			For ($DocumentLoop_l; 1; $CompSize_L)
				//update progress
				UpdateProgressNew($TownFilesProgress_obj; $DocumentLoop_l)
				
				If (Position:C15(".PDF"; $CompletePaths_atxt{$DocumentLoop_l})>0)
					//Progress SET TITLE ($Progress_L;"Checking BDEPT and BIN validity...")
					//Progress SET MESSAGE ($progress_L;"Processing "+$CompletePaths_atxt{$DocumentLoop_l})
					ARRAY TEXT:C222($Parts_atxt; 0)
					CLEAR VARIABLE:C89($Parts_atxt)
					
					
					ut_NewTextToArray($CompletePaths_atxt{$DocumentLoop_l}; ->$Parts_atxt; Folder separator:K24:12)
					If (Find in array:C230($Parts_atxt; "Other")>0)
					Else 
						$PartSize_L:=Size of array:C274($Parts_atxt)
						//Progress SET PROGRESS ($Progress_L;$DocumentLoop_l/$CompSize_L;"Processing Document "+$Parts_atxt{$PartSize_L})
						
						$Error_txt:=""
						If (Substring:C12($Parts_atxt{$PartSize_L}; 1; 3)=$TownPrefix_txt)
							
							$FolderNameP1_txt:=""
							$FolderNameP2_txt:=""
							
							$DocBDEPT_txt:=Substring:C12($Parts_atxt{$PartSize_L}; 1; 6)
							$DocBIN_txt:=Substring:C12($Parts_atxt{$PartSize_L}; 8; 3)
							$BDEPTPosition_L:=Find in array:C230($BridgeBDEPT_atxt; $DocBDEPT_txt)
							$BINPosition_L:=Find in array:C230($BridgeBin_atxt; $DocBIN_txt)
							Case of 
								: ($BINPosition_L<1)
									$Error_txt:="BIN Not found ["+$DocBDEPT_txt+"] ["+$DocBIN_txt+"]"+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
									
								: ($BridgeBDEPT_atxt{$BINPosition_L}#$DocBDEPT_txt)
									$Error_txt:="BIN BDEPT Mismatch for file ["+$DocBDEPT_txt+"] ["+$DocBIN_txt+"]"+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
								Else 
									If ($PartSize_L>2)
										$FolderNameP1_txt:=Substring:C12($Parts_atxt{2}; 1; 6)
										$FolderNameP2_txt:=Substring:C12($Parts_atxt{2}; 8; 3)
										
										If ($FolderNameP1_txt=$DocBDEPT_txt) & ($FolderNameP2_txt=$DocBIN_txt)
											If ($Parts_atxt{2}=($DocBDEPT_txt+"_"+$DocBIN_txt))
											Else 
												
												Case of 
													: ($Parts_atxt{2}=($DocBDEPT_txt+"-"+$DocBIN_txt+"@"))
														//$Error_txt:="Misnamed Folder : dash in folder name"+Char(Tab)+$Parts_atxt{$PartSize_L}+Char(Tab)+$CompletePaths_atxt{$DocumentLoop_l}+Char(Carriage return)
													: (Length:C16($Parts_atxt{2})#Length:C16(($DocBDEPT_txt+"_"+$DocBIN_txt)))
														$Error_txt:="Misnamed Folder : incorrect length"+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
														
													Else 
														$Error_txt:="Misnamed Folder"+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
														
												End case 
												
												
											End if 
										Else 
											$TownPrefix_txt:=Substring:C12($Parts_atxt{$PartSize_L}; 1; 3)+"@"
											
											$TownDirectoryPosition_L:=Find in array:C230($TownFolders_atxt; $TownPrefix_txt; 1)
											
											If ($TownDirectoryPosition_L>0)
												$Townfolder_txt:=$Directory_txt+Folder separator:K24:12+$TownFolders_atxt{$TownDirectoryPosition_L}+Folder separator:K24:12+$DocBDEPT_txt+"_"+$DocBIN_txt
												If (Test path name:C476($Townfolder_txt)=Is a folder:K24:2)
												Else 
													If ($CreateandMoveEtc_B)
														CREATE FOLDER:C475($Townfolder_txt)
													Else 
														$Error_txt:="Could not create folder "+$Townfolder_txt+Char:C90(Carriage return:K15:38)
														SEND PACKET:C103($doc_tm; $Error_txt)
														$Error_txt:=""
													End if 
												End if 
												4DError_b:=False:C215
												ON ERR CALL:C155("4D_Errors")
												$OldPath_txt:=$Directory_txt+Folder separator:K24:12+$TownFolders_atxt{$TownDirectoryPosition_L}+$CompletePaths_atxt{$DocumentLoop_l}
												If ($CreateandMoveEtc_B)
													If (MR_CheckandResetDocumentLock($OldPath_txt; False:C215))
														MOVE DOCUMENT:C540($OldPath_txt; $Townfolder_txt+Folder separator:K24:12+$Parts_atxt{$PartSize_L})
														If (Not:C34(4DError_b))
															If (MR_CheckandResetDocumentLock($Townfolder_txt+Folder separator:K24:12+$Parts_atxt{$PartSize_L}; True:C214))
																$Error_txt:="Moved document "+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+"From "+$Directory_txt+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Tab:K15:37)+"To "+$Townfolder_txt+$Parts_atxt{$PartSize_L}+Char:C90(Carriage return:K15:38)
															Else 
																$Error_txt:="Moved but could not reset lock "+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$Townfolder_txt+$Parts_atxt{$PartSize_L}+Char:C90(Carriage return:K15:38)
															End if 
														Else 
															$Error_txt:="Must be moved manually - move command failed "+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
															
														End if 
													Else 
														$Error_txt:="Must be moved manually - could not reset lock "+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
													End if 
												Else 
													$Error_txt:="Must be moved manually - could not reset lock "+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
												End if 
											Else 
												$Error_txt:="Must be moved manually "+Char:C90(Tab:K15:37)+$Parts_atxt{$PartSize_L}+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
											End if 
										End if 
										
									End if 
									
							End case 
							
						Else 
							$Error_txt:="Mismatched document and town"+Char:C90(Tab:K15:37)+$TownPrefix_txt+Char:C90(Tab:K15:37)+$CompletePaths_atxt{$DocumentLoop_l}+Char:C90(Carriage return:K15:38)
						End if 
						If ($Error_txt#"")
							SEND PACKET:C103($doc_tm; $Error_txt)
						End if 
						
						
						
						
					End if 
				End if 
			End for 
			
			//quit progress
			Progress QUIT(OB Get:C1224($TownFilesProgress_obj; "progress"; Is longint:K8:6))
			
		End for 
		
		
		Progress QUIT(OB Get:C1224($TownProgress_obj; "progress"; Is longint:K8:6))
		ALERT:C41("Complete")
		CLOSE DOCUMENT:C267($doc_tm)
		
	End if 
End if 
CLOSE DOCUMENT:C267($doc_tm)

//End ut_MoveRatingsFromTownFolder