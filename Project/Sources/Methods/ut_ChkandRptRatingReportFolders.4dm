//%attributes = {"invisible":true}
//Method: ut_ChkandRptRatingReportFolders
//Description
//Thid method will traverse the rating report folders and report on discrepent folder or file names
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/07/17, 12:53:27
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//
C_TIME:C306($doc_tm)
C_TEXT:C284($ReportPath_txt; $Error_txt)
$ReportPath_txt:=Select folder:C670("Select report folder")
$ReportPath_txt:=$ReportPath_txt+"ChkandRptRatingReportFolders"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"
$Doc_tm:=Create document:C266($ReportPath_txt)
If (OK=1)
	
	ARRAY TEXT:C222($Level1Folders_atxt; 0)
	ARRAY TEXT:C222($Level1Files_atxt; 0)
	
	ARRAY TEXT:C222($Level2Folders_atxt; 0)
	ARRAY TEXT:C222($Level2Files_atxt; 0)
	
	ARRAY TEXT:C222($Level3Folders_atxt; 0)
	ARRAY TEXT:C222($Level3Ffiles_atxt; 0)
	ARRAY TEXT:C222($Level4Folders_atxt; 0)
	ARRAY TEXT:C222($Level4Ffiles_atxt; 0)
	
	C_TEXT:C284($StartingFolder_txt)
	ARRAY TEXT:C222($TownFolders_atxt; 0)
	
	$StartingFolder_txt:=Select folder:C670("Select starting rating report folder")
	FOLDER LIST:C473($StartingFolder_txt; $TownFolders_atxt)
	ARRAY TEXT:C222($TownName_atxt; 0)
	ARRAY TEXT:C222($BDeptPrefix_atxt; 0)
	
	ARRAY TEXT:C222($BridgeBin_atxt; 0)
	ARRAY TEXT:C222($BridgeBDEPT_atxt; 0)
	C_TEXT:C284($CalcTownName_txt; $CurrentPath_txt; $Level1BDEPT_txt; $Level1BIN_txt; $Level2BDEPT_txt; $Level2BIN_txt; $Level3BDEPT_txt; $Level3BIN_txt; $Level4BDEPT_txt; $Level4BIN_txt)
	
	
	Begin SQL
		select
		[Town Data].[BDEPT Prefix],
		[Town Data].[Town Name]
		from
		[Town Data]
		into
		:$BDeptPrefix_atxt,
		:$TownName_atxt;
		
		
		select 
		[Bridge MHD NBIS].[BIN],
		[Bridge MHD NBIS].[BDEPT]
		from
		[Bridge MHD NBIS]
		into
		:$BridgeBin_atxt,
		:$BridgeBDEPT_atxt;
	End SQL
	
	C_LONGINT:C283($TownList_l; $InnerLoop_L; $InnerLoop1_L; $InnerLoop2_L; $InnerLoop3_L; $Pos_L)
	C_TEXT:C284($PathForProperties_txt)
	//start the bar
	C_OBJECT:C1216($TownProgress_obj; $TownFolder_obj)
	$TownProgress_obj:=ProgressNew("Scanning Town Folders "; Size of array:C274($TownFolders_atxt); True:C214; " Towns"; 3)
	
	For ($TownList_l; 1; Size of array:C274($TownFolders_atxt))
		//update progress
		UpdateProgressNew($TownProgress_obj; $TownList_l)
		
		Case of 
			: (Position:C15("Various"; $TownFolders_atxt{$TownList_l})>0)
			: (Position:C15("C13052"; $TownFolders_atxt{$TownList_l})>0)
			Else 
				ARRAY TEXT:C222($TownParts_atxt; 0)
				ut_NewTextToArray($TownFolders_atxt{$TownList_l}; ->$TownParts_atxt; " ")
				
				$Pos_L:=Find in array:C230($BDeptPrefix_atxt; $TownParts_atxt{1})
				If ($Pos_L<0)
					$Error_txt:=$TownFolders_atxt{$TownList_l}+Char:C90(Tab:K15:37)+"Missing BDEPT prefix data for "+$TownParts_atxt{1}+Char:C90(Tab:K15:37)+$TownParts_atxt{2}+Char:C90(Tab:K15:37)
				End if 
				$CalcTownName_txt:=Substring:C12($TownFolders_atxt{$TownList_l}; Position:C15(" "; $TownFolders_atxt{$TownList_l})+1)
				If ($TownName_atxt{$Pos_L}#$CalcTownName_txt)
					$Error_txt:=$Error_txt+"Town name mismatch for "+$CalcTownName_txt
				End if 
				If ($Error_txt#"")
					SEND PACKET:C103($doc_tm; $Error_txt+Char:C90(Carriage return:K15:38))
				End if 
				
				$CurrentPath_txt:=$StartingFolder_txt+$TownFolders_atxt{$TownList_l}+Folder separator:K24:12
				ARRAY TEXT:C222($Level1Folders_atxt; 0)
				ARRAY TEXT:C222($Level1Files_atxt; 0)
				DOCUMENT LIST:C474($CurrentPath_txt; $Level1Files_atxt)
				FOLDER LIST:C473($CurrentPath_txt; $Level1Folders_atxt)
				C_BOOLEAN:C305($locked_B; $invisible_B)
				C_DATE:C307($CreatedOn_d; $ModifiedOn_d)
				C_TIME:C306($Created_tm; $Modified_tm)
				
				//start the bar
				C_OBJECT:C1216($TownFolder_obj)
				$TownFolder_obj:=ProgressNew("Loose Town Files"; Size of array:C274($Level1Files_atxt); True:C214; " File"; 3)
				
				For ($InnerLoop_L; 1; Size of array:C274($Level1Files_atxt))
					//update progress
					UpdateProgressNew($TownFolder_obj; $InnerLoop_L)
					
					$PathForProperties_txt:=$CurrentPath_txt+$Level1Files_atxt{$InnerLoop_L}
					GET DOCUMENT PROPERTIES:C477($PathForProperties_txt; $locked_B; $invisible_B; $CreatedOn_d; $Created_tm; $ModifiedOn_d; $Modified_tm)
					If (Not:C34($invisible_B))
						
						$Level1BDEPT_txt:=Substring:C12($Level1Files_atxt{$InnerLoop_L}; 1; 6)
						$Level1BIN_txt:=Substring:C12($Level1Files_atxt{$InnerLoop_L}; 8; 3)
						
						$Error_txt:=""
						$Pos_L:=Find in array:C230($BridgeBin_atxt; $Level1BIN_txt)
						If ($Pos_L<0)
							$Error_txt:="Missing BIN data for "+$Level1BDEPT_txt+Char:C90(Tab:K15:37)+$Level1BIN_txt+Char:C90(Tab:K15:37)
						Else 
							If ($BridgeBDEPT_atxt{$Pos_L}#$Level1BDEPT_txt)
								$Error_txt:=$Error_txt+"BDEPT mismatch for "+$Level1BDEPT_txt+Char:C90(Tab:K15:37)+$Level1BIN_txt
							End if 
							
						End if 
						If ($Error_txt#"")
							SEND PACKET:C103($doc_tm; $PathForProperties_txt+Char:C90(Tab:K15:37)+"Mismatch error in directory path for "+Char:C90(Tab:K15:37)+$Error_txt+Char:C90(Carriage return:K15:38))
							$Error_txt:=""
						End if 
					End if 
					//check if progress stopped
					If (Progress Stopped(OB Get:C1224($TownFolder_obj; "progress"; Is longint:K8:6)))
						//abort loop
						$InnerLoop_L:=Size of array:C274($Level1Files_atxt)+1
					End if 
					
				End for 
				//quit progress
				Progress QUIT(OB Get:C1224($TownFolder_obj; "progress"; Is longint:K8:6))
				
				$TownFolder_obj:=ProgressNew("Scanning Town Bridge Folders"; Size of array:C274($Level1Folders_atxt); True:C214; " Bridge Folder"; 3)
				
				For ($InnerLoop_L; 1; Size of array:C274($Level1Folders_atxt))
					//update progress
					UpdateProgressNew($TownFolder_obj; $InnerLoop_L)
					
					If ($Level1Folders_atxt{$InnerLoop_L}="Other")
					Else 
						$Level1BDEPT_txt:=Substring:C12($Level1Folders_atxt{$InnerLoop_L}; 1; 6)
						$Level1BIN_txt:=Substring:C12($Level1Folders_atxt{$InnerLoop_L}; 8; 3)
						
						If (Substring:C12($Level1BDEPT_txt; 1; 3)=$TownParts_atxt{1})
							
							$Error_txt:=""
							
							If (Length:C16($Level1Folders_atxt{$InnerLoop_L})#10)
								SEND PACKET:C103($doc_tm; $Level1Folders_atxt{$InnerLoop_L}+Char:C90(Tab:K15:37)+"Potential name error incorrect length"+Char:C90(Carriage return:K15:38))
							End if 
							
							$Pos_L:=Find in array:C230($BridgeBin_atxt; $Level1BIN_txt)
							If ($Pos_L<0)
								$Error_txt:="Missing BIN data for "+$Level1BDEPT_txt+Char:C90(Tab:K15:37)+$Level1BIN_txt+Char:C90(Tab:K15:37)
							Else 
								If ($BridgeBDEPT_atxt{$Pos_L}#$Level1BDEPT_txt)
									$Error_txt:=$Error_txt+"BDEPT mismatch for "+$Level1BDEPT_txt+Char:C90(Tab:K15:37)+$Level1BIN_txt
								End if 
							End if 
						Else 
							
							SEND PACKET:C103($doc_tm; $Level1Folders_atxt{$InnerLoop_L}+Char:C90(Tab:K15:37)+"Folder not correctly named in for "+$TownFolders_atxt{$TownList_l}+Char:C90(Carriage return:K15:38))
							
						End if 
						
						If ($Error_txt#"")
							SEND PACKET:C103($doc_tm; $Level1Folders_atxt{$InnerLoop_L}+Char:C90(Tab:K15:37)+$Error_txt+Char:C90(Carriage return:K15:38))
							$Error_txt:=""
						End if 
						DOCUMENT LIST:C474($CurrentPath_txt+$Level1Folders_atxt{$InnerLoop_L}+Folder separator:K24:12; $Level2Files_atxt)
						FOLDER LIST:C473($CurrentPath_txt+$Level1Folders_atxt{$InnerLoop_L}+Folder separator:K24:12; $Level2Folders_atxt)
						For ($InnerLoop2_L; 1; Size of array:C274($Level2Files_atxt))
							
							$PathForProperties_txt:=$CurrentPath_txt+$Level1Folders_atxt{$InnerLoop_L}+Folder separator:K24:12+$Level2Files_atxt{$InnerLoop2_L}
							GET DOCUMENT PROPERTIES:C477($PathForProperties_txt; $locked_B; $invisible_B; $CreatedOn_d; $Created_tm; $ModifiedOn_d; $Modified_tm)
							If (Not:C34($invisible_B))
								$Level2BDEPT_txt:=Substring:C12($Level2Files_atxt{$InnerLoop2_L}; 1; 6)
								$Level2BIN_txt:=Substring:C12($Level2Files_atxt{$InnerLoop2_L}; 8; 3)
								
								$Error_txt:=""
								
								If ($Level2BDEPT_txt#$Level1BDEPT_txt)
									$Error_txt:=$Level2BDEPT_txt+" does not match "+$Level1BDEPT_txt
								End if 
								If ($Level2BIN_txt#$Level1BIN_txt)
									$Error_txt:=$Error_txt+$Level2BIN_txt+" does not match "+$Level1BIN_txt
								End if 
								
							End if 
							If ($Error_txt#"")
								SEND PACKET:C103($doc_tm; $PathForProperties_txt+Char:C90(Tab:K15:37)+"Mismatch error in directory path for "+Char:C90(Tab:K15:37)+$Error_txt+Char:C90(Carriage return:K15:38))
								$Error_txt:=""
							End if 
							
							
						End for 
						For ($InnerLoop2_L; 1; Size of array:C274($Level2Folders_atxt))
							If ($Level2Folders_atxt{$InnerLoop2_L}="Other")
							Else 
								DOCUMENT LIST:C474($CurrentPath_txt+$Level1Folders_atxt{$InnerLoop_L}+Folder separator:K24:12+$Level2Folders_atxt{$InnerLoop2_L}+Folder separator:K24:12; $Level3Files_atxt)
								For ($InnerLoop3_L; 1; Size of array:C274($Level3Files_atxt))
									$PathForProperties_txt:=$CurrentPath_txt+$Level1Folders_atxt{$InnerLoop_L}+Folder separator:K24:12+$Level2Folders_atxt{$InnerLoop2_L}+Folder separator:K24:12+$Level3Files_atxt{$InnerLoop3_L}
									GET DOCUMENT PROPERTIES:C477($PathForProperties_txt; $locked_B; $invisible_B; $CreatedOn_d; $Created_tm; $ModifiedOn_d; $Modified_tm)
									
									If (Not:C34($invisible_B))
										
										$Level3BDEPT_txt:=Substring:C12($Level3Files_atxt{$InnerLoop3_L}; 1; 6)
										$Level3BIN_txt:=Substring:C12($Level3Files_atxt{$InnerLoop3_L}; 8; 3)
										
										
										$Error_txt:=""
										If ($Level3BDEPT_txt#$Level1BDEPT_txt)
											$Error_txt:=$Level3BDEPT_txt+" does not match "+$Level1BDEPT_txt
										End if 
										If ($Level3BIN_txt#$Level1BIN_txt)
											$Error_txt:=$Error_txt+$Level3BIN_txt+" does not match "+$Level1BIN_txt
										End if 
										
										If ($Error_txt#"")
											SEND PACKET:C103($doc_tm; $PathForProperties_txt+Char:C90(Tab:K15:37)+"Mismatch error in directory path "+" for "+Char:C90(Tab:K15:37)+$Error_txt+Char:C90(Carriage return:K15:38))
											$Error_txt:=""
										End if 
									End if 
									C_TEXT:C284($FolderPathForProperties_txt)
									$FolderPathForProperties_txt:=$CurrentPath_txt+$Level1Folders_atxt{$InnerLoop_L}+Folder separator:K24:12+$Level2Folders_atxt{$InnerLoop2_L}+Folder separator:K24:12+"Previous Rating Reports"
									If (Test path name:C476($FolderPathForProperties_txt)=Is a folder:K24:2)
										ARRAY TEXT:C222($Level4Files_atxt; 0)
										
										DOCUMENT LIST:C474($FolderPathForProperties_txt; $Level4Files_atxt)
										For ($InnerLoop3_L; 1; Size of array:C274($Level4Files_atxt))
											$PathForProperties_txt:=$FolderPathForProperties_txt+Folder separator:K24:12+$Level4Files_atxt{$InnerLoop3_L}
											GET DOCUMENT PROPERTIES:C477($PathForProperties_txt; $locked_B; $invisible_B; $CreatedOn_d; $Created_tm; $ModifiedOn_d; $Modified_tm)
											
											If (Not:C34($invisible_B))
												
												$Level4BDEPT_txt:=Substring:C12($Level4Files_atxt{$InnerLoop3_L}; 1; 6)
												$Level4BIN_txt:=Substring:C12($Level4Files_atxt{$InnerLoop3_L}; 8; 3)
												
												
												$Error_txt:=""
												If ($Level4BDEPT_txt#$Level1BDEPT_txt)
													$Error_txt:=$Level4BDEPT_txt+" does not match "+$Level1BDEPT_txt
												End if 
												If ($Level4BIN_txt#$Level1BIN_txt)
													$Error_txt:=$Error_txt+$Level4BIN_txt+" does not match "+$Level1BIN_txt
												End if 
												
												If ($Error_txt#"")
													SEND PACKET:C103($doc_tm; $PathForProperties_txt+Char:C90(Tab:K15:37)+"Mismatch error in directory path for "+Char:C90(Tab:K15:37)+$Error_txt+Char:C90(Carriage return:K15:38))
													$Error_txt:=""
												End if 
											End if 
											
											
											
											
										End for 
										
									End if 
								End for 
							End if 
						End for 
					End if 
					//check if progress stopped
					If (Progress Stopped(OB Get:C1224($TownFolder_obj; "progress"; Is longint:K8:6)))
						//abort loop
						$InnerLoop_L:=Size of array:C274($Level1Files_atxt)+1
					End if 
					
				End for 
				//quit progress
				Progress QUIT(OB Get:C1224($TownFolder_obj; "progress"; Is longint:K8:6))
				
		End case 
		
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($TownProgress_obj; "progress"; Is longint:K8:6)))
			//abort loop
			$TownList_l:=Size of array:C274($TownFolders_atxt)+1
		End if 
		
	End for 
	//quit progress
	Progress QUIT(OB Get:C1224($TownProgress_obj; "progress"; Is longint:K8:6))
	
	CLOSE DOCUMENT:C267($doc_tm)
	SHOW ON DISK:C922($ReportPath_txt)
	ALERT:C41("Complete")
End if 
//End ut_ChkandRptRatingReportFolders