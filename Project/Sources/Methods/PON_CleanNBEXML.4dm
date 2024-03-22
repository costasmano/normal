//%attributes = {"invisible":true}
// Method: PON_CleanNBEXML
// Description
//  ` Will read an NBE xml export  file from BrM and will make sure that there are no
//  ` non-NBI records included, also change the StrucNum to FHWAItem8 if needed.
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/04/15, 23:03:01
	// ----------------------------------------------------
	// First Release
	Mods_2015_02
	
End if 
C_TIME:C306($xmldoc_t)
$xmldoc_t:=Open document:C264(""; "XML"; Read mode:K24:5)
If (OK=1)
	C_TIME:C306($outputDoc_t; $errorDoc_t)
	$outputDoc_t:=Create document:C266(""; "XML")
	If (OK=1)
		$errorDoc_t:=Create document:C266(Document+".err"; "txt")
		C_LONGINT:C283($SAXevt_L; $SaxLevel_element_L; $NumElements_L; $NumElementsScanned_L; $NumNOTNBI_L; $BlankStructNum_L; $NoStructNum_L)
		C_TEXT:C284($elmtname_txt; $elmPref_txt; $elmtValue_t)
		C_TIME:C306($start_t; $end_t)
		C_BOOLEAN:C305($importErr_b; $Element_End_b)
		$importErr_b:=False:C215
		ARRAY TEXT:C222($SaxLevels_atxt; 0)
		$NumElements_L:=0
		$NumElementsScanned_L:=0
		$NumNOTNBI_L:=0
		$BlankStructNum_L:=0
		$NoStructNum_L:=0
		$start_t:=Current time:C178(*)
		SHORT_MESSAGE("Scanning file input ... ")
		
		SAX OPEN XML ELEMENT:C853($outputDoc_t; "FHWAElement")
		Repeat 
			$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
			Case of 
				: ($SAXevt_L=XML start element:K45:10)
					
					SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
					APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
					
					Case of 
						: ($elmtname_txt="FHWAED")
							$SaxLevel_element_L:=Size of array:C274($SaxLevels_atxt)
							$Element_End_b:=False:C215
							//start of element
							$NumElementsScanned_L:=$NumElementsScanned_L+1
							If ($NumElementsScanned_L%20=0)
								MESSAGE:C88(String:C10($NumElementsScanned_L)+"..")
							End if 
							
							//read until the end of element - store nodenames and values for later
							ARRAY TEXT:C222($ElementNames_atxt; 0)
							ARRAY TEXT:C222($ElementVaues_atxt; 0)
							C_TEXT:C284($StructNum_txt)
							$StructNum_txt:=""
							Repeat 
								$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
								Case of 
									: ($SAXevt_L=XML start element:K45:10)
										SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
										APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
										APPEND TO ARRAY:C911($ElementNames_atxt; $elmtname_txt)
										APPEND TO ARRAY:C911($ElementVaues_atxt; "")
										
									: ($SAXevt_L=XML DATA:K45:12)
										If ($SaxLevel_element_L=Size of array:C274($SaxLevels_atxt))
										Else 
											SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $ElementVaues_atxt{Size of array:C274($ElementVaues_atxt)})
										End if 
									: ($SAXevt_L=XML end element:K45:11)
										If ($SaxLevel_element_L=Size of array:C274($SaxLevels_atxt))
											$Element_End_b:=True:C214
										End if 
										DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
										
								End case 
							Until ($Element_End_b)
							
							//check if we want to save this element / change structnum
							C_LONGINT:C283($structnumIndx_L)
							$structnumIndx_L:=Find in array:C230($ElementNames_atxt; "STRUCNUM")
							If ($structnumIndx_L>0)
								If ($ElementVaues_atxt{$structnumIndx_L}#"")
									C_TEXT:C284($BIN_txt)
									$BIN_txt:=Substring:C12($ElementVaues_atxt{$structnumIndx_L}; 7; 3)
									//search bridge table for BIN
									QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_txt)
									
									//find if BIN is NBI
									C_BOOLEAN:C305($NBIBIN_b)
									$NBIBIN_b:=[Bridge MHD NBIS:1]FHWARecord:174
									If ($NBIBIN_b)
										//check correct Structnum
										
										If ([Bridge MHD NBIS:1]FHWAItem8:229#"")
											$ElementVaues_atxt{$structnumIndx_L}:=[Bridge MHD NBIS:1]FHWAItem8:229
										Else 
										End if 
										
										SAX OPEN XML ELEMENT:C853($outputDoc_t; "FHWAED")
										C_LONGINT:C283($loop_L)
										For ($loop_L; 1; Size of array:C274($ElementNames_atxt))
											SAX OPEN XML ELEMENT:C853($outputDoc_t; $ElementNames_atxt{$loop_L})
											SAX ADD XML ELEMENT VALUE:C855($outputDoc_t; $ElementVaues_atxt{$loop_L})
											SAX CLOSE XML ELEMENT:C854($outputDoc_t)
										End for 
										
										SAX CLOSE XML ELEMENT:C854($outputDoc_t)
										$NumElements_L:=$NumElements_L+1
									Else 
										SEND PACKET:C103($errorDoc_t; "STRUCNUM ="+$ElementVaues_atxt{$structnumIndx_L}+"  ; BIN ="+$BIN_txt+"  - Not NBI!"+Char:C90(13))
										$NumNOTNBI_L:=$NumNOTNBI_L+1
									End if 
								Else 
									$BlankStructNum_L:=$BlankStructNum_L+1
								End if 
							Else 
								$NoStructNum_L:=$NoStructNum_L+1
							End if 
					End case 
					
				: ($SAXevt_L=XML end element:K45:11)
					DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
					
			End case 
		Until (($SAXevt_L=XML end document:K45:15) | $importErr_b)
		
		SAX CLOSE XML ELEMENT:C854($outputDoc_t)
		CLOSE DOCUMENT:C267($outputDoc_t)
		CLOSE DOCUMENT:C267($errorDoc_t)
		$end_t:=Current time:C178(*)
		
		CLOSE WINDOW:C154
		C_TEXT:C284($msg)
		$msg:="Scanned "+String:C10($NumElementsScanned_L)+"  Wrote "+String:C10($NumElements_L)
		$msg:=$msg+Char:C90(13)+" No StrucNum  attr = "+String:C10($NoStructNum_L)
		$msg:=$msg+Char:C90(13)+" Blank StrucNum = "+String:C10($BlankStructNum_L)
		$msg:=$msg+Char:C90(13)+" Non NBI StrucNum = "+String:C10($NumNOTNBI_L)
		$msg:=$msg+Char:C90(13)+"Duration :"+String:C10($end_t-$start_t)
		ALERT:C41($msg)
	End if 
	
	CLOSE DOCUMENT:C267($xmldoc_t)
End if 
