//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/03/08, 11:45:48
	// ----------------------------------------------------
	// Method: ut_PRJUpdateConsName
	// Description
	// update cons ids from two text files : 
	//   one must have the matches of names in LRA xls with names in Conslt_name table
	//   second is the extract of projects with consnames from the LRA xls
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403  //Copied to Server on : 06/16/08, 16:54:01
	// Modified by: costasmanousakis-(Designer)-(6/18/08 15:38:53)
	Mods_2008_CM_5403  //Enhancement 1
	Mods_2009_05  //r001  `05/08/09, 15:01:06  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//[PRJ_ProjectFile]DC_DesignContractID_l to [PRJ_ProjectDetails]DC_DesignContractID_l
	//one timer
	Mods_2009_06  //r002 `06/11/09, 13:40:39   `Merge PRJ Design Contract Changes
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (False:C215)
	C_LONGINT:C283($PFDesConsID_L; $DesConIndx; $PrefConsID_L)
	C_TIME:C306($File1; $File2; $msgfile)
	ALERT:C41("Choose file with name matches")
	$File1:=Open document:C264(""; Read mode:K24:5)
	If (OK=1)
		ARRAY LONGINT:C221($ConsIDs_aL; 1000)
		ARRAY LONGINT:C221($LinkPriority_aL; 1000)
		ARRAY TEXT:C222($LRANames_atxt; 1000)
		ARRAY TEXT:C222($DBNames_atxt; 1000)
		C_TEXT:C284($TBuffer)
		C_LONGINT:C283($CID_L; $lineCount_L)
		C_TEXT:C284($LRAname_txt)
		C_BOOLEAN:C305($Going_b)
		RECEIVE PACKET:C104($File1; $TBuffer; <>sCR)
		$Going_b:=True:C214
		$lineCount_L:=0
		SHORT_MESSAGE("Scanning File 1 ....")
		While ($Going_b)
			$TBuffer:=Replace string:C233($TBuffer; <>sLF; "")
			$CID_L:=Num:C11(Substring:C12($TBuffer; 1; (Position:C15(<>sTAB; $TBuffer)-1)))
			If ($CID_L>0)
				$lineCount_L:=$lineCount_L+1
				$ConsIDs_aL{$lineCount_L}:=$CID_L
				$TBuffer:=Substring:C12($TBuffer; (Position:C15(<>sTAB; $TBuffer)+1))
				$LRANames_atxt{$lineCount_L}:=Substring:C12($TBuffer; 1; (Position:C15(<>sTAB; $TBuffer)-1))
				$TBuffer:=Substring:C12($TBuffer; (Position:C15(<>sTAB; $TBuffer)+1))
				$DBNames_atxt{$lineCount_L}:=Substring:C12($TBuffer; 1; (Position:C15(<>sTAB; $TBuffer)-1))
				$TBuffer:=Substring:C12($TBuffer; (Position:C15(<>sTAB; $TBuffer)+1))
				$LinkPriority_aL{$lineCount_L}:=Num:C11($TBuffer)
			End if 
			
			RECEIVE PACKET:C104($File1; $TBuffer; <>sCR)
			If (OK=1)
			Else 
				If ($TBuffer="")
					$Going_b:=False:C215
				End if 
				
			End if 
			
		End while 
		CLOSE WINDOW:C154
		CLOSE DOCUMENT:C267($File1)
		ARRAY LONGINT:C221($ConsIDs_aL; $lineCount_L)
		ARRAY TEXT:C222($LRANames_atxt; $lineCount_L)
		ARRAY TEXT:C222($DBNames_atxt; $lineCount_L)
		ARRAY LONGINT:C221($LinkPriority_aL; $lineCount_L)
		ALERT:C41("Choose file with the project-cons list")
		$File1:=Open document:C264(""; Read mode:K24:5)
		If (OK=1)
			C_TEXT:C284($LineBRNo_txt; $LinePFile_txt; $LineCons_txt; $Document_txt)
			C_LONGINT:C283($LinePFile_L; $ConsIDmatch_L; $k; $MatchK_L)
			RECEIVE PACKET:C104($File1; $TBuffer; <>sCR)
			$Document_txt:=(Document+ut_CreateTimeStamp)
			$msgfile:=Create document:C266($Document_txt; "TEXT")
			//_ O _SET DOCUMENT CREATOR($Document_txt;"ttxt")  //TextWrangler
			$Going_b:=True:C214
			$lineCount_L:=0
			SHORT_MESSAGE("Scanning File 2 ....")
			READ ONLY:C145([PRJ_ProjectDetails:115])
			READ ONLY:C145([PRJ_ProjectFile:117])
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			While ($Going_b)
				ARRAY LONGINT:C221($matchIDs_aL; 0)
				ARRAY LONGINT:C221($matchIDsPrio_aL; 0)
				ARRAY LONGINT:C221($matchIDs_aL; 10)
				ARRAY LONGINT:C221($matchIDsPrio_aL; 10)
				$TBuffer:=Replace string:C233($TBuffer; <>sLF; "")
				$LineBRNo_txt:=Substring:C12($TBuffer; 1; (Position:C15(<>sTAB; $TBuffer)-1))
				$TBuffer:=Substring:C12($TBuffer; (Position:C15(<>sTAB; $TBuffer)+1))
				$LinePFile_txt:=Substring:C12($TBuffer; 1; (Position:C15(<>sTAB; $TBuffer)-1))
				$TBuffer:=Substring:C12($TBuffer; (Position:C15(<>sTAB; $TBuffer)+1))
				$TBuffer:=Substring:C12($TBuffer; (Position:C15(<>sTAB; $TBuffer)+1))
				$LineCons_txt:=$TBuffer
				$LineBRNo_txt:=Replace string:C233($LineBRNo_txt; <>sQU; "")
				
				$k:=Find in array:C230($LRANames_atxt; $LineCons_txt)
				$MatchK_L:=0
				If ($LineCons_txt#"")
					While ($k>0)
						$MatchK_L:=$MatchK_L+1
						$matchIDs_aL{$MatchK_L}:=$ConsIDs_aL{$k}
						$matchIDsPrio_aL{$MatchK_L}:=$LinkPriority_aL{$k}
						$k:=Find in array:C230($LRANames_atxt; $LineCons_txt; ($k+1))
					End while 
					
				End if 
				
				If ($LineCons_txt#"")
					C_BOOLEAN:C305($PFileFound_b; $DesConFound_b)
					$PFileFound_b:=False:C215
					$DesConFound_b:=False:C215
					ARRAY LONGINT:C221($matchIDsPrio_aL; $MatchK_L)
					ARRAY LONGINT:C221($matchIDs_aL; $MatchK_L)
					If (Find in array:C230($matchIDsPrio_aL; 1)>0)
						$PFDesConsID_L:=0
						If (Size of array:C274($matchIDs_aL)>0)  //do this only if there is a match
							QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5=$LineBRNo_txt)
							If (Records in selection:C76([PRJ_ProjectDetails:115])=0)
								QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7=$LineBRNo_txt)
							Else 
								
							End if 
							
							If (Records in selection:C76([PRJ_ProjectDetails:115])=1)
								If ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#0)
									$PFDesConsID_L:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
								Else 
									QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
									$DesConFound_b:=(Records in selection:C76([PRJ_DesignContracts:123])=1)
									If (Records in selection:C76([PRJ_DesignContracts:123])=1)
										$PFDesConsID_L:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
									End if 
									
								End if 
								If (False:C215)
									If ([PRJ_ProjectDetails:115]PF_FileID_l:3#0)
										QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
										$PFileFound_b:=(Records in selection:C76([PRJ_ProjectFile:117])=1)
										If (Records in selection:C76([PRJ_ProjectFile:117])=1)
											If ([PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15#0)
												$PFDesConsID_L:=[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15
											Else 
												QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectFile:117]DC_OLDDesignContractID_l:2)
												$DesConFound_b:=(Records in selection:C76([PRJ_DesignContracts:123])=1)
												If (Records in selection:C76([PRJ_DesignContracts:123])=1)
													$PFDesConsID_L:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
												End if 
											End if 
											
										End if 
										
									End if 
								End if 
								If (Find in array:C230($matchIDs_aL; $PFDesConsID_L)>0)
									//Matched consultant with what is in DB
								Else 
									$k:=Find in array:C230($matchIDsPrio_aL; 1)
									$PrefConsID_L:=$matchIDs_aL{$k}  //get the preferred ID
									$k:=Find in array:C230($ConsIDs_aL; $PrefConsID_L)
									Case of 
										: (Not:C34($PFileFound_b))  //Did not find proj file record - have to create one dummy and put cons override
											If (ut_LoadRecordInteractive(->[PRJ_ProjectDetails:115]))
												CREATE RECORD:C68([PRJ_ProjectFile:117])
												Inc_Sequence("PF_FileID_l"; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
												[PRJ_ProjectFile:117]PF_FileNumber_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1*-1
												[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15:=$PrefConsID_L
												SAVE RECORD:C53([PRJ_ProjectFile:117])
												[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
												QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=$PrefConsID_L)
												SAVE RECORD:C53([PRJ_ProjectDetails:115])
												SEND PACKET:C103($msgfile; "Created hidden PFILE for project "+$LineBRNo_txt+" with override for "+[Conslt_Name:127]ConsultantName_s:2+<>sCR)
											Else 
												ALERT:C41("Could not load record for Project "+$LineBRNo_txt+". No cons update done!")
											End if 
											
										: ($DesConFound_b)  //found PFile and  des contract
											//Check if we are to override
											QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
											$DesConIndx:=Find in array:C230($matchIDs_aL; [PRJ_DesignContracts:123]ConsultantNameID_l:2)
											If ($DesConIndx>0)
												//Current consultant does not match with
												SEND PACKET:C103($msgfile; "Matched Design Contract Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
											Else 
												CONFIRM:C162("Override consultant "+[Conslt_Name:127]ConsultantName_s:2+" with "+$DBNames_atxt{$k}+" for Project "+$LineBRNo_txt+"?")
												If (OK=1)
													QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
													If (ut_LoadRecordInteractive(->[PRJ_ProjectFile:117]))
														[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15:=$PrefConsID_L
														SAVE RECORD:C53([PRJ_ProjectFile:117])
														SEND PACKET:C103($msgfile; "Overrode Design Contract Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
													Else 
														ALERT:C41("Could not load Project file record with ID "+String:C10([PRJ_ProjectDetails:115]PF_FileID_l:3)+" for Project "+$LineBRNo_txt)
														SEND PACKET:C103($msgfile; "Could not Override Design Contract Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
													End if 
												Else 
													SEND PACKET:C103($msgfile; "Cancel Override Design Contract Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
												End if 
												
											End if 
											
											
										: (Not:C34($DesConFound_b))  //found PFile and no des contract
											If ($PFDesConsID_L>0)
												//there was an override already
												QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=$PFDesConsID_L)
												$DesConIndx:=Find in array:C230($matchIDs_aL; $PFDesConsID_L)
												If ($DesConIndx>0)
													SEND PACKET:C103($msgfile; "Matched current override of Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
												Else 
													CONFIRM:C162("Change Current override of "+[Conslt_Name:127]ConsultantName_s:2+" with "+$DBNames_atxt{$k}+" for Project "+$LineBRNo_txt)
													If (OK=1)
														QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
														If (ut_LoadRecordInteractive(->[PRJ_ProjectFile:117]))
															[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15:=$PrefConsID_L
															SEND PACKET:C103($msgfile; "Replaced override of Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
															SAVE RECORD:C53([PRJ_ProjectFile:117])
														Else 
															ALERT:C41("Could not load Project file record with ID "+String:C10([PRJ_ProjectDetails:115]PF_FileID_l:3)+" for Project "+$LineBRNo_txt)
															SEND PACKET:C103($msgfile; "Could not Replace override of Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
														End if 
													Else 
														SEND PACKET:C103($msgfile; "Cancel Replace override of Cons for project "+$LineBRNo_txt+" from "+[Conslt_Name:127]ConsultantName_s:2+" to "+$DBNames_atxt{$k}+<>sCR)
													End if 
													
												End if 
												
												
											Else 
												//Put the override
												QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
												If (ut_LoadRecordInteractive(->[PRJ_ProjectFile:117]))
													[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15:=$PrefConsID_L
													SEND PACKET:C103($msgfile; "Added override of Cons for project "+$LineBRNo_txt+" to "+$DBNames_atxt{$k}+<>sCR)
													SAVE RECORD:C53([PRJ_ProjectFile:117])
												Else 
													ALERT:C41("Could not load Project file record with ID "+String:C10([PRJ_ProjectDetails:115]PF_FileID_l:3)+" for Project "+$LineBRNo_txt)
													SEND PACKET:C103($msgfile; "Could not load override of Cons for project "+$LineBRNo_txt+" to "+$DBNames_atxt{$k}+<>sCR)
												End if 
											End if 
									End case 
									
								End if 
							Else 
								//No proj detail record
								SEND PACKET:C103($msgfile; "Error! Project "+$LineBRNo_txt+" does not have a Project Details record! it should be imported!"+<>sCR)
							End if 
							
						End if 
					Else 
						SEND PACKET:C103($msgfile; "Error! Cannot find prefered ID for consultant <"+$LineCons_txt+"> for project "+$LineBRNo_txt+<>sCR)
						//ALERT("Error! Cannot find prefered ID for consultant "+$LineCons_txt+" for project "+$LineBRNo_txt)
					End if 
					
				End if 
				
				
				RECEIVE PACKET:C104($File1; $TBuffer; <>sCR)
				If (OK=1)
				Else 
					If ($TBuffer="")
						$Going_b:=False:C215
					End if 
					
				End if 
				
			End while 
			CLOSE WINDOW:C154
			CLOSE DOCUMENT:C267($File1)
			CLOSE DOCUMENT:C267($msgfile)
			SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			
		End if 
		
		ARRAY LONGINT:C221($ConsIDs_aL; 0)
		ARRAY TEXT:C222($LRANames_atxt; 0)
		
	End if 
End if 