//%attributes = {"invisible":true}
//Method: NTI_ut_LoadDEFS
//Description
//load definitions for NTI elements from a spreadsheet saved in xml format supplied by
//J Rigney.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/03/16, 18:31:28
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
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

$LastElemCS4_txt:=""

$doc_t:=Open document:C264(""; ""; Read mode:K24:5)
C_LONGINT:C283($SaxEvent_L; $NumRows_L; $CurrDefectNo_L; $CurrElemNo_L; $DefectNo_L)
C_BOOLEAN:C305($inTable1Sheet_b)
C_TEXT:C284($LangDefectTree_txt; $ElemDefectTree_txt; $ElemTree_txt; $ElemDefTree_txt; $defectState_txt; $ElemLangTree_txt)
If (OK=1)
	$inTable1Sheet_b:=False:C215
	$NumRows_L:=0
	C_TEXT:C284($LangDefectTree_txt; $ElemDefectTree_txt; $RowTree_txt)
	$LangDefectTree_txt:=DOM Create XML Ref:C861("NTIDEFECTLANG")
	$ElemDefectTree_txt:=DOM Create XML Ref:C861("NTI_ELEMDEFECTS")
	$DefectNo_L:=1001
	$CurrElemNo_L:=0
	ut_StartMessage(3; "ReadingNTIXML"; 800; 400)
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
						$inTable1Sheet_b:=($elAttrVals_atxt{$sheetName_L}="Table 1")
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
					$ElemTinOnly_txt:=""  //9
					$ElemRollUp_txt:=""  //10
					$ElemSpec_txt:=""  //11
					$ElemCommentary_txt:=""  //12
					$ElemCS1_txt:=""  //13
					$ElemCS2_txt:=""  //14
					$ElemCS3_txt:=""  //15
					$ElemCS4_txt:=""  //16
					$CurrDefectNo_L:=0
					Repeat 
						$SaxEvent_L:=SAX Get XML node:C860($doc_t)
						C_LONGINT:C283($Col_L)
						Case of 
							: ($SaxEvent_L=XML end element:K45:11)
								SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
								
								If ($elname_txt="row")
									$rowEnd_b:=True:C214
									
									Case of 
										: (($ElemNo_txt="") & ($CurrElemNo_L>0) & ($ElemName_txt#""))
											$DefectLine_b:=True:C214
										: (bIsNumeric($ElemNo_txt))
											$ElementLine_b:=True:C214
									End case 
									//now process the data
									
									Case of 
										: ($DefectLine_b)
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
														ut_Message("Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"match to "+String:C10($DefectNos_aL{$DefectIndx_L})+Char:C90(13))
													Else 
														//no match try again
														ut_Message("Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"compare to "+String:C10($DefectNos_aL{$DefectIndx_L})+Char:C90(9)+$DefectLangCheck_txt+Char:C90(13))
														$DefectIndx_L:=Find in array:C230($DefectNames_atxt; $ElemName_txt; ($DefectIndx_L+1))
														$DefectLangCheck_txt:=""
													End if 
													
												Until (($CurrDefectNo_L>0) | ($DefectIndx_L<=0))
												
											End if 
											If ($CurrDefectNo_L=0)
												APPEND TO ARRAY:C911($DefectNames_atxt; $ElemName_txt)
												APPEND TO ARRAY:C911($DefectNos_aL; $DefectNo_L)
												APPEND TO ARRAY:C911($DefectCS1_atxt; $ElemCS1_txt)
												APPEND TO ARRAY:C911($DefectCS2_atxt; $ElemCS2_txt)
												APPEND TO ARRAY:C911($DefectCS3_atxt; $ElemCS3_txt)
												APPEND TO ARRAY:C911($DefectCS4_atxt; $ElemCS4_txt)
												$CurrDefectNo_L:=$DefectNo_L
												ut_Message("Defect "+$ElemName_txt+Char:C90(9)+"Element "+String:C10($CurrElemNo_L)+Char:C90(9)+"new ID "+String:C10($CurrDefectNo_L)+Char:C90(13))
												QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$CurrDefectNo_L)
												If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
													CREATE RECORD:C68([NTI_ELEM_DEFS:182])
													
													[NTI_ELEM_DEFS:182]ELEM_KEY:4:=$CurrDefectNo_L
													[NTI_ELEM_DEFS:182]DEFECTFLAG:10:="Y"
													[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5:=$ElemName_txt
													[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11:=$ElemName_txt
													//[NTI_ELEM_DEFS]SUBSET_KEY:=""
													//[NTI_ELEM_DEFS]TYPE:=""
													[NTI_ELEM_DEFS:182]REPORTED:16:="N"
													[NTI_ELEM_DEFS:182]CREATEDATETIME:2:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
													[NTI_ELEM_DEFS:182]CREATEUSER:3:=Current user:C182
													
													SAVE RECORD:C53([NTI_ELEM_DEFS:182])
													//
												End if 
												$DefectNo_L:=$DefectNo_L+1
												
											End if 
											
											If ($ElemCS4_txt="")
												//use the last saved cs4
												$ElemCS4_txt:=$LastElemCS4_txt
											Else 
												$LastElemCS4_txt:=$ElemCS4_txt
											End if 
											
											//add the defect to the element defect tree
											$ElemDefTree_txt:=DOM Create XML element:C865($ElemTree_txt; "Defect")
											DOM SET XML ELEMENT VALUE:C868($ElemDefTree_txt; $CurrDefectNo_L)
											
											//add the states in the defect language tree
											$ElemLangTree_txt:=DOM Create XML element:C865($LangDefectTree_txt; "Defect")
											DOM SET XML ELEMENT VALUE:C868($ElemLangTree_txt; $CurrDefectNo_L)
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
											
										: ($ElementLine_b)
											//save curr elem no
											$CurrElemNo_L:=Num:C11($ElemNo_txt)
											ut_Message("Element "+String:C10($CurrElemNo_L)+Char:C90(9)+$ElemName_txt+Char:C90(9)+"Category "+$Category_txt+Char:C90(9)+"TIN only "+$ElemTinOnly_txt+Char:C90(13))
											//create the record
											QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$CurrElemNo_L)
											If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
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
												[NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19:=$ElemTinOnly_txt
												[NTI_ELEM_DEFS:182]ELEM_CATEGORY:1:=$Category_txt
												[NTI_ELEM_DEFS:182]NOTES:17:=$ElemSpec_txt+"<Commentary>"+$ElemCommentary_txt
												SAVE RECORD:C53([NTI_ELEM_DEFS:182])
												
											Else 
												If (ut_LoadRecord(->[NTI_ELEM_DEFS:182]))
													[NTI_ELEM_DEFS:182]NOTES:17:=$ElemSpec_txt+"<Commentary>"+$ElemCommentary_txt
													SAVE RECORD:C53([NTI_ELEM_DEFS:182])
												Else 
													ut_Message("***** Could not load record for element "+String:C10($CurrElemNo_L)+Char:C90(9)+"To update notes"+Char:C90(13))
												End if 
												
											End if 
											//start a new node in the elemdefectree
											$ElemTree_txt:=DOM Create XML element:C865($ElemDefectTree_txt; "Element")
											DOM SET XML ELEMENT VALUE:C868($ElemTree_txt; Num:C11($ElemNo_txt))
											DOM SET XML ATTRIBUTE:C866($ElemTree_txt; "Category"; $Category_txt)
											
										: ($CategoryLine_b)
											$Category_txt:=$ElemNo_txt
											//clear the curr elem no
											$CurrElemNo_L:=0
									End case 
									
									
								End if 
								
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
									If (($Col_L=1) & ($megeCount_L=7))
										$CategoryLine_b:=True:C214
									End if 
									
									Repeat 
										$SaxEvent_L:=SAX Get XML node:C860($doc_t)
										
										If ($SaxEvent_L=XML DATA:K45:12)
											SAX GET XML ELEMENT VALUE:C877($doc_t; $elmVal_txt)
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
												: ($Col_L=10)
													//$ElemRollUp_txt:=$elmVal_txt
												: ($Col_L=10)
													$ElemSpec_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
												: ($Col_L=11)
													$ElemCommentary_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
												: ($Col_L=12)
													$ElemCS1_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
												: ($Col_L=13)
													$ElemCS2_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
												: ($Col_L=14)
													$ElemCS3_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
												: ($Col_L=15)
													$ElemCS4_txt:=Replace string:C233($elmVal_txt; "\r"; " ")
													
											End case 
											
										End if 
										
									Until ($SaxEvent_L=XML end element:K45:11)
									
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
	C_TEXT:C284($exportFolder_txt)
	//$exportFolder_txt:=Select folder("Choose Folder for the XML files")
	$exportFolder_txt:=Get 4D folder:C485(Current resources folder:K5:16)
	//$exportFolder_txt:=$exportFolder_txt+◊PL_DirectorySep_s+"Resources"+◊PL_DirectorySep_s+"TIN"+◊PL_DirectorySep_s
	$exportFolder_txt:=$exportFolder_txt+"TIN"+<>PL_DirectorySep_s
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
	
	ut_CloseMessage
	CLOSE DOCUMENT:C267($doc_t)
	ALERT:C41("Done Parsing !!!")
End if 

//End NTI_ut_LoadDEFS