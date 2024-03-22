//%attributes = {"invisible":true}
//Method: PON_LoadMigratorResults
//Description
// Load results from the AASHTOWARE migrator.
// for testing will create entries in inspevent table
// production will match table based on the inspkey converted from [inspections]inspid
// brkey is the BIN
// quantities are assumed to be in metric - they are converted to English using the paircode in the xml attributes
// factors extracted from file Default-Operating-Enviroment.xml from the migrator
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:34:31
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(11/18/15 11:34:19)
	Mods_2015_11
	//  `Added code to track time elapsed and create a log file
End if 
//
// Method: PON_LoadMigratorResults
// Description
If (False:C215)
	
End if 
//```/   sample data from migrator `````
//<ELEMENT-DATA version="2.0"xsi:noNamespaceSchemaLocation="ElementData - 8.xsd"xmlns:xsi="http:`www.w3.org/2001/XMLSchema-instance">
//<DECLARATION>
//<Source>tmpEC13.tmp</Source>
//<Format>O</Format>
//<Description>Prepared from the source file 'tmpEC13.tmp' using the AASHTO Element Migration Utility</Description>
//<Units>M</Units>
//</DECLARATION>
//<DATA>
//<ELEMENT brkey="0LL" inspkey="DSFC"inspdate="2014-05-06"strunitkey="0"elemkey="107"envkey="2"quantity="99.06"Scale-factor="1"paircode="56"Num-core-origins="1"core-parent-number="107">
//<Condition-States>
//<State>0</State>
//<State>18.288</State>
//<State>60.96</State>
//<State>19.812</State>
//</Condition-States>
//<Origin>
//<Trigger>
//<Rule id="1107">
//<Condition>(1)</Condition>
//</Rule>
//<Element strunitkey="0"elemkey="107"envkey="2"quantity="99.06"paircode="56"/>
//</Trigger>
//</Origin>
//<Element-Notes-Exchange><Source-Elmrowidkey>A-DOT001-0952C02D-13</Source-Elmrowidkey><Source-Docrefkey>A-DOT001-0952C02D-0000001A</Source-Docrefkey><Source-Element-Inspection-Notes></Source-Element-Inspection-Notes></Element-Notes-Exchange>
//</ELEMENT>
//</DATA>
// </ELEMENT-DATA>

// Parameters
// (none)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 12/28/14, 09:42:53
	// ----------------------------------------------------
	// First Release
	//**********`Modified by: Costas Manousakis-(Designer)-(6/5/15)
	//  ` fixed in the creation of act log records - set ◊Destination to District x BMS insted of vsForward.
