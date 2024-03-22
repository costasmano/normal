//%attributes = {"invisible":true}
//Method: CleanNBEXML
//Description
// will read the XML file from the NBE export from BrM and replace structure number according to the BIN.
// will save into a new XML file
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:17:02
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_TIME:C306($xmldoc_t)
$xmldoc_t:=Open document:C264(""; "XML"; Read mode:K24:5)
If (OK=1)
	C_TIME:C306($outputDoc_t)
	$outputDoc_t:=Create document:C266(""; "XML")
	If (OK=1)
		READ ONLY:C145([Bridge MHD NBIS:1])
		ARRAY TEXT:C222($brBINs_atxt; 0)
		ARRAY TEXT:C222($brItem8_atxt; 0)
		ARRAY TEXT:C222($brFHWA8_atxt; 0)
		ARRAY BOOLEAN:C223($brNBIrec_ab; 0)
		ALL RECORDS:C47([Bridge MHD NBIS:1])
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $brBINs_atxt; [Bridge MHD NBIS:1]Item8:206; $brItem8_atxt; [Bridge MHD NBIS:1]FHWAItem8:229; $brFHWA8_atxt; [Bridge MHD NBIS:1]FHWARecord:174; $brNBIrec_ab)
		
		C_LONGINT:C283($SAXevt_L; $SaxLevel_element_L)
		C_TEXT:C284($elmtname_txt; $elmPref_txt; $elmtValue_t)
		C_BOOLEAN:C305($importErr_b; $Element_End_b)
		$importErr_b:=False:C215
		ARRAY TEXT:C222($SaxLevels_atxt; 0)
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
									//find if BIN is NBI
									C_BOOLEAN:C305($NBIBIN_b)
									$NBIBIN_b:=False:C215
									C_LONGINT:C283($brIndex_L)
									$brIndex_L:=Find in array:C230($brBINs_atxt; $BIN_txt)
									If ($brIndex_L>0)
										$NBIBIN_b:=$brNBIrec_ab{$brIndex_L}
										If ($NBIBIN_b)
											
											If ($brFHWA8_atxt{$brIndex_L}#"")
												$ElementVaues_atxt{$structnumIndx_L}:=$brFHWA8_atxt{$brIndex_L}
											Else 
												$ElementVaues_atxt{$structnumIndx_L}:=$brItem8_atxt{$brIndex_L}
											End if 
											
											SAX OPEN XML ELEMENT:C853($outputDoc_t; "FHWAED")
											C_LONGINT:C283($loop_L)
											For ($loop_L; 1; Size of array:C274($ElementNames_atxt))
												SAX OPEN XML ELEMENT:C853($outputDoc_t; $ElementNames_atxt{$loop_L})
												SAX ADD XML ELEMENT VALUE:C855($outputDoc_t; $ElementVaues_atxt{$loop_L})
												SAX CLOSE XML ELEMENT:C854($outputDoc_t)
											End for 
											
											SAX CLOSE XML ELEMENT:C854($outputDoc_t)
										End if 
										
									End if 
									
								End if 
								
							End if 
					End case 
					
				: ($SAXevt_L=XML end element:K45:11)
					DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
					
			End case 
		Until (($SAXevt_L=XML end document:K45:15) | $importErr_b)
		
		SAX CLOSE XML ELEMENT:C854($outputDoc_t)
		CLOSE DOCUMENT:C267($outputDoc_t)
	End if 
	
	CLOSE DOCUMENT:C267($xmldoc_t)
End if 

//End CleanNBEXML