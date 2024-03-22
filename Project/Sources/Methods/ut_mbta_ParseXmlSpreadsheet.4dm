//%attributes = {"invisible":true}
//Method: ut_mbta_ParseXmlSpreadsheet
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/24/13, 09:43:21
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
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
ARRAY TEXT:C222($elAttrNames_atxt; 0)
ARRAY TEXT:C222($elAttrVals_atxt; 0)

$doc_t:=Open document:C264(""; ""; Read mode:K24:5)
C_LONGINT:C283($SaxEvent_L; $NumRows_L)
If (OK=1)
	
	$NumRows_L:=0
	ut_StartMessage(3; "ReadingXML"; 800; 400)
	Repeat 
		$SaxEvent_L:=SAX Get XML node:C860($doc_t)
		
		Case of 
			: ($SaxEvent_L=XML start document:K45:7)
				SAX GET XML DOCUMENT VALUES:C873($doc_t; $docEnc_txt; $DocVer_txt; $stand_b)
				
			: ($SaxEvent_L=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
				If ($elname_txt="Row")
					$NumRows_L:=$NumRows_L+1
					$rowEnd_b:=False:C215
					$Col_L:=0
					$BIN_s:=""
					$Line_s:=""
					$yrBlt_L:=0
					$yrRecon:=0
					$brgType_txt:=""
					$Carry_s:=""
					$i58_txt:=""
					$i59_txt:=""
					$i60_txt:=""
					$i64_txt:=""
					$i66_txt:=""
					$brgType_txt:=""
					$Ra1_txt:=""
					$Ra2_txt:=""
					$Ra3_txt:=""
					$Rb1_txt:=""
					$Rb2_txt:=""
					$Rb3_txt:=""
					$Rc1_txt:=""
					$Rc2_txt:=""
					$Rc3_txt:=""
					$BrgNo_txt:=""
					Repeat 
						$SaxEvent_L:=SAX Get XML node:C860($doc_t)
						C_LONGINT:C283($Col_L)
						Case of 
							: ($SaxEvent_L=XML end element:K45:11)
								SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
								
								If ($elname_txt="row")
									$rowEnd_b:=True:C214
									
									If (($BIN_s#"") & ($brgType_txt#""))
										ut_Message("Row "+String:C10($NumRows_L))
										ut_Message(Char:C90(13))
										$BrgNo_txt:=Replace string:C233($BrgNo_txt; "-"; "")
										$BrgNo_txt:=Replace string:C233($BrgNo_txt; " "; "")
										$BIN_s:=Replace string:C233($BIN_s; " "; "")
										$BIN_s:=Substring:C12($BIN_s; 1; 3)
										READ ONLY:C145([Bridge MHD NBIS:1])
										QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_s)
										$BINErrmsg_txt:=""
										$BDEPTErr_txt:=""
										$CategoryErr_txt:=""
										Case of 
											: (Records in selection:C76([Bridge MHD NBIS:1])#1)
												$BINErrmsg_txt:=" [!!!BIN NOT FOUND!!!!]"
											Else 
												If ([Bridge MHD NBIS:1]BDEPT:1#$BrgNo_txt)
													$BDEPTErr_txt:=" [!!!BDEPT Mismatch !!! "+$BIN_s+" ("+$Carry_s+") ->"+[Bridge MHD NBIS:1]BDEPT:1+" "+[Bridge MHD NBIS:1]Item8:206+" ["+[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63+"] "
													QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$BrgNo_txt)
													$BDEPTErr_txt:=$BDEPTErr_txt+" - "+$BrgNo_txt+"->"+[Bridge MHD NBIS:1]BIN:3+" "+[Bridge MHD NBIS:1]Item8:206+" ["+[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63+"] "+" !!!]"
												Else 
													Case of 
														: ($brgType_txt="Highway@")
															If (mbta_ReturnBridgeType#"Highway@")
																$CategoryErr_txt:=" [!!!Category mismatch "+[Bridge MHD NBIS:1]Item8 BridgeCat:207+" !!!]"
															End if 
														: ($brgType_txt="Transit@")
															If (mbta_ReturnBridgeType#"Transit@")
																$CategoryErr_txt:=" [!!!Category mismatch "+[Bridge MHD NBIS:1]Item8 BridgeCat:207+" !!!]"
															End if 
														: ($brgType_txt="Commuter@")
															If (mbta_ReturnBridgeType#"Commuter@")
																$CategoryErr_txt:=" [!!!Category mismatch "+[Bridge MHD NBIS:1]Item8 BridgeCat:207+" !!!]"
															End if 
														: ($brgType_txt="Ped@")
															If (mbta_ReturnBridgeType#"Ped@")
																$CategoryErr_txt:=" [!!!Category mismatch "+[Bridge MHD NBIS:1]Item8 BridgeCat:207+" !!!]"
															End if 
															
													End case 
													
												End if 
												
										End case 
										
										ut_Message($brgType_txt+$CategoryErr_txt+Char:C90(Tab:K15:37)+$BIN_s+$BINErrmsg_txt+Char:C90(Tab:K15:37)+$BrgNo_txt+$BDEPTErr_txt+Char:C90(Tab:K15:37)+$Line_s+Char:C90(Tab:K15:37)+String:C10($I90_d)+Char:C90(Tab:K15:37)+String:C10($Rtg_d)+Char:C90(Tab:K15:37)+String:C10($yrBlt_L)+Char:C90(Tab:K15:37)+String:C10($yrRecon))
										ut_Message(Char:C90(Tab:K15:37)+$i58_txt+Char:C90(Tab:K15:37)+$i59_txt+Char:C90(Tab:K15:37)+$i60_txt+Char:C90(Tab:K15:37))
										
										Case of 
											: ($brgType_txt="Highway@")
												$i64_txt:=$Ra1_txt
												$i66_txt:=$Ra2_txt
												ut_Message($i64_txt+Char:C90(Tab:K15:37)+$i66_txt)
											: ($brgType_txt="Transit@")
												ut_Message($ra1_txt+Char:C90(Tab:K15:37)+$ra2_txt+Char:C90(Tab:K15:37)+$rb3_txt+Char:C90(Tab:K15:37)+$rb1_txt+Char:C90(Tab:K15:37)+$rb2_txt+Char:C90(Tab:K15:37)+$rb3_txt)
											: ($brgType_txt="Commuter@")
												ut_Message($ra1_txt+Char:C90(Tab:K15:37)+$ra2_txt+Char:C90(Tab:K15:37)+$rb3_txt+Char:C90(Tab:K15:37)+$rb1_txt+Char:C90(Tab:K15:37)+$rb2_txt+Char:C90(Tab:K15:37)+$rb3_txt+Char:C90(Tab:K15:37)+$rc1_txt+Char:C90(Tab:K15:37)+$rc2_txt+Char:C90(Tab:K15:37)+$rc3_txt)
										End case 
										
									End if 
									
									ut_Message(Char:C90(13))
								End if 
							: ($SaxEvent_L=XML start element:K45:10)
								SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
								If ($elname_txt="Cell")
									C_LONGINT:C283($indxattr_L)
									$indxattr_L:=Find in array:C230($elAttrNames_atxt; "@index")
									If ($indxattr_L>0)
										$Col_L:=$Col_L+1
										$col_L:=Num:C11($elAttrVals_atxt{$indxattr_L})
									Else 
										$Col_L:=$Col_L+1
									End if 
									
									Repeat 
										$SaxEvent_L:=SAX Get XML node:C860($doc_t)
										
										If ($SaxEvent_L=XML DATA:K45:12)
											SAX GET XML ELEMENT VALUE:C877($doc_t; $elmVal_txt)
											Case of 
												: ($Col_L=1)
													$brgType_txt:=$elmVal_txt
												: ($Col_L=2)
													$BrgNo_txt:=$elmVal_txt
												: ($Col_L=6)
													$BIN_s:=$elmVal_txt
												: ($Col_L=5)
													$Line_s:=$elmVal_txt
												: ($Col_L=4)
													$Carry_s:=$elmVal_txt
												: ($Col_L=7)
													$I90_d:=Date:C102(Substring:C12($elmVal_txt; 6; 2)+"/"+Substring:C12($elmVal_txt; 9; 2)+"/"+Substring:C12($elmVal_txt; 1; 4))
												: ($Col_L=9)
													$Rtg_d:=Date:C102(Substring:C12($elmVal_txt; 6; 2)+"/"+Substring:C12($elmVal_txt; 9; 2)+"/"+Substring:C12($elmVal_txt; 1; 4))
												: ($Col_L=11)
													$yrBlt_recon:=($elmVal_txt)
													ARRAY TEXT:C222($years_atxt; 0)
													ut_TextToArray($yrBlt_recon; ->$years_atxt; "/")
													$yrBlt_L:=Num:C11($years_atxt{1})
													If (Size of array:C274($years_atxt)>1)
														$yrRecon:=Num:C11($years_atxt{Size of array:C274($years_atxt)})
													End if 
												: ($Col_L=15)
													$i58_txt:=$elmVal_txt
												: ($Col_L=16)
													$i59_txt:=$elmVal_txt
												: ($Col_L=17)
													$i60_txt:=$elmVal_txt
												: ($Col_L=18)
													$Ra1_txt:=$elmVal_txt
												: ($Col_L=19)
													$Ra2_txt:=$elmVal_txt
												: ($Col_L=20)
													$ra3_txt:=$elmVal_txt
												: ($Col_L=21)
													$Rb1_txt:=$elmVal_txt
												: ($Col_L=22)
													$Rb2_txt:=$elmVal_txt
												: ($Col_L=23)
													$Rb3_txt:=$elmVal_txt
												: ($Col_L=24)
													$RC1_txt:=$elmVal_txt
												: ($Col_L=25)
													$RC2_txt:=$elmVal_txt
												: ($Col_L=26)
													$RC3_txt:=$elmVal_txt
											End case 
											
											//ut_Message (Char(Tab )+"Cell "+String($Col_L)+" <"+$elmVal_txt+"> ")
										End if 
										
									Until ($SaxEvent_L=XML end element:K45:11)
									
								End if 
								
						End case 
					Until ($rowEnd_b)
					
				End if 
				
			: ($SaxEvent_L=XML end element:K45:11)
				
				SAX GET XML ELEMENT:C876($doc_t; $elname_txt; $elPrefix_txt; $elAttrNames_atxt; $elAttrVals_atxt)
				
			: ($SaxEvent_L=XML comment:K45:8)
				
			: ($SaxEvent_L=XML CDATA:K45:13)
				
			: ($SaxEvent_L=XML DATA:K45:12)
				SAX GET XML ELEMENT VALUE:C877($doc_t; $entVal_txt)
				
			: ($SaxEvent_L=XML entity:K45:14)
				SAX GET XML ENTITY:C879($doc_t; $entName_txt; $entVal_txt)
		End case 
		
	Until ($SaxEvent_L=XML end document:K45:15)
	ut_CloseMessage
	CLOSE DOCUMENT:C267($doc_t)
	ALERT:C41("Done Parsing !!!")
End if 

//End ut_mbta_ParseXmlSpreadsheet