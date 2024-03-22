//%attributes = {"invisible":true}
//Method: NTI_ut_UpdateDEFS
//Description
// Update definitions for NTI elements from a spreadsheet saved in xml format supplied by
//J Rigney.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/12/17, 13:52:53
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
End if 
//
C_TIME:C306($doc_t)
C_TEXT:C284($doc_txt)
C_TEXT:C284($DocTree_txt; $RowTree_txt; $CellTree_txt; $entName_txt; $entVal_txt; $elname_txt; $elPrefix_txt)
C_TEXT:C284($BIN_s; $Line_s; $docEnc_txt; $DocVer_txt; $BrgNo_txt; $BDEPTErr_txt; $BINErrmsg_txt; $elmVal_txt; $yrBlt_recon; $Carry_s; $CategoryErr_txt)
C_DATE:C307($I90_d; $Rtg_d)
C_LONGINT:C283($yrBlt_L; $yrRecon)
C_TEXT:C284($i58_txt; $i59_txt; $i60_txt; $i64_txt; $i66_txt; $brgType_txt; $Ra1_txt; $Ra2_txt; $Ra3_txt; $Rb1_txt; $Rb2_txt; $Rb3_txt; $Rc1_txt; $Rc2_txt; $Rc3_txt)
C_BOOLEAN:C305($stand_b; $rowEnd_b)
C_BOOLEAN:C305($CategoryLine_b; $ElementLine_b; $DefectLine_b)

C_TEXT:C284($ElemNo_txt; $ElemName_txt; $ElemUnits; $ElemTinOnly_txt; $ElemRollUp_txt; $ElemSpec_txt; $ElemCommentary_txt)
C_TEXT:C284($ElemCS1_txt; $ElemCS2_txt; $ElemCS3_txt; $ElemCS4_txt; $LastElemCS4_txt)
C_TEXT:C284($Category_txt)
ARRAY TEXT:C222($elAttrNames_atxt; 0)
ARRAY TEXT:C222($elAttrVals_atxt; 0)
ARRAY LONGINT:C221($DefectNos_aL; 0)
ARRAY TEXT:C222($DefectNames_atxt; 0)
ARRAY TEXT:C222($DefectCS1_atxt; 0)
ARRAY TEXT:C222($DefectCS2_atxt; 0)
ARRAY TEXT:C222($DefectCS3_atxt; 0)
ARRAY TEXT:C222($DefectCS4_atxt; 0)

C_TEXT:C284(vsForward)

$LastElemCS4_txt:=""

$doc_t:=Open document:C264(""; ""; Read mode:K24:5)
C_LONGINT:C283($SaxEvent_L; $NumRows_L; $CurrDefectNo_L; $CurrElemNo_L; $DefectNo_L)
C_BOOLEAN:C305($inTable1Sheet_b; $saveDataToDB_b)
C_TEXT:C284($LangDefectTree_txt; $ElemDefectTree_txt; $ElemTree_txt; $ElemDefTree_txt; $defectState_txt; $ElemLangTree_txt)


