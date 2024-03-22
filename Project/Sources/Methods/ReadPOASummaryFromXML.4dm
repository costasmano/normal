//%attributes = {"invisible":true}
//Method: ReadPOASummaryFromXML
//Description
// open a spreadsheet saved as XML and read the POA summary data in there.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/17, 11:41:30
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//


C_TIME:C306($xmldoc_t)
$xmldoc_t:=Open document:C264(""; "XML"; Read mode:K24:5)

If (OK=1)
	C_LONGINT:C283($SAXevt_L)
	C_BOOLEAN:C305($importErr_b)
	C_TEXT:C284($elmtname_txt; $elmPref_txt; $StructNum_txt)
	C_TEXT:C284($ChanScourImpl_txt; $ChanScoutAddtlCmts_txt; $ChanScoutIfNotImpl_txt; $ChanScoutCurr_txt; $ChanScoutRecom_txt)
	C_TEXT:C284($UWFeqImpl_txt; $UWFeqAddtlCmts_txt; $UWFeqIfNotImpl_txt; $UWFeqCurr_txt; $UWFeqRecom_txt)
	C_TEXT:C284($FixMonitDevImpl_txt; $FixMonitDevAddtlCmts_txt; $FixMonitDevIfNotImpl_txt; $FixMonitDevCurr_txt; $FixMonitDevRecom_txt)
	C_TEXT:C284($FLoodMonitImpl_txt; $FLoodMonitAddtlCmts_txt; $FLoodMonitIfNotImpl_txt; $FLoodMonitCurr_txt; $FLoodMonitRecom_txt)
	C_TEXT:C284($PostFloodImpl_txt; $PostFloodAddtlCmts_txt; $PostFloodIfNotImpl_txt; $PostFloodCurr_txt; $PostFloodRecom_txt)
	C_TEXT:C284($ChanScourImpl_txt; $ChanScoutAddtlCmts_txt; $ChanScoutIfNotImpl_txt; $ChanScoutCurr_txt; $ChanScoutRecom_txt)
	C_TEXT:C284($UWFeqImpl_txt; $UWFeqAddtlCmts_txt; $UWFeqIfNotImpl_txt; $UWFeqCurr_txt; $UWFeqRecom_txt)
	C_TEXT:C284($FixMonitDevImpl_txt; $FixMonitDevAddtlCmts_txt; $FixMonitDevIfNotImpl_txt; $FixMonitDevCurr_txt; $FixMonitDevRecom_txt)
	C_TEXT:C284($FLoodMonitImpl_txt; $FLoodMonitAddtlCmts_txt; $FLoodMonitIfNotImpl_txt; $FLoodMonitCurr_txt; $FLoodMonitRecom_txt)
	C_TEXT:C284($PostFloodImpl_txt; $PostFloodAddtlCmts_txt; $PostFloodIfNotImpl_txt; $PostFloodCurr_txt; $PostFloodRecom_txt)
	C_TEXT:C284($I113WhenPOA_txt; $I113RecChg_txt; $I113CurrSIA_txt; $I113Expl_txt)
	C_TEXT:C284($I60WhenPOA_txt; $I60RecChg_txt; $I60CurrSIA_txt; $I60Expl_txt)
	C_TEXT:C284($I61WhenPOA_txt; $I61RecChg_txt; $I61CurrSIA_txt; $I61Expl_txt)
	C_TEXT:C284($I71WhenPOA_txt; $I71RecChg_txt; $I71CurrSIA_txt; $I71Expl_txt)
	
	C_BOOLEAN:C305($GotAllData_b)
	$GotAllData_b:=False:C215
	
	ARRAY TEXT:C222($SaxLevels_atxt; 0)
	Repeat 
		$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
		ARRAY TEXT:C222($elmAttrs_atxt; 0)
		ARRAY TEXT:C222($elmtAttrVals_atxt; 0)
		
		Case of 
			: ($SAXevt_L=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
				
				Case of 
					: ($elmtname_txt="Worksheet")
						If ($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "ss:Name")}="Sheet1")
							//find 2nd row cell 7 with structure number
							C_LONGINT:C283($CurrRow_L; $CurrCell_L)
							$CurrRow_L:=0
							$CurrCell_L:=0
							Case of 
								: (Not:C34(getToRowCell($xmldoc_t; 2; 7; ->$CurrRow_L; ->$CurrCell_L; ->$StructNum_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 14; 9; ->$CurrRow_L; ->$CurrCell_L; ->$ChanScourImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 15; 2; ->$CurrRow_L; ->$CurrCell_L; ->$ChanScoutAddtlCmts_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 15; 5; ->$CurrRow_L; ->$CurrCell_L; ->$ChanScoutIfNotImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 17; 3; ->$CurrRow_L; ->$CurrCell_L; ->$ChanScoutCurr_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 17; 4; ->$CurrRow_L; ->$CurrCell_L; ->$ChanScoutRecom_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 19; 9; ->$CurrRow_L; ->$CurrCell_L; ->$UWFeqImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 20; 2; ->$CurrRow_L; ->$CurrCell_L; ->$UWFeqAddtlCmts_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 20; 5; ->$CurrRow_L; ->$CurrCell_L; ->$UWFeqIfNotImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 22; 3; ->$CurrRow_L; ->$CurrCell_L; ->$UWFeqCurr_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 22; 4; ->$CurrRow_L; ->$CurrCell_L; ->$UWFeqRecom_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 24; 9; ->$CurrRow_L; ->$CurrCell_L; ->$FixMonitDevImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 25; 2; ->$CurrRow_L; ->$CurrCell_L; ->$FixMonitDevAddtlCmts_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 25; 5; ->$CurrRow_L; ->$CurrCell_L; ->$FixMonitDevIfNotImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 29; 9; ->$CurrRow_L; ->$CurrCell_L; ->$FLoodMonitImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 30; 2; ->$CurrRow_L; ->$CurrCell_L; ->$FLoodMonitAddtlCmts_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 30; 5; ->$CurrRow_L; ->$CurrCell_L; ->$FLoodMonitIfNotImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 34; 9; ->$CurrRow_L; ->$CurrCell_L; ->$PostFloodImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 35; 2; ->$CurrRow_L; ->$CurrCell_L; ->$PostFloodAddtlCmts_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 35; 5; ->$CurrRow_L; ->$CurrCell_L; ->$PostFloodIfNotImpl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 41; 2; ->$CurrRow_L; ->$CurrCell_L; ->$I113WhenPOA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 41; 3; ->$CurrRow_L; ->$CurrCell_L; ->$I113RecChg_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 41; 4; ->$CurrRow_L; ->$CurrCell_L; ->$I113CurrSIA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 41; 5; ->$CurrRow_L; ->$CurrCell_L; ->$I113Expl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 43; 2; ->$CurrRow_L; ->$CurrCell_L; ->$I60WhenPOA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 43; 3; ->$CurrRow_L; ->$CurrCell_L; ->$I60RecChg_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 43; 4; ->$CurrRow_L; ->$CurrCell_L; ->$I60CurrSIA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 43; 5; ->$CurrRow_L; ->$CurrCell_L; ->$I60Expl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 45; 2; ->$CurrRow_L; ->$CurrCell_L; ->$I61WhenPOA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 45; 3; ->$CurrRow_L; ->$CurrCell_L; ->$I61RecChg_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 45; 4; ->$CurrRow_L; ->$CurrCell_L; ->$I61CurrSIA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 45; 5; ->$CurrRow_L; ->$CurrCell_L; ->$I61Expl_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 47; 2; ->$CurrRow_L; ->$CurrCell_L; ->$I71WhenPOA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 47; 3; ->$CurrRow_L; ->$CurrCell_L; ->$I71RecChg_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 47; 4; ->$CurrRow_L; ->$CurrCell_L; ->$I71CurrSIA_txt)))
								: (Not:C34(getToRowCell($xmldoc_t; 47; 5; ->$CurrRow_L; ->$CurrCell_L; ->$I71Expl_txt)))
								Else 
									$SAXevt_L:=XML end element:K45:11  //say we re done
									$GotAllData_b:=True:C214
							End case 
							
						End if 
				End case 
				
		End case 
		
	Until (($SAXevt_L=XML end document:K45:15) | $importErr_b | (OK=0))
	
	CLOSE DOCUMENT:C267($xmldoc_t)
	
	If ($GotAllData_b)
		// now process the values extracted
		//check if struct number is valid BDEPT-BIN-Item8Own-Item8Cat
		READ ONLY:C145(*)
		
		ARRAY TEXT:C222($StrNumParts_atxt; 0)
		ut_TextToArray($StructNum_txt; ->$StrNumParts_atxt; "-")
		C_TEXT:C284($BIN_txt; $StrNumCleaned_txt)
		$BIN_txt:=$StrNumParts_atxt{2}
		$StrNumCleaned_txt:=Replace string:C233($StructNum_txt; "-"; "")
		$StrNumCleaned_txt:=f_TrimStr($StrNumCleaned_txt; True:C214; True:C214)
		//parse bin
		
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_txt)
		
		SET ASSERT ENABLED:C1131(True:C214; *)
		
		Case of 
			: (Not:C34(Asserted:C1132(Records in selection:C76([Bridge MHD NBIS:1])=1; "No record found for BIN "+$BIN_txt)))
			: (Not:C34(Asserted:C1132([Bridge MHD NBIS:1]Item8:206=$StrNumCleaned_txt; "Structure number for BIN "+$BIN_txt+" : "+[Bridge MHD NBIS:1]Item8:206+"  does not match number in spreadsheet : "+$StrNumCleaned_txt)))
			Else 
				//all ok now work with the other stuff
				
				
		End case 
		
	End if 
	
End if 


//End ReadPOASummaryFromXML