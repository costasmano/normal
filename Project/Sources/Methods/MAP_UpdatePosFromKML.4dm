//%attributes = {"invisible":true}
//Method: MAP_UpdatePosFromKML
//Description
// Read a KML file and update the LatLon values if they are different
// will only work with the current list of bridges
// run from a menu which is allowed only to Field group
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/27/16, 12:06:47
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	// Modified by: Costas Manousakis-(Designer)-(12/9/16 17:07:07)
	Mods_2016_12
	//  `added mod date /time mod by
End if 
//
//verify that user has access to all BINs .- he/she must have the list of bridges
CONFIRM:C162("Bridges in the KML file will be matched against the current list of Bridges! If they are not in the list, they will be ignored!"; "Proceed"; "Cancel")
If (OK=1)
	C_TIME:C306($xmldoc_t)
	$xmldoc_t:=Open document:C264(""; "KML"; Read mode:K24:5)
	If (OK=1)
		C_BOOLEAN:C305($end_of_placemark_b; $importErr_b)
		
		$end_of_placemark_b:=False:C215
		ARRAY TEXT:C222($BINS_atxt; 0)
		ARRAY TEXT:C222($Coords_atxt; 0)
		$importErr_b:=False:C215
		C_TEXT:C284($elmtname_txt; $elmPref_txt)
		ARRAY TEXT:C222($elmAttrs_atxt; 0)
		ARRAY TEXT:C222($elmtAttrVals_atxt; 0)
		ARRAY TEXT:C222($SaxLevels_atxt; 0)
		ARRAY TEXT:C222($SelectBINs_atxt; 0)
		ARRAY TEXT:C222($FilteredBINs_atxt; 0)
		ARRAY LONGINT:C221($FilterRecNos_aL; 0)
		ARRAY LONGINT:C221($SelectRecNos_aL; 0)
		C_LONGINT:C283($SaxLevel_element_L; $SAXevt_L)
		
		COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "KMLSTARTSELECTION")
		C_TEXT:C284($BIN_txt; $Coords_txt; $PointName_txt)
		C_BOOLEAN:C305($readingName_b; $readingPos_b; $end_of_placemark_b)
		
		Repeat 
			$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
			
			Case of 
				: ($SAXevt_L=XML start element:K45:10)
					
					SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
					APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
					
					Case of 
						: ($elmtname_txt="Placemark")
							$SaxLevel_element_L:=Size of array:C274($SaxLevels_atxt)
							$BIN_txt:=""
							$Coords_txt:=""
							$readingName_b:=False:C215
							$readingPos_b:=False:C215
							$end_of_placemark_b:=False:C215
							Repeat 
								$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
								
								Case of 
									: ($SAXevt_L=XML start element:K45:10)
										
										SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
										APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
										Case of 
											: ($elmtname_txt="name")
												$readingName_b:=True:C214
											: ($elmtname_txt="Point")
												$readingPos_b:=True:C214
										End case 
										
									: ($SAXevt_L=XML DATA:K45:12)
										Case of 
											: ($readingName_b)
												SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $PointName_txt)
												If (Position:C15("("; $PointName_txt)>0)
													$BIN_txt:=Substring:C12($PointName_txt; (Position:C15("("; $PointName_txt)+1); 3)
												End if 
												
												$readingName_b:=False:C215
												
											: ($readingPos_b)
												$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
												SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
												APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
												
												Case of 
													: ($elmtname_txt="coordinates")
														$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
														If ($SAXevt_L=XML DATA:K45:12)
															SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $Coords_txt)
														End if 
												End case 
												
												$readingPos_b:=False:C215
										End case 
										
									: ($SAXevt_L=XML end element:K45:11)
										If (($SaxLevels_atxt{Size of array:C274($SaxLevels_atxt)}="Placemark") & (Size of array:C274($SaxLevels_atxt)=$SaxLevel_element_L))
											$end_of_placemark_b:=True:C214
										End if 
										DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
								End case 
								
							Until ($end_of_placemark_b)
							APPEND TO ARRAY:C911($BINS_atxt; $BIN_txt)
							APPEND TO ARRAY:C911($Coords_atxt; $Coords_txt)
							
					End case 
					
				: ($SAXevt_L=XML end element:K45:11)
					DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
			End case 
			
			
		Until (($SAXevt_L=XML end document:K45:15) | $importErr_b)
		
		CLOSE DOCUMENT:C267($xmldoc_t)
		ARRAY TEXT:C222($ToBeChangedBINs_atxt; 0)
		ARRAY TEXT:C222($changedBINs_atxt; 0)
		ARRAY REAL:C219($OldLat_ar; 0)
		ARRAY REAL:C219($OldLon_ar; 0)
		ARRAY REAL:C219($NewLat_ar; 0)
		ARRAY REAL:C219($NewLon_ar; 0)
		ARRAY TEXT:C222($KMLBINs_atxt; 0)
		C_LONGINT:C283($loop_L)
		//check the list of BINs in the KML file
		SHORT_MESSAGE("Checking BINs found in KML file...")
		For ($loop_L; 1; Size of array:C274($BINS_atxt))
			USE NAMED SELECTION:C332("KMLSTARTSELECTION")
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BINS_atxt{$loop_L})
			
			Case of 
				: (Records in selection:C76([Bridge MHD NBIS:1])=0)
					MESSAGE:C88("Error - BIN in KML ("+$BINS_atxt{$loop_L}+") not found in current list of Bridges!")
				: (Records in selection:C76([Bridge MHD NBIS:1])>1)
					MESSAGE:C88("Error - BIN in KML ("+$BINS_atxt{$loop_L}+") badly formed! results in multiple records")
				Else 
					APPEND TO ARRAY:C911($KMLBINs_atxt; $BINS_atxt{$loop_L})
					//round to 6 dec 
					C_REAL:C285($CurLat_r; $CurLon_r; $NewLat_r; $NewLon_r)
					
					$CurLat_r:=ut_DegMinSecToDeg([Bridge MHD NBIS:1]Item16A:68; [Bridge MHD NBIS:1]Item16B:69; [Bridge MHD NBIS:1]Item16C:109)
					$CurLon_r:=(-1)*ut_DegMinSecToDeg([Bridge MHD NBIS:1]Item17A:70; [Bridge MHD NBIS:1]Item17B:71; [Bridge MHD NBIS:1]Item17C:136)
					ARRAY TEXT:C222($coordvalues_atxt; 0)
					ut_TextToArray($Coords_atxt{$loop_L}; ->$coordvalues_atxt; ",")
					$NewLon_r:=Num:C11($coordvalues_atxt{1})
					$NewLat_r:=Num:C11($coordvalues_atxt{2})
					
					$CurLat_r:=Round:C94($CurLat_r; 6)
					$CurLon_r:=Round:C94($CurLon_r; 6)
					$NewLon_r:=Round:C94($NewLon_r; 6)
					$NewLat_r:=Round:C94($NewLat_r; 6)
					
					If (($CurLat_r#$NewLat_r) | ($CurLon_r#$NewLon_r))
						//
						APPEND TO ARRAY:C911($ToBeChangedBINs_atxt; $BINS_atxt{$loop_L})
						APPEND TO ARRAY:C911($OldLat_ar; $CurLat_r)
						APPEND TO ARRAY:C911($OldLon_ar; $CurLon_r)
						APPEND TO ARRAY:C911($NewLat_ar; $NewLat_r)
						APPEND TO ARRAY:C911($NewLon_ar; $NewLon_r)
						
					End if 
					
			End case 
			
		End for 
		CLOSE WINDOW:C154
		Case of 
			: (Size of array:C274($KMLBINs_atxt)=0)
				ALERT:C41("KML file contained no BINs matching the current list of bridges!")
				USE NAMED SELECTION:C332("KMLSTARTSELECTION")
				
			: (Size of array:C274($ToBeChangedBINs_atxt)=0)
				CONFIRM:C162("There were no significant changes to LatLons in the selected KML! Leave Bridge list as is, or Show List of BINs found in KML?"; "Leave as is"; "Show KML BINs")
				USE NAMED SELECTION:C332("KMLSTARTSELECTION")
				If (OK=0)
					SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]; $SelectRecNos_aL; [Bridge MHD NBIS:1]BIN:3; $SelectBINs_atxt)
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274($SelectBINs_atxt))
						If (Find in array:C230($KMLBINs_atxt; $SelectBINs_atxt{$loop_L})>0)
							APPEND TO ARRAY:C911($FilterRecNos_aL; $SelectRecNos_aL{$loop_L})
						End if 
					End for 
					CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $FilterRecNos_aL)
					
				End if 
			Else 
				C_LONGINT:C283(UseList_HL; OmitList_HL)
				C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
				TWOLIST_MOVEONLY_B:=False:C215
				UseList_HL:=ut_ArrayToHL(->$ToBeChangedBINs_atxt)
				OmitList_HL:=New list:C375
				
				C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
				vCancelBtntxt:="Cancel"
				vOKBtnTxt:="Proceed"
				vUseListLbl_txt:="BINs with LatLon changes"
				vOmitLbl_txt:="Apply changes to BINs"
				C_BOOLEAN:C305($DoSum_b)
				$DoSum_b:=False:C215
				C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
				C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b; $ReviewChoise_b)
				$ReviewChoise_b:=False:C215  // option to review lists at the end if no changes were confirmed
				
				C_TEXT:C284($Title_txt)
				FORM GET PROPERTIES:C674("TwoListMove"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
				$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; "Select BINs to Change LatLon"; "ut_CloseCancel")
				DIALOG:C40("TwoListMove")
				CLOSE WINDOW:C154($Win_l)
				If (OK=1)
					C_LONGINT:C283($num_selected_L)
					$num_selected_L:=Count list items:C380(OmitList_HL)
					If ($num_selected_L>0)
						C_LONGINT:C283($ref; $index_L)
						C_TEXT:C284($Name)
						ARRAY POINTER:C280(PTR_CHANGES; 0; 0)
						For ($loop_L; 1; $num_selected_L)
							GET LIST ITEM:C378(OmitList_HL; $loop_L; $Ref; $Name)
							$index_L:=Find in array:C230($ToBeChangedBINs_atxt; $Name)
							C_LONGINT:C283($Deg_L; $Min_L)
							C_REAL:C285($Sec_R)
							If ($index_L>0)
								USE NAMED SELECTION:C332("KMLSTARTSELECTION")
								QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$Name)
								
								If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
									APPEND TO ARRAY:C911($changedBINs_atxt; $Name)
									//ALERT("changing BIN "+$Name)
									InitChangeStack(1)
									ut_degToDegMinSec($NewLat_ar{$index_L}; ->[Bridge MHD NBIS:1]Item16A:68; ->[Bridge MHD NBIS:1]Item16B:69; ->[Bridge MHD NBIS:1]Item16C:109)
									PushChange(1; ->[Bridge MHD NBIS:1]Item16A:68)
									PushChange(1; ->[Bridge MHD NBIS:1]Item16B:69)
									PushChange(1; ->[Bridge MHD NBIS:1]Item16C:109)
									ut_degToDegMinSec((-1)*$NewLon_ar{$index_L}; ->[Bridge MHD NBIS:1]Item17A:70; ->[Bridge MHD NBIS:1]Item17B:71; ->[Bridge MHD NBIS:1]Item17C:136)
									PushChange(1; ->[Bridge MHD NBIS:1]Item17A:70)
									PushChange(1; ->[Bridge MHD NBIS:1]Item17B:71)
									PushChange(1; ->[Bridge MHD NBIS:1]Item17C:136)
									[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
									[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
									[Bridge MHD NBIS:1]Modified By:191:=<>CurrentUser_Name
									PushChange(1; ->[Bridge MHD NBIS:1]DateModified:194)
									PushChange(1; ->[Bridge MHD NBIS:1]TimeModified:195)
									PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
									FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
									SAVE RECORD:C53([Bridge MHD NBIS:1])
									UNLOAD RECORD:C212([Bridge MHD NBIS:1])
								Else 
									ALERT:C41("Could not modify BIN "+$Name)
								End if 
								
							Else 
								ALERT:C41("Error in selected BIN "+$Name+"! Not found in list of BINs with changed Lat Lon !")
							End if 
							
						End for 
						
						//
						ALERT:C41("Modified positions for "+String:C10(Size of array:C274($changedBINs_atxt))+" BINs!")
						
						USE NAMED SELECTION:C332("KMLSTARTSELECTION")
						C_LONGINT:C283($Option_L)
						$Option_L:=ut_3Option_Confirm("Reduce list to bridges in KML , Bridges with modified positions, or leave as is"; "All KML BINs"; "Changed BINs"; "Leave as is")
						
						Case of 
							: ($Option_L=1)
								SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]; $SelectRecNos_aL; [Bridge MHD NBIS:1]BIN:3; $SelectBINs_atxt)
								C_LONGINT:C283($loop_L)
								For ($loop_L; 1; Size of array:C274($SelectBINs_atxt))
									If (Find in array:C230($KMLBINs_atxt; $SelectBINs_atxt{$loop_L})>0)
										APPEND TO ARRAY:C911($FilterRecNos_aL; $SelectRecNos_aL{$loop_L})
									End if 
								End for 
								CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $FilterRecNos_aL)
							: ($Option_L=2)
								SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]; $SelectRecNos_aL; [Bridge MHD NBIS:1]BIN:3; $SelectBINs_atxt)
								For ($loop_L; 1; Size of array:C274($SelectBINs_atxt))
									If (Find in array:C230($changedBINs_atxt; $SelectBINs_atxt{$loop_L})>0)
										APPEND TO ARRAY:C911($FilterRecNos_aL; $SelectRecNos_aL{$loop_L})
									End if 
								End for 
								CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $FilterRecNos_aL)
								
							: ($Option_L=3)
								//leave as is
						End case 
						
					Else 
						ALERT:C41("There were no BINs selected to change positions!")
						$ReviewChoise_b:=True:C214
					End if 
				Else 
					$ReviewChoise_b:=True:C214
				End if 
				If (Is a list:C621(UseList_HL))
					CLEAR LIST:C377(UseList_HL; *)
				End if 
				If (Is a list:C621(OmitList_HL))
					CLEAR LIST:C377(OmitList_HL; *)
				End if 
				
				If ($ReviewChoise_b)
					USE NAMED SELECTION:C332("KMLSTARTSELECTION")
					C_LONGINT:C283($Option_L)
					$Option_L:=ut_3Option_Confirm("Reduce list to bridges in KML , Bridges with possible modified positions, or leave as is"; "All KML BINs"; "Diff LatLon BINs"; "Leave as is")
					
					Case of 
						: ($Option_L=1)
							SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]; $SelectRecNos_aL; [Bridge MHD NBIS:1]BIN:3; $SelectBINs_atxt)
							C_LONGINT:C283($loop_L)
							For ($loop_L; 1; Size of array:C274($SelectBINs_atxt))
								If (Find in array:C230($KMLBINs_atxt; $SelectBINs_atxt{$loop_L})>0)
									APPEND TO ARRAY:C911($FilterRecNos_aL; $SelectRecNos_aL{$loop_L})
								End if 
							End for 
							CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $FilterRecNos_aL)
						: ($Option_L=2)
							SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]; $SelectRecNos_aL; [Bridge MHD NBIS:1]BIN:3; $SelectBINs_atxt)
							For ($loop_L; 1; Size of array:C274($SelectBINs_atxt))
								If (Find in array:C230($ToBeChangedBINs_atxt; $SelectBINs_atxt{$loop_L})>0)
									APPEND TO ARRAY:C911($FilterRecNos_aL; $SelectRecNos_aL{$loop_L})
								End if 
							End for 
							CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $FilterRecNos_aL)
							
						: ($Option_L=3)
							//leave as is
					End case 
				End if 
		End case 
		CLEAR NAMED SELECTION:C333("KMLSTARTSELECTION")
	End if 
	WindowTitle
End if 

//End MAP_UpdatePosFromKML