If (Ok=1)
	InitChangeStack(1)
	ARRAY POINTER:C280($FieldsToSkip_aptr; 0)
	APPEND TO ARRAY:C911($FieldsToSkip_aptr; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4)
	//load trees
	C_TEXT:C284(NTI_DEFECT_ELEM_TREE; NTI_DEFECT_LANG_TREE)
	
	If (NTI_DEFECT_ELEM_TREE="")
		NTI_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("TIN"; "Element_DefectTree.xml")
	End if 
	If (NTI_DEFECT_LANG_TREE="")
		NTI_DEFECT_LANG_TREE:=ut_DOM_LoadXML("TIN"; "Defect_Language.xml")
	End if 
	//build arrays of Defect names, numbers and CS texts from the NTI_DEFECT_ELEM_TREE
	C_TEXT:C284($defectRef_txt; $stateRef_txt)
	ARRAY TEXT:C222($DefectRefs_atxt; 0)
	$defectRef_txt:=DOM Find XML element:C864(NTI_DEFECT_LANG_TREE; "NTIDEFECTLANG/Defect"; $DefectRefs_atxt)
	
	C_LONGINT:C283($loop_L; $defectVal_L)
	For ($loop_L; 1; Size of array:C274($DefectRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop_L}; $defectVal_L)
		If (Find in array:C230($DefectNos_aL; $defectVal_L)>0)
			//compare CSs
			ARRAY TEXT:C222($StateRefs_atxt; 0)
			C_TEXT:C284($CSTextStored_txt)
			$stateRef_txt:=DOM Find XML element:C864($DefectRefs_atxt{$loop_L}; "Defect/State"; $StateRefs_atxt)
			ARRAY TEXT:C222($StateLang_atxt; Size of array:C274($StateRefs_atxt))
			C_LONGINT:C283($loop2_L; $state_L)
			For ($loop2_L; 1; Size of array:C274($StateRefs_atxt))
				DOM GET XML ELEMENT VALUE:C731($StateRefs_atxt{$loop2_L}; $state_L)
				DOM GET XML ATTRIBUTE BY NAME:C728($StateRefs_atxt{$loop2_L}; "Language"; $StateLang_atxt{$loop2_L})
				Case of 
					: ($state_L=1)
						$CSTextStored_txt:=$DefectCS1_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
					: ($state_L=2)
						$CSTextStored_txt:=$DefectCS2_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
					: ($state_L=3)
						$CSTextStored_txt:=$DefectCS3_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
					: ($state_L=4)
						$CSTextStored_txt:=$DefectCS4_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
				End case 
				If ($CSTextStored_txt#$CSTextStored_txt)
					ALERT:C41("Multiple Defect entry for Defect "+String:C10($defectVal_L)+" with mismatch CS"+String:C10($state_L))
				End if 
			End for 
			
		Else 
			
			APPEND TO ARRAY:C911($DefectNos_aL; $defectVal_L)
			QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$defectVal_L)
			APPEND TO ARRAY:C911($DefectNames_atxt; [NTI_ELEM_DEFS:182]ELEM_LONGNAME:5)
			APPEND TO ARRAY:C911($DefectCS1_atxt; "")
			APPEND TO ARRAY:C911($DefectCS2_atxt; "")
			APPEND TO ARRAY:C911($DefectCS3_atxt; "")
			APPEND TO ARRAY:C911($DefectCS4_atxt; "")
			ARRAY TEXT:C222($StateRefs_atxt; 0)
			$stateRef_txt:=DOM Find XML element:C864($DefectRefs_atxt{$loop_L}; "Defect/State"; $StateRefs_atxt)
			ARRAY TEXT:C222($StateLang_atxt; Size of array:C274($StateRefs_atxt))
			C_LONGINT:C283($loop2_L; $state_L)
			For ($loop2_L; 1; Size of array:C274($StateRefs_atxt))
				DOM GET XML ELEMENT VALUE:C731($StateRefs_atxt{$loop2_L}; $state_L)
				DOM GET XML ATTRIBUTE BY NAME:C728($StateRefs_atxt{$loop2_L}; "Language"; $StateLang_atxt{$loop2_L})
				Case of 
					: ($state_L=1)
						$DefectCS1_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
					: ($state_L=2)
						$DefectCS2_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
					: ($state_L=3)
						$DefectCS3_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
					: ($state_L=4)
						$DefectCS4_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
				End case 
			End for 
			
		End if 
		
	End for 
	
	
	$inTable1Sheet_b:=False:C215
	$NumRows_L:=0
	C_TEXT:C284($LangDefectTree_txt; $ElemDefectTree_txt; $RowTree_txt)
	$LangDefectTree_txt:=DOM Create XML Ref:C861("NTIDEFECTLANG")  //new defect language tree
	$ElemDefectTree_txt:=DOM Create XML Ref:C861("NTI_ELEMDEFECTS")  // new element/defect tree
	//add element with creation info in both trees
	$RowTree_txt:=DOM Create XML element:C865($LangDefectTree_txt; "CreateInfo")
	DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CreatedBy4DUser"; Current user:C182)
	DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CreatedOsUser"; Current system user:C484)
	DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CreatedDateTime"; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*)))
	$RowTree_txt:=DOM Create XML element:C865($ElemDefectTree_txt; "CreateInfo")
	DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CreatedBy4DUser"; Current user:C182)
	DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CreatedOsUser"; Current system user:C484)
	DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CreatedDateTime"; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*)))
	
	$CurrElemNo_L:=0
	C_TEXT:C284($TableSheetname_txt)
	$TableSheetname_txt:=Request:C163("Name of Sheet with NTE table"; "element database")
	CONFIRM:C162("Save data to DB or report only?"; "ReportOnly"; "SaveData")
	$saveDataToDB_b:=(OK#1)
	C_LONGINT:C283($maxDefectKey_L)
	Begin SQL
		select max([NTI_ELEM_DEFS].[ELEM_KEY])
		from [NTI_ELEM_DEFS]
		where [NTI_ELEM_DEFS].[DEFECTFLAG] = 'Y'
		into :$maxDefectKey_L
	End SQL
	ut_StartMessage(3; "ReadingNTIXML"; 800; 400)
	ARRAY LONGINT:C221($CurrElemDefexts_aL; 0)
	ARRAY LONGINT:C221($mergedownCols_aL; 0)
	ARRAY LONGINT:C221($mergedownEndRow_aL; 0)
	ARRAY LONGINT:C221($mergedownStartRow_aL; 0)
	ARRAY TEXT:C222($mergeDownValue_atxt; 0)
	Repeat 
		$SaxEvent_L:=SAX Get XML node:C860($doc_t)
		
		Case of 
			: ($SaxEvent_L=XML start document:K45:7)
				SAX GET XML DOCUMENT VALUES:C873($doc_t; $docEnc_txt; $DocVer_txt; $stand_b)
			: ($SaxEvent_L=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
				If ($elname_txt="Worksheet")
					C_LONGINT:C283($sheetName_L)
					$sheetName_L:=Find in array:C230($elAttrNames_atxt; "@Name")
					If ($sheetName_L>0)
						$inTable1Sheet_b:=($elAttrVals_atxt{$sheetName_L}=$TableSheetname_txt)  // this must be the name of the sheet with the "table"
					End if 
				End if 
				
				If ($elname_txt="Row") & $inTable1Sheet_b
					$NumRows_L:=$NumRows_L+1
					$rowEnd_b:=False:C215
					$CategoryLine_b:=False:C215
					$ElementLine_b:=False:C215
					$DefectLine_b:=False:C215
					
					$Col_L:=0
					$ElemNo_txt:=""  //1
					$ElemName_txt:=""  //2
					$ElemUnits:=""  //3
					$ElemTinOnly_txt:="Y"  //9
					$ElemRollUp_txt:=""  //10
					$ElemSpec_txt:=""  //11
					$ElemCommentary_txt:=""  //12
					$ElemCS1_txt:=""  //11
					$ElemCS2_txt:=""  //12
					$ElemCS3_txt:=""  //13
					$ElemCS4_txt:=""  //14
					$CurrDefectNo_L:=0
					Repeat 
						$SaxEvent_L:=SAX Get XML node:C860($doc_t)
						C_LONGINT:C283($Col_L)
						Case of 
								
							: ($SaxEvent_L=XML end element:K45:11)
								SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
								If ($elname_txt="Row")
									$rowEnd_b:=True:C214
								End if 
								Case of 
									: (($ElemNo_txt="") & ($CurrElemNo_L>0) & ($ElemName_txt#""))
										$DefectLine_b:=True:C214
									: (bIsNumeric($ElemNo_txt))
										$ElementLine_b:=True:C214
								End case 
								//now process the data
								
								Case of 
									: ($DefectLine_b)
										$CurrDefectNo_L:=0
										If ($ElemName_txt="Use flow chart@")
											$ElemName_txt:="System Condition"
										End if 
										ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Defect for "+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+$ElemName_txt+Char:C90(13))
										C_LONGINT:C283($previndx_L)
										$previndx_L:=Find in array:C230(PON_HLP_Defects_atxt; $ElemName_txt)  //check if it is an existing defect for the current element
										If ($previndx_L>0)
											//it is in list of existing defects - compare data
											$CurrDefectNo_L:=pon_hlp_defects_aL{$previndx_L}
											C_BOOLEAN:C305($CSdiff_b)
											$CSdiff_b:=False:C215
											ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Exist Defect for Element "+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+$ElemName_txt+Char:C90(Tab:K15:37)+String:C10(pon_hlp_defects_aL{$previndx_L})+Char:C90(Tab:K15:37))
											If (PON_HLP_Defect_S1_atxt{$previndx_L}#$ElemCS1_txt)
												ut_Message("CS1 ["+PON_HLP_Defect_S1_atxt{$previndx_L}+"] # ["+$ElemCS1_txt+"]"+Char:C90(Tab:K15:37))
												$CSdiff_b:=True:C214
												
											End if 
											If (PON_HLP_Defect_S2_atxt{$previndx_L}#$ElemCS2_txt)
												ut_Message("CS2 ["+PON_HLP_Defect_S2_atxt{$previndx_L}+"] # ["+$ElemCS2_txt+"]"+Char:C90(Tab:K15:37))
												$CSdiff_b:=True:C214
												
											End if 
											If (PON_HLP_Defect_S3_atxt{$previndx_L}#$ElemCS3_txt)
												ut_Message("CS3 ["+PON_HLP_Defect_S3_atxt{$previndx_L}+"] # ["+$ElemCS3_txt+"]"+Char:C90(Tab:K15:37))
												$CSdiff_b:=True:C214
												
											End if 
											//special case for CS4 with mergedown cells
											If ($ElemCS4_txt="")
												//CS4 is col 14 - check if there is an entry
												C_LONGINT:C283($mergecellindx_L)
												$mergecellindx_L:=Find in array:C230($mergedownCols_aL; 14)
												If ($mergecellindx_L>0)  // this will also be true for the cell with the mergedown attr
													//check if our row is AFTER the first row and not past the last row
													If ($NumRows_L>$mergedownstartRow_aL{$mergecellindx_L}) & ($NumRows_L<=$mergedownEndRow_aL{$mergecellindx_L})
														//use the merge value from before  
														$ElemCS4_txt:=$mergeDownValue_atxt{$mergecellindx_L}
													End if 
												End if 
											End if 
											If (PON_HLP_Defect_S4_atxt{$previndx_L}#$ElemCS4_txt)
												ut_Message("CS4 ["+PON_HLP_Defect_S4_atxt{$previndx_L}+"] # ["+$ElemCS4_txt+"]"+Char:C90(Tab:K15:37))
												$CSdiff_b:=True:C214
												
											End if 
											ut_Message(Char:C90(Carriage return:K15:38))
											//
											
											If ($CSdiff_b)
												ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"Old number "+String:C10($CurrDefectNo_L)+" search for new number "+Char:C90(Carriage return:K15:38))
												//if any CS has changed now what? 
												// see if there is one with same name and same CSs
												//if not create new element - must remove old defect num from element defects and add the new one
												C_LONGINT:C283($DefectIndx_L)
												$DefectIndx_L:=Find in array:C230($DefectNames_atxt; $ElemName_txt)
												C_TEXT:C284($DefectLangCheck_txt)
												$DefectLangCheck_txt:=""
												$CurrDefectNo_L:=0
												If ($DefectIndx_L>0)
													
													Repeat 
														If ($ElemCS1_txt#$DefectCS1_atxt{$DefectIndx_L})
															$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS1 Language mismatch"+Char:C90(9)
														End if 
														If ($ElemCS2_txt#$DefectCS2_atxt{$DefectIndx_L})
															$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS2 Language mismatch"+Char:C90(9)
														End if 
														If ($ElemCS3_txt#$DefectCS3_atxt{$DefectIndx_L})
															$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS3 Language mismatch"+Char:C90(9)
														End if 
														If ($ElemCS4_txt#$DefectCS4_atxt{$DefectIndx_L})
															$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS4 Language mismatch"+Char:C90(9)
														End if 
														If ($DefectLangCheck_txt="")
															//found match
															$CurrDefectNo_L:=$DefectNos_aL{$DefectIndx_L}
															ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"match to "+String:C10($DefectNos_aL{$DefectIndx_L})+Char:C90(13))
														Else 
															//no match try again
															ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"compare to "+String:C10($DefectNos_aL{$DefectIndx_L})+Char:C90(9)+$DefectLangCheck_txt+Char:C90(13))
															$DefectIndx_L:=Find in array:C230($DefectNames_atxt; $ElemName_txt; ($DefectIndx_L+1))
															$DefectLangCheck_txt:=""
														End if 
														
													Until (($CurrDefectNo_L>0) | ($DefectIndx_L<=0))
													
												End if 
												
												
												If ($CurrDefectNo_L=0)
													//did not find a good match from existing defects
													
													$maxDefectKey_L:=$maxDefectKey_L+1
													$CurrDefectNo_L:=$maxDefectKey_L
													//add to known list of defects
													APPEND TO ARRAY:C911($DefectNames_atxt; $ElemName_txt)
													APPEND TO ARRAY:C911($DefectNos_aL; $CurrDefectNo_L)
													APPEND TO ARRAY:C911($DefectCS1_atxt; $ElemCS1_txt)
													APPEND TO ARRAY:C911($DefectCS2_atxt; $ElemCS2_txt)
													APPEND TO ARRAY:C911($DefectCS3_atxt; $ElemCS3_txt)
													APPEND TO ARRAY:C911($DefectCS4_atxt; $ElemCS4_txt)
													QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$CurrDefectNo_L)
													If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
														ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Creating Defect "+$ElemName_txt+Char:C90(Tab:K15:37)+"For Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"replaced with new ID "+String:C10($CurrDefectNo_L)+Char:C90(13))
														If ($saveDataToDB_b)
															CREATE RECORD:C68([NTI_ELEM_DEFS:182])
															
															[NTI_ELEM_DEFS:182]ELEM_KEY:4:=$CurrDefectNo_L
															[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="Y"
															[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
															[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
															[NTI_ELEM_DEFS:182]NOTES:17:="<CS1>"+$ElemCS1_txt+"</CS1>"
															[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS2>"+$ElemCS2_txt+"</CS2>"
															[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS3>"+$ElemCS3_txt+"</CS3>"
															[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS4>"+$ElemCS4_txt+"</CS4>"
															//[NTI_ELEM_DEFS]SUBSET_KEY:=""
															//[NTI_ELEM_DEFS]TYPE:=""
															[NTI_ELEM_DEFS:182]REPORTED:16:="N"
															[NTI_ELEM_DEFS:182]CREATEDATETIME:2:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
															[NTI_ELEM_DEFS:182]CREATEUSER:3:=Current user:C182
															LogNewRecordChanges(->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0; ""; 1; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4)
															//LogNewRecord (->[NTI_ELEM_DEFS]ELEM_KEY;->[NTI_ELEM_DEFS]ELEM_KEY;->[NTI_ELEM_DEFS]ELEM_KEY;0;"")
															SAVE RECORD:C53([NTI_ELEM_DEFS:182])
															
														End if 
														//
													End if 
													
												Else 
													//matched an existing defect
													ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Matched Defect "+$ElemName_txt+" for Element "+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+" reassigned To Existing Defect ID "+String:C10($CurrDefectNo_L)+Char:C90(Carriage return:K15:38))
													
												End if 
												
												
											Else 
												//all is ok update record if needed
												
												//update  current element data 
												QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$CurrDefectNo_L)
												
												If (Records in selection:C76([NTI_ELEM_DEFS:182])=1)
													
													If (ut_LoadRecordInteractive(->[NTI_ELEM_DEFS:182]))
														ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Trying to Update Notes Exist Defect in DB "+String:C10($CurrDefectNo_L))
														//only thing that updates is the CS notes - in this update we load the CS notes in the NOTES field
														[NTI_ELEM_DEFS:182]NOTES:17:="<CS1>"+$ElemCS1_txt+"</CS1>"
														[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS2>"+$ElemCS2_txt+"</CS2>"
														[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS3>"+$ElemCS3_txt+"</CS3>"
														[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS4>"+$ElemCS4_txt+"</CS4>"
														//check if it is the same as before
														If ([NTI_ELEM_DEFS:182]NOTES:17#Old:C35([NTI_ELEM_DEFS:182]NOTES:17))
															ut_Message(Char:C90(Tab:K15:37)+"Notes updated!")
															[NTI_ELEM_DEFS:182]MODDATETIME:8:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
															
															[NTI_ELEM_DEFS:182]MODUSER:9:=Current user:C182
															PushChange(1; ->[NTI_ELEM_DEFS:182]NOTES:17)
															PushChange(1; ->[NTI_ELEM_DEFS:182]MODDATETIME:8)
															PushChange(1; ->[NTI_ELEM_DEFS:182]MODUSER:9)
															If ($saveDataToDB_b)
																FlushGrpChgs(1; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0)
																SAVE RECORD:C53([NTI_ELEM_DEFS:182])
															End if   //end if savetodb
														Else 
															ut_Message(Char:C90(Tab:K15:37)+"Notes have been updated previously!")
														End if 
														
														ut_Message(Char:C90(Carriage return:K15:38))
													Else 
														ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"ERROR : Could not load to edit Exist Defect in DB "+$ElemName_txt+" "+String:C10($CurrDefectNo_L)+"!"+Char:C90(Carriage return:K15:38))
													End if 
													
												Else 
													//record that should be there not found!!!!
													ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"ERROR : Exist Defect not found in DB "+$ElemName_txt+" "+String:C10($CurrElemNo_L)+Char:C90(Carriage return:K15:38))
												End if 
												
											End if 
											
											//also add it to the arrays of defects if not there
											C_LONGINT:C283($DefectIndx_L)
											$DefectIndx_L:=Find in array:C230($DefectNos_aL; $CurrDefectNo_L)
											If ($DefectIndx_L=0)
												APPEND TO ARRAY:C911($DefectNames_atxt; $ElemName_txt)
												APPEND TO ARRAY:C911($DefectNos_aL; $CurrDefectNo_L)
												APPEND TO ARRAY:C911($DefectCS1_atxt; $ElemCS1_txt)
												APPEND TO ARRAY:C911($DefectCS2_atxt; $ElemCS2_txt)
												APPEND TO ARRAY:C911($DefectCS3_atxt; $ElemCS3_txt)
												APPEND TO ARRAY:C911($DefectCS4_atxt; $ElemCS4_txt)
												
											End if 
											
										Else 
											//defect is new for this element 
											ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"New Defect for "+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+$ElemName_txt+Char:C90(Carriage return:K15:38))
											
										End if 
										If ($CurrDefectNo_L=0)
											//did not find defect num from element defects - search through list of existing ones
											C_LONGINT:C283($DefectIndx_L)
											$DefectIndx_L:=Find in array:C230($DefectNames_atxt; $ElemName_txt)
											C_TEXT:C284($DefectLangCheck_txt)
											$DefectLangCheck_txt:=""
											$CurrDefectNo_L:=0
											If ($DefectIndx_L>0)
												
												Repeat 
													If ($ElemCS1_txt#$DefectCS1_atxt{$DefectIndx_L})
														$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS1 Language mismatch"+Char:C90(9)
													End if 
													If ($ElemCS2_txt#$DefectCS2_atxt{$DefectIndx_L})
														$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS2 Language mismatch"+Char:C90(9)
													End if 
													If ($ElemCS3_txt#$DefectCS3_atxt{$DefectIndx_L})
														$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS3 Language mismatch"+Char:C90(9)
													End if 
													If ($ElemCS4_txt#$DefectCS4_atxt{$DefectIndx_L})
														$DefectLangCheck_txt:=$DefectLangCheck_txt+"CS4 Language mismatch"+Char:C90(9)
													End if 
													If ($DefectLangCheck_txt="")
														//found match
														$CurrDefectNo_L:=$DefectNos_aL{$DefectIndx_L}
														ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"match to "+String:C10($DefectNos_aL{$DefectIndx_L})+Char:C90(13))
													Else 
														//no match try again
														ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"compare to "+String:C10($DefectNos_aL{$DefectIndx_L})+Char:C90(9)+$DefectLangCheck_txt+Char:C90(13))
														$DefectIndx_L:=Find in array:C230($DefectNames_atxt; $ElemName_txt; ($DefectIndx_L+1))
														$DefectLangCheck_txt:=""
													End if 
													
												Until (($CurrDefectNo_L>0) | ($DefectIndx_L<=0))
												
											End if 
											If ($CurrDefectNo_L=0)
												//still no match - new defect
												$maxDefectKey_L:=$maxDefectKey_L+1
												$CurrDefectNo_L:=$maxDefectKey_L
												//add to known list of defects
												APPEND TO ARRAY:C911($DefectNames_atxt; $ElemName_txt)
												APPEND TO ARRAY:C911($DefectNos_aL; $CurrDefectNo_L)
												APPEND TO ARRAY:C911($DefectCS1_atxt; $ElemCS1_txt)
												APPEND TO ARRAY:C911($DefectCS2_atxt; $ElemCS2_txt)
												APPEND TO ARRAY:C911($DefectCS3_atxt; $ElemCS3_txt)
												APPEND TO ARRAY:C911($DefectCS4_atxt; $ElemCS4_txt)
												QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$maxDefectKey_L)
												If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
													ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Creating Defect "+$ElemName_txt+Char:C90(Tab:K15:37)+"For Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"new ID "+String:C10($maxDefectKey_L)+Char:C90(13))
													If ($saveDataToDB_b)
														CREATE RECORD:C68([NTI_ELEM_DEFS:182])
														
														[NTI_ELEM_DEFS:182]ELEM_KEY:4:=$CurrDefectNo_L
														[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="Y"
														[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
														[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
														[NTI_ELEM_DEFS:182]NOTES:17:="<CS1>"+$ElemCS1_txt+"</CS1>"
														[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS2>"+$ElemCS2_txt+"</CS2>"
														[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS3>"+$ElemCS3_txt+"</CS3>"
														[NTI_ELEM_DEFS:182]NOTES:17:=[NTI_ELEM_DEFS:182]NOTES:17+"<CS4>"+$ElemCS4_txt+"</CS4>"
														//[NTI_ELEM_DEFS]SUBSET_KEY:=""
														//[NTI_ELEM_DEFS]TYPE:=""
														[NTI_ELEM_DEFS:182]REPORTED:16:="N"
														[NTI_ELEM_DEFS:182]CREATEDATETIME:2:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
														[NTI_ELEM_DEFS:182]CREATEUSER:3:=Current user:C182
														LogNewRecordChanges(->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0; ""; 1; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4)
														//LogNewRecord (->[NTI_ELEM_DEFS]ELEM_KEY;->[NTI_ELEM_DEFS]ELEM_KEY;->[NTI_ELEM_DEFS]ELEM_KEY;0;"")
														SAVE RECORD:C53([NTI_ELEM_DEFS:182])
														
													End if 
													//
												End if 
											Else 
												ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Matched Defect "+$ElemName_txt+" for Element "+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+" To Existing Defect ID "+String:C10($CurrDefectNo_L)+Char:C90(Carriage return:K15:38))
												
											End if 
											
										End if 
										
										//add the defect to the element defect tree
										$ElemDefTree_txt:=DOM Create XML element:C865($ElemTree_txt; "Defect")
										DOM SET XML ELEMENT VALUE:C868($ElemDefTree_txt; $CurrDefectNo_L)
										DOM SET XML ATTRIBUTE:C866($ElemDefTree_txt; "Name"; $ElemName_txt)
										
										//add the states in the defect language tree - only if it is not there yet.
										C_TEXT:C284($defectRef_txt; $stateRef_txt)
										ARRAY TEXT:C222($DefectRefs_atxt; 0)
										$defectRef_txt:=DOM Find XML element:C864($LangDefectTree_txt; "NTIDEFECTLANG/Defect"; $DefectRefs_atxt)
										C_LONGINT:C283($loop_L; $defectVal_L)
										C_BOOLEAN:C305($DefectExists_b)
										$DefectExists_b:=False:C215
										For ($loop_L; 1; Size of array:C274($DefectRefs_atxt))
											DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop_L}; $defectVal_L)
											If ($CurrDefectNo_L=$defectVal_L)
												$DefectExists_b:=True:C214
												$loop_L:=Size of array:C274($DefectRefs_atxt)+1
											End if 
										End for 
										If (Not:C34($DefectExists_b))
											$ElemLangTree_txt:=DOM Create XML element:C865($LangDefectTree_txt; "Defect")
											DOM SET XML ELEMENT VALUE:C868($ElemLangTree_txt; $CurrDefectNo_L)
											DOM SET XML ATTRIBUTE:C866($ElemLangTree_txt; "Name"; $ElemName_txt)
											$defectState_txt:=DOM Create XML element:C865($ElemLangTree_txt; "State")
											DOM SET XML ATTRIBUTE:C866($defectState_txt; "Language"; $ElemCS1_txt)
											DOM SET XML ELEMENT VALUE:C868($defectState_txt; 1)
											$defectState_txt:=DOM Create XML element:C865($ElemLangTree_txt; "State")
											DOM SET XML ATTRIBUTE:C866($defectState_txt; "Language"; $ElemCS2_txt)
											DOM SET XML ELEMENT VALUE:C868($defectState_txt; 2)
											$defectState_txt:=DOM Create XML element:C865($ElemLangTree_txt; "State")
											DOM SET XML ATTRIBUTE:C866($defectState_txt; "Language"; $ElemCS3_txt)
											DOM SET XML ELEMENT VALUE:C868($defectState_txt; 3)
											$defectState_txt:=DOM Create XML element:C865($ElemLangTree_txt; "State")
											DOM SET XML ATTRIBUTE:C866($defectState_txt; "Language"; $ElemCS4_txt)
											DOM SET XML ELEMENT VALUE:C868($defectState_txt; 4)
											
										End if 
										
									: ($ElementLine_b)
										//save curr elem no
										$CurrElemNo_L:=Num:C11($ElemNo_txt)
										ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Element "+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+$ElemName_txt+Char:C90(Tab:K15:37)+"Category "+$Category_txt+Char:C90(Tab:K15:37)+"TIN only "+$ElemTinOnly_txt+Char:C90(13))
										//create the record
										QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$CurrElemNo_L)
										If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
											ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"New Element"+Char:C90(Tab:K15:37)+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+$ElemName_txt+Char:C90(Tab:K15:37)+\
												$ElemUnits+Char:C90(Tab:K15:37)+$Category_txt+Char:C90(Tab:K15:37)+$ElemSpec_txt+"<Commentary>"+$ElemCommentary_txt+Char:C90(Carriage return:K15:38))
											If ($saveDataToDB_b)
												CREATE RECORD:C68([NTI_ELEM_DEFS:182])
												[NTI_ELEM_DEFS:182]ELEM_KEY:4:=$CurrElemNo_L
												[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
												[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
												[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12:=$ElemUnits
												[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="N"
												//[NTI_ELEM_DEFS]SUBSET_KEY:=""
												[NTI_ELEM_DEFS:182]ELEM_BINONLY:18:="Y"  //no only for 10001
												//[NTI_ELEM_DEFS]TYPE:=""
												[NTI_ELEM_DEFS:182]REPORTED:16:="Y"
												[NTI_ELEM_DEFS:182]CREATEDATETIME:2:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
												[NTI_ELEM_DEFS:182]CREATEUSER:3:=Current user:C182
												[NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19:=$ElemTinOnly_txt  // Now all should be TIN only - no more BIN only
												[NTI_ELEM_DEFS:182]ELEM_CATEGORY:1:=$Category_txt
												
												If ($Category_txt="@Protective System@")
													[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21:="Y"
												Else 
													[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21:="N"
												End if 
												
												[NTI_ELEM_DEFS:182]NOTES:17:=$ElemSpec_txt+"<Commentary>"+$ElemCommentary_txt
												LogNewRecordChanges(->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0; ""; 1; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4)
												SAVE RECORD:C53([NTI_ELEM_DEFS:182])
												ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Created New Element"+Char:C90(Tab:K15:37)+String:C10($CurrElemNo_L)+Char:C90(Carriage return:K15:38))
											End if 
											
											NTI_LoadElementHelp($CurrElemNo_L)  //should clear list of element defects
											
											
										Else 
											//Note any changes
											LOAD RECORD:C52([NTI_ELEM_DEFS:182])
											ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Exist Element"+Char:C90(Tab:K15:37)+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37))
											If ($ElemName_txt#[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5)
												ut_Message($ElemName_txt+" # "+[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5+Char:C90(Tab:K15:37))
											End if 
											If ([NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12#$ElemUnits)
												ut_Message($ElemUnits+" # "+[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12+Char:C90(Tab:K15:37))
											End if 
											If ([NTI_ELEM_DEFS:182]ELEM_CATEGORY:1#$Category_txt)
												ut_Message($Category_txt+" # "+[NTI_ELEM_DEFS:182]ELEM_CATEGORY:1+Char:C90(Tab:K15:37))
											End if 
											//If ([NTI_ELEM_DEFS]NOTES#($ElemSpec_txt+"<Commentary>"+$ElemCommentary_txt))
											//ut_Message ($ElemSpec_txt+"<Commentary>"+$ElemCommentary_txt+" # "+[NTI_ELEM_DEFS]NOTES+Char(Tab))
											//End if 
											ut_Message(Char:C90(Carriage return:K15:38))
											
											If ($saveDataToDB_b)
												If (ut_LoadRecord(->[NTI_ELEM_DEFS:182]))
													ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"Updated Exist Element"+Char:C90(Tab:K15:37)+String:C10($CurrElemNo_L)+Char:C90(Carriage return:K15:38))
													If ($saveDataToDB_b)
														InitChangeStack(1)
														
														If ($ElemName_txt#[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5)
															[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
															PushChange(1; ->[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5)
														End if 
														
														If ($ElemName_txt#[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11)
															[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
															PushChange(1; ->[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11)
														End if 
														
														If ([NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12#$ElemUnits)
															[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12:=$ElemUnits
															PushChange(1; ->[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12)
														End if 
														
														If ([NTI_ELEM_DEFS:182]ELEM_CATEGORY:1#$Category_txt)
															[NTI_ELEM_DEFS:182]ELEM_CATEGORY:1:=$Category_txt
															PushChange(1; ->[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12)
														End if 
														
														
														If (Modified record:C314([NTI_ELEM_DEFS:182]))
															[NTI_ELEM_DEFS:182]MODDATETIME:8:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
															[NTI_ELEM_DEFS:182]MODUSER:9:=Current user:C182
															FlushGrpChgs(1; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0)
														End if 
														//not updating Notes
														//[NTI_ELEM_DEFS]NOTES:=$ElemSpec_txt+"<Commentary>"+$ElemCommentary_txt
														SAVE RECORD:C53([NTI_ELEM_DEFS:182])
														
													End if 
													
												Else 
													ut_Message(String:C10($NumRows_L)+Char:C90(Tab:K15:37)+"***** Could not load record for element "+String:C10($CurrElemNo_L)+Char:C90(Tab:K15:37)+"To update category"+Char:C90(13))
												End if 
											End if 
											//load existing defects for element and their data - loads arrays PON_HLP_Defects...
											//NTI_FindAllowedDefects ($CurrElemNo_L;->$CurrElemDefects_aL)
											NTI_LoadElementHelp($CurrElemNo_L)
											
										End if 
										//start a new node in the elemdefectree
										$ElemTree_txt:=DOM Create XML element:C865($ElemDefectTree_txt; "Element")
										DOM SET XML ELEMENT VALUE:C868($ElemTree_txt; Num:C11($ElemNo_txt))
										DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "Category"; $Category_txt)
										DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "Name"; $ElemName_txt)
										DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "Unit"; $ElemUnits)
										DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "Reported"; "Y")
										DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "BINOnly"; "Y")
										DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "TINOnly"; $ElemTinOnly_txt)
										DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "SubsetKey"; 0)
										
										If ($Category_txt="@Protective Systems@")
											DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "ProtectiveSystem"; "Y")  //assume it will be reported
										Else 
											DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "ProtectiveSystem"; "N")  //assume it will be reported
											
										End if 
										
									: ($CategoryLine_b)
										
										$Category_txt:=$ElemNo_txt
										
										//clear the curr elem no
										$CurrElemNo_L:=0
								End case 
								
							: ($SaxEvent_L=XML start element:K45:10)
								SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
								If ($elname_txt="Cell")
									C_LONGINT:C283($indxattr_L; $mergeIndex_L; $megeCount_L)
									$indxattr_L:=Find in array:C230($elAttrNames_atxt; "@index")
									If ($indxattr_L>0)
										$Col_L:=$Col_L+1
										$col_L:=Num:C11($elAttrVals_atxt{$indxattr_L})
									Else 
										$Col_L:=$Col_L+1
									End if 
									$megeCount_L:=0
									$mergeIndex_L:=Find in array:C230($elAttrNames_atxt; "@MergeAcross")
									If ($mergeIndex_L>0)
										$megeCount_L:=Num:C11($elAttrVals_atxt{$mergeIndex_L})
									End if 
									//check if the cell data merges down
									C_LONGINT:C283($mergedownAttr_L; $LastMergeRow_L)
									$mergedownAttr_L:=Find in array:C230($elAttrNames_atxt; "@MergeDown")
									C_LONGINT:C283($saveMergevaluetoIndx_L)
									$saveMergevaluetoIndx_L:=0
									If ($mergedownAttr_L>0)
										$LastMergeRow_L:=$NumRows_L+Num:C11($elAttrVals_atxt{$mergedownAttr_L})
										C_LONGINT:C283($colposIndx_L)
										$colposIndx_L:=Find in array:C230($mergedownCols_aL; $Col_L)
										
										If ($colposIndx_L>0)
											$mergedownStartRow_aL{$colposIndx_L}:=$NumRows_L
											$mergedownEndRow_aL{$colposIndx_L}:=$LastMergeRow_L
											$mergeDownValue_atxt{$colposIndx_L}:=""  // will fill it later
											$saveMergevaluetoIndx_L:=$colposIndx_L
										Else 
											APPEND TO ARRAY:C911($mergedownCols_aL; $Col_L)
											APPEND TO ARRAY:C911($mergedownStartRow_aL; $NumRows_L)
											APPEND TO ARRAY:C911($mergedownEndRow_aL; $LastMergeRow_L)
											APPEND TO ARRAY:C911($mergeDownValue_atxt; "")  // will fill it later
											$saveMergevaluetoIndx_L:=Size of array:C274($mergedownCols_aL)
										End if 
										
									End if 
									
									If (($Col_L=1) & ($megeCount_L=7))
										$CategoryLine_b:=True:C214
									End if 
									C_BOOLEAN:C305($CellEnd_b)
									$CellEnd_b:=False:C215
									
									Repeat 
										$SaxEvent_L:=SAX Get XML node:C860($doc_t)
										Case of 
											: ($SaxEvent_L=XML start element:K45:10)
												SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
												
											: ($SaxEvent_L=XML DATA:K45:12)
												SAX GET XML ELEMENT VALUE:C877($doc_t; $elmVal_txt)
												If (($elname_txt="Data") | ($elname_txt="Cell"))
													//process the data for the cell
													//check if we need to save the value 'cause this cell has mergedown attr
													If ($saveMergevaluetoIndx_L>0)
														$mergeDownValue_atxt{$saveMergevaluetoIndx_L}:=$elmVal_txt
														$saveMergevaluetoIndx_L:=0  //clear it so it does not happen again
													End if 
													//check if we are in a merged cell
													C_LONGINT:C283($mergecellindx_L)
													$mergecellindx_L:=Find in array:C230($mergedownCols_aL; $Col_L)
													If ($mergecellindx_L>0)  // this will also be true for the cell with the mergedown attr
														//check if our row is AFTER the first row and not past the last row
														If ($NumRows_L>$mergedownstartRow_aL{$mergecellindx_L}) & ($NumRows_L<=$mergedownEndRow_aL{$mergecellindx_L})
															//use the merge value from before  
															$elmVal_txt:=$mergeDownValue_atxt{$mergecellindx_L}
														End if 
													End if 
													Case of 
														: ($Col_L=1)
															$ElemNo_txt:=$elmVal_txt
														: ($Col_L=2)
															$ElemName_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
															C_LONGINT:C283($StyleIndx_L)
															$StyleIndx_L:=Find in array:C230($elAttrNames_atxt; "@StyleID")
															If ($StyleIndx_L>0)
																If ($elAttrVals_atxt{$StyleIndx_L}="s108")
																	$ElemTinOnly_txt:="Y"
																End if 
															End if 
														: ($Col_L=3)
															$ElemUnits:=$elmVal_txt
														: ($Col_L=9)
															//$ElemTinOnly_txt:=$elmVal_txt
															//: ($Col_L=10)
															//  //$ElemRollUp_txt:=$elmVal_txt
														: ($Col_L=10)
															$ElemSpec_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
														: ($Col_L=10)
															$ElemCommentary_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
														: ($Col_L=11)
															$ElemCS1_txt:=Replace string:C233($elmVal_txt; "\r\n"; " ")
															$ElemCS1_txt:=Replace string:C233($ElemCS1_txt; "\n"; " ")
															$ElemCS1_txt:=Replace string:C233($ElemCS1_txt; "\r"; " ")
														: ($Col_L=12)
															$ElemCS2_txt:=Replace string:C233($elmVal_txt; "\r\n"; " ")
															$ElemCS2_txt:=Replace string:C233($ElemCS2_txt; "\n"; " ")
															$ElemCS2_txt:=Replace string:C233($ElemCS2_txt; "\r"; " ")
														: ($Col_L=13)
															$ElemCS3_txt:=Replace string:C233($elmVal_txt; "\r\n"; " ")
															$ElemCS3_txt:=Replace string:C233($ElemCS3_txt; "\n"; " ")
															$ElemCS3_txt:=Replace string:C233($ElemCS3_txt; "\r"; " ")
														: ($Col_L=14)
															$ElemCS4_txt:=Replace string:C233($elmVal_txt; "\r\n"; " ")
															$ElemCS4_txt:=Replace string:C233($ElemCS4_txt; "\n"; " ")
															$ElemCS4_txt:=Replace string:C233($ElemCS4_txt; "\r"; " ")
															
													End case 
													
												End if 
												
											: ($SaxEvent_L=XML end element:K45:11)
												SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
												If ($elname_txt="Cell")
													$CellEnd_b:=True:C214
												End if 
										End case 
										
									Until ($CellEnd_b)
									
								End if 
								
						End case 
					Until ($rowEnd_b)
					
				End if 
				
			: ($SaxEvent_L=XML end element:K45:11)
				
				SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
				If ($elname_txt="Worksheet")
					If ($inTable1Sheet_b)
						$inTable1Sheet_b:=False:C215
					End if 
					
				End if 
				
			: ($SaxEvent_L=XML comment:K45:8)
				
			: ($SaxEvent_L=XML CDATA:K45:13)
				
			: ($SaxEvent_L=XML DATA:K45:12)
				SAX GET XML ELEMENT VALUE:C877($doc_t; $entVal_txt)
				
			: ($SaxEvent_L=XML entity:K45:14)
				SAX GET XML ENTITY:C879($doc_t; $entName_txt; $entVal_txt)
				
		End case 
	Until ($SaxEvent_L=XML end document:K45:15)
	
	DOM CLOSE XML:C722(NTI_DEFECT_ELEM_TREE)
	DOM CLOSE XML:C722(NTI_DEFECT_LANG_TREE)
	
	ut_CloseMessage
	
	//export the new ones
	NTI_Export_Elem_Defects($ElemDefectTree_txt; $LangDefectTree_txt)
	
	C_TEXT:C284($exportFolder_txt)
	If (True:C214)
		$exportFolder_txt:=Select folder:C670("Choose Folder for the XML files"; 12)
	Else 
		$exportFolder_txt:=Get 4D folder:C485(Current resources folder:K5:16)
		$exportFolder_txt:=$exportFolder_txt+"TIN"+<>PL_DirectorySep_s
	End if 
	
	If ($exportFolder_txt#"")
		C_TIME:C306($doc_time)
		If (Test path name:C476($exportFolder_txt+"Element_DefectTree.xml")=Is a document:K24:1)
		Else 
			$doc_time:=Create document:C266($exportFolder_txt+"Element_DefectTree.xml")
			CLOSE DOCUMENT:C267($doc_time)
		End if 
		If (Test path name:C476($exportFolder_txt+"Defect_Language.xml")=Is a document:K24:1)
		Else 
			$doc_time:=Create document:C266($exportFolder_txt+"Defect_Language.xml")
			CLOSE DOCUMENT:C267($doc_time)
		End if 
		
		
		DOM EXPORT TO FILE:C862($ElemDefectTree_txt; $exportFolder_txt+"Element_DefectTree.xml")
		DOM CLOSE XML:C722($ElemDefectTree_txt)
		DOM EXPORT TO FILE:C862($LangDefectTree_txt; $exportFolder_txt+"Defect_Language.xml")
		DOM CLOSE XML:C722($LangDefectTree_txt)
		
		
	End if 
	
	CLOSE DOCUMENT:C267($doc_t)
	ALERT:C41("Done Parsing !!!")
	
End if 

//now make sure all elements are TIN only

QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]DEFECTFLAG:10#"Y"; *)
QUERY:C277([NTI_ELEM_DEFS:182];  & ; [NTI_ELEM_DEFS:182]ELEM_BINONLY:18="Y")

FIRST RECORD:C50([NTI_ELEM_DEFS:182])
While (Not:C34(End selection:C36([NTI_ELEM_DEFS:182])))
	[NTI_ELEM_DEFS:182]ELEM_BINONLY:18:="N"
	LogChanges(->[NTI_ELEM_DEFS:182]ELEM_BINONLY:18; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0)
	SAVE RECORD:C53([NTI_ELEM_DEFS:182])
	NEXT RECORD:C51([NTI_ELEM_DEFS:182])
End while 

//End NTI_ut_UpdateDEFS