End if 
C_TIME:C306($xmldoc_t)
$xmldoc_t:=Open document:C264(""; "XML"; Read mode:K24:5)
If (OK=1)
	C_BOOLEAN:C305($migratorDataEngl_b)
	CONFIRM:C162("Is data from migrator in English or Metric units?"; "English"; "Metric")
	$migratorDataEngl_b:=(OK=1)
	
	C_BOOLEAN:C305($logChanges_b)
	CONFIRM:C162("Log Changes to DB?"; "Log"; "Don't Log")
	$logChanges_b:=(OK=1)
	
	C_LONGINT:C283($SAXevt_L; $tbl_L; $fld_L; $testTbl_L)
	C_TEXT:C284($elmtname_txt; $elmPref_txt; $elmtValue_t; $tablename_t; $fieldname_t)
	ARRAY TEXT:C222($elmAttrs_atxt; 0)
	ARRAY TEXT:C222($elmtAttrVals_atxt; 0)
	C_POINTER:C301($tbl_ptr; $fld_ptr; $null_ptr)
	$tbl_L:=0
	C_BOOLEAN:C305($startTbl_b; $importErr_b; $end_of_elem_b; $readingState_b; $readingNotes; $doRollUP_b)
	ARRAY TEXT:C222($SaxLevels_atxt; 0)
	C_TEXT:C284($brKey_txt; $inspkey_txt)
	C_LONGINT:C283($InspCounter_L; $ElemCounter_L; $newElem_L; $updateElem_L)
	C_LONGINT:C283($elemKey_L; $envkey_L; $parentKey_L; $GrandparentKey_L; $SaxLevel_element_L; $parentID_L; $paircode_L; $inspID_L; $stateCounter_L)
	C_REAL:C285($quant_r; $metr_to_engl_factor_r)
	C_DATE:C307($inspdate_d)
	$importErr_b:=False:C215
	$InspCounter_L:=0
	$ElemCounter_L:=0
	$newElem_L:=0
	$updateElem_L:=0
	C_TEXT:C284($createUserKey_txt)  // used to mark elements from same input run
	$createUserKey_txt:="IMP:"+ISODateTime(Current date:C33(*); Current time:C178(*))
	READ ONLY:C145(*)
	READ WRITE:C146([PON_ELEM_INSP:179])
	ARRAY POINTER:C280(ptr_changes; 0; 0)
	C_TIME:C306($start_t; $end_t)
	C_TEXT:C284($ImportLogFileName_txt)
	$ImportLogFileName_txt:=(Document+".Import.Log")
	C_TIME:C306($ImportLogFileName_t)
	$ImportLogFileName_t:=Create document:C266($ImportLogFileName_txt)
	CLOSE DOCUMENT:C267($ImportLogFileName_t)
	SHORT_MESSAGE("Loading elements ..........")
	$start_t:=Current time:C178(*)
	Repeat 
		$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
		
		Case of 
			: ($SAXevt_L=XML start element:K45:10)
				
				SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
				APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
				
				Case of 
					: ($elmtname_txt="ELEMENT")
						$SaxLevel_element_L:=Size of array:C274($SaxLevels_atxt)
						//start of element
						// get main data from attributes
						$brKey_txt:=$elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "brkey")}
						$inspkey_txt:=$elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "inspkey")}
						$inspdate_d:=ISOStringToDate($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "inspdate")})
						$elemKey_L:=Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "elemkey")})
						$envkey_L:=Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "envkey")})
						$quant_r:=Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "quantity")})
						$paircode_L:=Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "paircode")})
						$metr_to_engl_factor_r:=1
						Case of 
							: ($migratorDataEngl_b)
								$metr_to_engl_factor_r:=1  // english units - no translation
							: ($paircode_L=55)
								$metr_to_engl_factor_r:=1
							: ($paircode_L=56)
								//m to ft 
								$metr_to_engl_factor_r:=0.3048
							: ($paircode_L=57)
								//sq.m. to sq.ft.
								$metr_to_engl_factor_r:=0.09290304
						End case 
						
						If (Find in array:C230($elmAttrs_atxt; "linked-to-element-number")>0)
							$parentKey_L:=Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "linked-to-element-number")})
						Else 
							$parentKey_L:=0
						End if 
						//convert inspkey to inspid
						$inspID_L:=PON_INSPKEY2INSPID($inspkey_txt)
						// search [BMS Inspections] table for $inspid_L
						// match bin with brkey
						// match inspection date with inspection date
						//if not found - abort import!!
						// $importErr_b:=True
						QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=$inspID_L)
						$importErr_b:=True:C214
						Case of 
							: (Records in selection:C76([BMS Inspections:44])#1)
							: ([BMS Inspections:44]BIN:2#$brKey_txt)
							: ([BMS Inspections:44]Insp Date:4#$inspdate_d)
							Else 
								//match NBE Elements to [Inspections] table
								QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BMSInspID:3=$inspID_L)
								QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
								If (Records in selection:C76([Inspections:27])=1)
									$inspID_L:=[Combined Inspections:90]NBISInspID:2
									$importErr_b:=False:C215
								End if 
								
						End case 
						
						
						If (Not:C34($importErr_b))
							$end_of_elem_b:=False:C215
							$doRollUP_b:=False:C215
							
							QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]BRKEY:1=$brKey_txt; *)
							QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]INSPKEY:2=$inspkey_txt; *)
							QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_KEY:3=$elemKey_L; *)
							QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]STRUNITKEY:6=1; *)
							QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4=$parentKey_L; *)  //check parent too for prot systems or defects
							QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ENVKEY:5=$envkey_L)
							If (Records in selection:C76([PON_ELEM_INSP:179])>0)
								//there is a duplicate!!!!!
								// do a roll up or replace????
								//if the create user key is same then add - else - abort????
								If ([PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24=$createUserKey_txt)
									$doRollUP_b:=True:C214
									//add the total quantity
									[PON_ELEM_INSP:179]ELEM_QUANTITY:7:=[PON_ELEM_INSP:179]ELEM_QUANTITY:7+$quant_r
								Else 
									//update??? should load record here
									If (ut_LoadRecordInteractive(->[PON_ELEM_INSP:179]))
										//update quantity
										InitChangeStack(1)
										C_LONGINT:C283(PON_ChangeStackLvl_L)
										PON_ChangeStackLvl_L:=1
										[PON_ELEM_INSP:179]ELEM_QUANTITY:7:=($quant_r/$metr_to_engl_factor_r)
										$updateElem_L:=$updateElem_L+1
									Else 
										$importErr_b:=True:C214
									End if 
									
								End if 
								
							Else 
								//new record 
								InitChangeStack(1)
								C_LONGINT:C283(PON_ChangeStackLvl_L)
								PON_ChangeStackLvl_L:=1
								CREATE RECORD:C68([PON_ELEM_INSP:179])
								Inc_Sequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)
								[PON_ELEM_INSP:179]BRKEY:1:=$brKey_txt
								[PON_ELEM_INSP:179]INSPKEY:2:=$inspkey_txt
								[PON_ELEM_INSP:179]INSPID:21:=$inspID_L
								[PON_ELEM_INSP:179]ELEM_KEY:3:=$elemKey_L
								[PON_ELEM_INSP:179]ENVKEY:5:=$envkey_L
								[PON_ELEM_INSP:179]ELEM_QUANTITY:7:=($quant_r/$metr_to_engl_factor_r)
								[PON_ELEM_INSP:179]ELEM_QorP:29:=True:C214
								[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=$parentKey_L
								[PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17:=ISODateTime(Current date:C33(*); Current time:C178(*))
								[PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24:=$createUserKey_txt
								[PON_ELEM_INSP:179]STRUNITKEY:6:=1
								[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19:=$grandparentKey_L
								$newElem_L:=$newElem_L+1
								
								If ($parentKey_L>0)
									C_LONGINT:C283(PARENTID_L; ENV_L; PARKEY_L; STRUNI_L; INSPID_L)
									INSPID_L:=[PON_ELEM_INSP:179]INSPID:21
									PARKEY_L:=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4
									ENV_L:=[PON_ELEM_INSP:179]ENVKEY:5
									STRUNI_L:=[PON_ELEM_INSP:179]STRUNITKEY:6
									Begin SQL
										select [PON_ELEM_INSP].ELEMID from [PON_ELEM_INSP]
										where
										[PON_ELEM_INSP].INSPID = :INSPID_L AND
										[PON_ELEM_INSP].ELEM_KEY = :PARKEY_L and
										[PON_ELEM_INSP].ENVKEY = :ENV_L and
										[PON_ELEM_INSP].STRUNITKEY = :STRUNI_L
										into :PARENTID_L ;
									End SQL
									
									[PON_ELEM_INSP:179]ELEM_PARENTID:27:=PARENTID_L
								End if 
								
							End if 
							$stateCounter_L:=0
							$readingState_b:=False:C215
							$readingNotes:=False:C215
							Repeat   // loop to load quantities in states and notes if any
								$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
								Case of 
										
									: ($SAXevt_L=XML start element:K45:10)
										
										SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
										APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
										Case of 
											: ($elmtname_txt="State")
												$readingState_b:=True:C214
											: ($elmtname_txt="Source-Element-Inspection-Notes")
												$readingNotes:=True:C214
										End case 
										
									: ($SAXevt_L=XML DATA:K45:12)
										Case of 
											: ($readingState_b)
												$stateCounter_L:=$stateCounter_L+1
												$fld_ptr:=getFieldbyname("PON_ELEM_INSP"; "ELEM_QTYSTATE"+String:C10($stateCounter_L))
												SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $fld_ptr->)
												$fld_ptr->:=($fld_ptr->)/$metr_to_engl_factor_r  // this is update
												If ($doRollUP_b)
													$fld_ptr->:=Old:C35($fld_ptr->)+$fld_ptr->  // this is rollup
												End if 
												$readingState_b:=False:C215
											: ($readingNotes)
												SAX GET XML ELEMENT VALUE:C877($xmldoc_t; [PON_ELEM_INSP:179]ELEM_NOTES:20)
												//need to trim 
												[PON_ELEM_INSP:179]ELEM_NOTES:20:=f_TrimStr([PON_ELEM_INSP:179]ELEM_NOTES:20; True:C214; True:C214)
												If ($doRollUP_b)
													Case of 
														: (Length:C16(Old:C35([PON_ELEM_INSP:179]ELEM_NOTES:20))=0)
															// leave as is ---
														: (Length:C16([PON_ELEM_INSP:179]ELEM_NOTES:20)=0)
															//nothing added - leave as is
														Else 
															[PON_ELEM_INSP:179]ELEM_NOTES:20:=Old:C35([PON_ELEM_INSP:179]ELEM_NOTES:20)+Char:C90(13)+"merged with: "+Char:C90(13)+[PON_ELEM_INSP:179]ELEM_NOTES:20
															
													End case 
													
												End if 
												$readingNotes:=False:C215
										End case 
										
									: ($SAXevt_L=XML end element:K45:11)
										If (($SaxLevels_atxt{Size of array:C274($SaxLevels_atxt)}="ELEMENT") & (Size of array:C274($SaxLevels_atxt)=$SaxLevel_element_L))
											$end_of_elem_b:=True:C214
										End if 
										DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
								End case 
								
							Until ($end_of_elem_b)
							//set the percentages
							
							If (Not:C34($importErr_b))  // should not do this if error
								$ElemCounter_L:=$ElemCounter_L+1
								MESSAGE:C88(String:C10($ElemCounter_L)+" . ")
								
								[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12:=Round:C94(100*([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); 2)
								[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11:=Round:C94(100*([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); 2)
								[PON_ELEM_INSP:179]ELEM_PCTSTATE2:10:=Round:C94(100*([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14/[PON_ELEM_INSP:179]ELEM_QUANTITY:7); 2)
								[PON_ELEM_INSP:179]ELEM_PCTSTATE1:9:=100-([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10+[PON_ELEM_INSP:179]ELEM_PCTSTATE3:11+[PON_ELEM_INSP:179]ELEM_PCTSTATE4:12)
								If ($logChanges_b)
									//◊Transfer must be set to 0
									//vsForward set to the District
									C_LONGINT:C283($transSave_L)
									$transSave_L:=<>Transfer
									C_TEXT:C284($saveforward)  // Command Replaced was o_C_STRING length was 80
									$saveforward:=<>Destination
									<>Transfer:=0
									QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[PON_ELEM_INSP:179]BRKEY:1)
									<>Destination:="District "+Substring:C12([Bridge MHD NBIS:1]InspResp:173; 5; 1)+" BMS"
									PON_RecordAllChanges
									//then set back or clear
									<>Destination:=$saveforward
									<>Transfer:=$transSave_L
									
								End if 
								SAVE RECORD:C53([PON_ELEM_INSP:179])
								UNLOAD RECORD:C212([PON_ELEM_INSP:179])
							End if 
						End if 
						
				End case 
				
			: ($SAXevt_L=XML end element:K45:11)
				DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
				
		End case 
	Until (($SAXevt_L=XML end document:K45:15) | $importErr_b)
	CLOSE WINDOW:C154
	CLOSE DOCUMENT:C267($xmldoc_t)
	$end_t:=Current time:C178(*)
	C_TEXT:C284($Msg_txt)
	$Msg_txt:="Processed  "+String:C10($ElemCounter_L)+" elements!"+Char:C90(13)+"Created New "+String:C10($newElem_L)+Char:C90(13)+"Updated "+String:C10($updateElem_L)+Char:C90(13)+"Duration "+String:C10($end_t-$start_t)
	ALERT:C41($Msg_txt)
	C_BLOB:C604($ImportLogFileName_x)
	$Msg_txt:="Imported to "+Structure file:C489+Char:C90(13)+"Date "+String:C10(Current date:C33(*))+" - Time Finished "+String:C10(Current time:C178(*))+Char:C90(13)+$Msg_txt
	TEXT TO BLOB:C554($Msg_txt; $ImportLogFileName_x; UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($ImportLogFileName_txt; $ImportLogFileName_x)
	
End if 
//End LoadMigratorResults