//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJImportData
// User name (OS): cjmiller
// Date and time: 04/28/06, 14:58:11
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //05/09/07, 10:54:36`Add reviewer id
	Mods_2007_CM10a
	Mods_2008_CJM_v001  //r001 `02/26/08, 14:42:52     
	// Modified by: costasmanousakis-(Designer)-(5/23/08 12:00:13)
	Mods_2008_CM_5403  //for type and sketch plans set the strprjmgr as reviewer
	// Modified by: costasmanousakis-(Designer)-(6/23/08 12:58:05)
	Mods_2008_CM_5404  //(remove quotes from Status, last action, bdept
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2012_05
	//  `Use ◊MyDocumentsFolder_txt
End if 
C_TEXT:C284($Path_txt; $Changes_txt; $Key_txt; $BinError_txt)

$Path_txt:=<>MyDocumentsFolder_txt+"SQL_PRJData"+<>PL_DirectorySep_s
If (Test path name:C476($Path_txt)=0)
Else 
	CREATE FOLDER:C475($Path_txt)
End if 
C_TEXT:C284($FileName_txt)
C_TIME:C306($Document_tm)
$FileName_txt:="PRJUpdateRun-"+Substring:C12(ut_CreateTimeStamp; 1; 12)+".txt"
$Document_tm:=Create document:C266($Path_txt+$FileName_txt; "TEXT")
CLOSE DOCUMENT:C267($Document_tm)
C_TEXT:C284(DocmentPath_txt)
DocmentPath_txt:=Document

C_LONGINT:C283($win; $w; $h)
FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "Excel_Import.dlg"; $w; $h)
CENTER_WINDOW($w; $h; 0)
//$win:=Open form window([PRJ_ProjectDetails];"Excel_Import.dlg";0)
DIALOG:C40([PRJ_ProjectDetails:115]; "Excel_Import.dlg")
CLOSE WINDOW:C154
If (ExcelDisplay_txt="Delete")
	
	ALL RECORDS:C47([PRJ_ConstructionProject:116])
	DELETE SELECTION:C66([PRJ_ConstructionProject:116])
	
	ALL RECORDS:C47([PRJ_Contractor:114])
	DELETE SELECTION:C66([PRJ_Contractor:114])
	
	ALL RECORDS:C47([PRJ_DesignContracts:123])
	DELETE SELECTION:C66([PRJ_DesignContracts:123])
	
	ALL RECORDS:C47([PRJ_ProjectDetailsIncludedBINS:122])
	DELETE SELECTION:C66([PRJ_ProjectDetailsIncludedBINS:122])
	
	ALL RECORDS:C47([PRJ_ProjectDetails:115])
	DELETE SELECTION:C66([PRJ_ProjectDetails:115])
	
	ALL RECORDS:C47([PRJ_ProjectFile:117])
	DELETE SELECTION:C66([PRJ_ProjectFile:117])
	
	ALL RECORDS:C47([PRJ_ProjectTimeTracking:124])
	DELETE SELECTION:C66([PRJ_ProjectTimeTracking:124])
	
	ALL RECORDS:C47([PRJ_ReportData:118])
	DELETE SELECTION:C66([PRJ_ReportData:118])
	
	ALL RECORDS:C47([PRJ_SketchPlans:120])
	DELETE SELECTION:C66([PRJ_SketchPlans:120])
	
	ALL RECORDS:C47([PRJ_StructuralReview:119])
	DELETE SELECTION:C66([PRJ_StructuralReview:119])
	
	ALL RECORDS:C47([PRJ_TypeStudy:121])
	DELETE SELECTION:C66([PRJ_TypeStudy:121])
	
	//QUERY([TableOfLists];[TableOfLists]ListName_s="Program")
	//DELETE SELECTION([TableOfLists])
	//QUERY([TableOfLists];[TableOfLists]ListName_s="FederalAid")
	//DELETE SELECTION([TableOfLists])
	
End if 
If (ExcelDisplay_txt="Delete") | (ExcelDisplay_txt="Import")
	ARRAY TEXT:C222($FederalKey_atxt; 0)
	ARRAY TEXT:C222($FederalDescription_atxt; 0)
	ARRAY TEXT:C222($ProgramKey_atxt; 0)
	ARRAY TEXT:C222($ProgramDescription_atxt; 0)
	
	C_TIME:C306($Doc)
	$Doc:=Open document:C264("")
	
	ARRAY TEXT:C222($Skipped_atxt; 1)
	ARRAY TEXT:C222($ImportErrors_atxt; 1)
	C_TEXT:C284($Header_txt; $NewBinNumber_txt)
	C_TEXT:C284($Bridge_txt)
	C_TEXT:C284($Ewo_txt)
	C_TEXT:C284($ProjectFile_txt)
	C_TEXT:C284($LastAction_txt)
	C_TEXT:C284($HydroReport_txt)
	C_TEXT:C284($GeotechReport_txt)
	C_TEXT:C284($TypeStudy_txt)
	C_TEXT:C284($SketchPlan_txt)
	C_TEXT:C284($SketchPlanReview_txt)
	C_TEXT:C284($SketchPlanSigned_txt)
	C_TEXT:C284($StructureReviewAll_txt)
	C_TEXT:C284($StructureReview1ComToDE_txt)
	C_TEXT:C284($StructureReview2_txt)
	C_TEXT:C284($StructureReviewApproval_txt)
	C_TEXT:C284($BDS_txt)
	C_TEXT:C284($LumpSumBreakdown_txt)
	C_TEXT:C284($Commments_txt)
	C_TEXT:C284($Program_txt)
	C_TEXT:C284($FederalAid_txt)
	C_TEXT:C284($BinUpdateRequest_txt)
	C_TEXT:C284($StructureReview3_txt)
	//C_TEXT($Material_txt)
	//C_TEXT($UnitCost_txt)
	C_TEXT:C284($BeamCost_txt)
	C_TEXT:C284($BeamUnit_txt)
	C_TEXT:C284($Item995_txt)
	C_TEXT:C284($SketchPlanResponse_txt)
	C_TEXT:C284($TypeStudyApprovedType_txt)
	C_TEXT:C284($BinNumber_txt)
	C_TEXT:C284($UnitsBeam_txt)
	//C_TEXT($UnitsDeck_txt)
	C_TEXT:C284($Tip_txt)
	C_TEXT:C284($CompletionDate_txt)
	C_TEXT:C284($Status_txt)
	C_TEXT:C284($StucturalProjectManager_txt)
	C_TEXT:C284($RoadWayOver_txt)
	C_TEXT:C284($Reviewer_txt)
	C_TEXT:C284($ErrorDescription_txt)
	RECEIVE PACKET:C104($Doc; $Header_txt; Char:C90(Carriage return:K15:38))  //get the first row which contains headings
	C_LONGINT:C283($Count_l; $Loop_l)
	C_BOOLEAN:C305($Done_b)
	$Done_b:=False:C215
	$Loop_l:=0
	SHORT_MESSAGE("Loading ..")
	Repeat 
		RECEIVE PACKET:C104($Doc; $Bridge_txt; Char:C90(Tab:K15:37))
		$Loop_l:=$Loop_l+1
		MESSAGE:C88(String:C10($Loop_l)+Char:C90(13))
		If (OK=1)
			
			RECEIVE PACKET:C104($Doc; $Ewo_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $ProjectFile_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $StucturalProjectManager_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $LastAction_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $HydroReport_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $GeotechReport_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $TypeStudy_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $SketchPlan_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $SketchPlanReview_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $SketchPlanSigned_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $StructureReviewAll_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $StructureReview1ComToDE_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $StructureReview2_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $StructureReviewApproval_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $BDS_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $LumpSumBreakdown_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $Commments_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $Program_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $FederalAid_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $BinUpdateRequest_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $StructureReview3_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $BeamCost_txt; Char:C90(Tab:K15:37))  //still to do
			RECEIVE PACKET:C104($Doc; $BeamUnit_txt; Char:C90(Tab:K15:37))  //still to do
			RECEIVE PACKET:C104($Doc; $Item995_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $SketchPlanResponse_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $TypeStudyApprovedType_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $BinNumber_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $UnitsBeam_txt; Char:C90(Tab:K15:37))  //still to do
			RECEIVE PACKET:C104($Doc; $Tip_txt; Char:C90(Tab:K15:37))  //still to do
			RECEIVE PACKET:C104($Doc; $CompletionDate_txt; Char:C90(Tab:K15:37))  //still to do
			RECEIVE PACKET:C104($Doc; $Status_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $RoadWayOver_txt; Char:C90(Tab:K15:37))
			RECEIVE PACKET:C104($Doc; $Reviewer_txt; Char:C90(Carriage return:K15:38))
			
			//some cleanup
			$Status_txt:=Replace string:C233($Status_txt; <>sQU; "")
			$Bridge_txt:=Replace string:C233($Bridge_txt; <>sQU; "")
			$LastAction_txt:=Replace string:C233($LastAction_txt; <>sQU; "")
			
			C_LONGINT:C283($PRJ_utReviewerID_L)
			$PRJ_utReviewerID_L:=0
			Case of 
				: (Position:C15("H.A"; $Reviewer_txt)>0)  //hamid
					$PRJ_utReviewerID_L:=2
				: (Position:C15("H. At"; $Reviewer_txt)>0)  //hamid
					$PRJ_utReviewerID_L:=2
				: (Position:C15("APB"; $Reviewer_txt)>0)  //ann
					$PRJ_utReviewerID_L:=485
				: (Position:C15("JNC"; $Reviewer_txt)>0)  //jose
					$PRJ_utReviewerID_L:=536
				: (Position:C15("HKB"; $Reviewer_txt)>0)  //harish
					$PRJ_utReviewerID_L:=569
				: (Position:C15("KDR"; $Reviewer_txt)>0)  //kandi
					$PRJ_utReviewerID_L:=533
				: (Position:C15("K.R."; $Reviewer_txt)>0)  //kandi
					$PRJ_utReviewerID_L:=533
				: (Position:C15("MS"; $Reviewer_txt)>0)  //maura
					$PRJ_utReviewerID_L:=534
				: (Position:C15("M.S."; $Reviewer_txt)>0)  //maura
					$PRJ_utReviewerID_L:=534
				: (Position:C15("M. S."; $Reviewer_txt)>0)  //maura
					$PRJ_utReviewerID_L:=534
				: (Position:C15("MRF"; $Reviewer_txt)>0)  //farooq
					$PRJ_utReviewerID_L:=16
				: (Position:C15("M.F"; $Reviewer_txt)>0)  //farooq
					$PRJ_utReviewerID_L:=16
				: (Position:C15("WFB"; $Reviewer_txt)>0)  //bill
					$PRJ_utReviewerID_L:=10
				: (Position:C15("S.K"; $Reviewer_txt)>0)  //savas
					$PRJ_utReviewerID_L:=29
				: (Position:C15("JMD"; $Reviewer_txt)>0)  //jim
					$PRJ_utReviewerID_L:=13
				: (Position:C15("HLJ"; $Reviewer_txt)>0)  //harry
					$PRJ_utReviewerID_L:=537
				: (Position:C15("RPM"; $Reviewer_txt)>0)  //ron
					$PRJ_utReviewerID_L:=540
				: (Position:C15("Ron Mart"; $Reviewer_txt)>0)  //ron
					$PRJ_utReviewerID_L:=540
				: (Position:C15("F.Ng"; $Reviewer_txt)>0)
					$PRJ_utReviewerID_L:=44
				: (Position:C15("HRB"; $Reviewer_txt)>0)  //hemendra
					$PRJ_utReviewerID_L:=8
				: (Position:C15("DWO"; $Reviewer_txt)>0)  //dave
					$PRJ_utReviewerID_L:=538
				: (Position:C15("P.M."; $Reviewer_txt)>0)  //paul m
					$PRJ_utReviewerID_L:=543
				: (Position:C15("P. Maltzman"; $Reviewer_txt)>0)  //paul m
					$PRJ_utReviewerID_L:=543
				: (Position:C15("ART"; $Reviewer_txt)>0)  //tali
					$PRJ_utReviewerID_L:=539
				: (Position:C15("PLN"; $Reviewer_txt)>0)  //paul
					$PRJ_utReviewerID_L:=40
				: (Position:C15("FJN"; $Reviewer_txt)>0)  //nohelty
					$PRJ_utReviewerID_L:=532
				: (Position:C15("RAS"; $Reviewer_txt)>0)  //ray
					$PRJ_utReviewerID_L:=55
				: (Position:C15("R. Sur"; $Reviewer_txt)>0)  //ray
					$PRJ_utReviewerID_L:=55
				: (Position:C15("LRA"; $Reviewer_txt)>0)
					$PRJ_utReviewerID_L:=3
				: (Position:C15("GTS"; $Reviewer_txt)>0)  //G Samuel
					$PRJ_utReviewerID_L:=0
				: (Position:C15("VAL"; $Reviewer_txt)>0)  //valerie
					$PRJ_utReviewerID_L:=0
				: (Position:C15("VAM"; $Reviewer_txt)>0)  //valerie
					$PRJ_utReviewerID_L:=0
				: (Position:C15("Dick rush"; $Reviewer_txt)>0)  //rush
					$PRJ_utReviewerID_L:=542
				: (Position:C15("RLR"; $Reviewer_txt)>0)  //rush
					$PRJ_utReviewerID_L:=542
				: (Position:C15("Desmond"; $Reviewer_txt)>0)  //desmond
					$PRJ_utReviewerID_L:=112
				: (Position:C15("PF/PE"; $Reviewer_txt)>0)  //PFPE - Jalinous
					$PRJ_utReviewerID_L:=26
				: (Position:C15("PF / PE"; $Reviewer_txt)>0)  //PFPE - Jalinous
					$PRJ_utReviewerID_L:=26
					
			End case 
			C_LONGINT:C283($CurrentStructural_l)
			
			Case of 
				: (Position:C15("Tali"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=539
				: (Position:C15("Nohelty"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=532
				: (Position:C15("Ng"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=44
				: (Position:C15("Attarha"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=2
				: (Position:C15("Bhambi"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=569
				: (Position:C15("Bhatt"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=8
				: (Position:C15("Gendall"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=570
				: (Position:C15("Nyman"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=45
				: (Position:C15("Aversa"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=3
				: (Position:C15("Nardone"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=40
				: (Position:C15("Surette"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=55
				: (Position:C15("Tayarani"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=663
				: (Position:C15("Nabulsi"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=41
				: (Position:C15("Dalton"; $StucturalProjectManager_txt)>0)
					$CurrentStructural_l:=13
					
				Else 
					$CurrentStructural_l:=0
			End case 
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=Substring:C12($Bridge_txt; 1; 6))
			If (Records in selection:C76([Bridge MHD NBIS:1])>0)
				QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5=$Bridge_txt)
				C_BOOLEAN:C305($DoNewRec_b; $DoUpdate_b)
				$DoNewRec_b:=False:C215
				$DoUpdate_b:=False:C215
				If (Records in selection:C76([PRJ_ProjectDetails:115])=0)
					//New rec
					$DoNewRec_b:=True:C214
				Else 
					If (Records in selection:C76([PRJ_ProjectDetails:115])=1)
						//Single match
						//See if the projectfile number needs update
						C_LONGINT:C283($NewProjFileNo_L; $CurrProjFileNo_L)
						Case of 
							: ($ProjectFile_txt="Ch@")
								$NewProjFileNo_L:=0
							: ($ProjectFile_txt="Di@")
								$NewProjFileNo_L:=0
							Else 
								$NewProjFileNo_L:=Num:C11($ProjectFile_txt)
						End case 
						
						$DoUpdate_b:=True:C214
						If ($NewProjFileNo_L=0)
							//nothing
						Else 
							QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
							If ([PRJ_ProjectFile:117]PF_FileNumber_l:3=$NewProjFileNo_L)
								//Same num - no update of projectfile
							Else 
								If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
									$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
								Else 
									$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
								End if 
								If ([PRJ_ProjectFile:117]PF_FileNumber_l:3<=0)
									QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=$NewProjFileNo_L)
									If (Records in selection:C76([PRJ_ProjectFile:117])=1)
										//found one = assign it
										If (ut_LoadRecord(->[PRJ_ProjectDetails:115]))
											[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
											$Changes_txt:=$Changes_txt+" Changed File number to "+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
											SAVE RECORD:C53([PRJ_ProjectDetails:115])
										Else 
											$Changes_txt:=$Changes_txt+" Record locked Could not update File Number  :"+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
										End if 
									Else 
										$Changes_txt:=$Changes_txt+" Input File number not found :"+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
									End if 
								Else 
									//non-matching project file number - no update
									$DoUpdate_b:=False:C215
									$Changes_txt:=$Changes_txt+" Would not update record - file numbers don't match (Input: "+$ProjectFile_txt+" vs in data:"+String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)+Char:C90(Carriage return:K15:38)
								End if 
								C_TIME:C306($SQLDocument_tm)
								
								$SQLDocument_tm:=Append document:C265(DocmentPath_txt)
								SEND PACKET:C103($SQLDocument_tm; $Changes_txt)
								CLOSE DOCUMENT:C267($SQLDocument_tm)
							End if 
						End if 
					Else 
						QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=Num:C11($ProjectFile_txt))
						If (Records in selection:C76([PRJ_ProjectDetails:115])=1)
							//found match with file number
						Else 
							//could not match file number - set message
							$DoUpdate_b:=False:C215
							If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
								$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
							Else 
								$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
							End if 
							$Changes_txt:=$Changes_txt+" Multiple records - could not match file number "+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
							$SQLDocument_tm:=Append document:C265(DocmentPath_txt)
							SEND PACKET:C103($SQLDocument_tm; $Changes_txt)
							CLOSE DOCUMENT:C267($SQLDocument_tm)
						End if 
					End if 
				End if 
				
				If ($DoNewRec_b)
					CREATE RECORD:C68([PRJ_ProjectDetails:115])
					Inc_Sequence("PRJ_ProjectID_l"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
					[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5:=$Bridge_txt
					[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31:=$Ewo_txt
					$ProjectFile_txt:=ut_PRJRemoveExtraCharacters($ProjectFile_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
					If (ut_IsALongint($ProjectFile_txt))
						QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=Num:C11($ProjectFile_txt))
						If (Records in selection:C76([PRJ_ProjectFile:117])=0)
							CREATE RECORD:C68([PRJ_ProjectFile:117])
							Inc_Sequence("PF_FileID_l"; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
							[PRJ_ProjectFile:117]PF_FileNumber_l:3:=Num:C11($ProjectFile_txt)
							SAVE RECORD:C53([PRJ_ProjectFile:117])
						End if 
						[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
					End if 
					
					[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39:=$CurrentStructural_l
					[PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9:=$LastAction_txt
					If ($HydroReport_txt#"")
						$HydroReport_txt:=ut_PRJRemoveExtraCharacters($HydroReport_txt; Char:C90(Double quote:K15:41))
						ut_PRJImportCreateHydraulic($HydroReport_txt; "Hydraulic")
					End if 
					If ($GeotechReport_txt#"")
						$GeotechReport_txt:=ut_PRJRemoveExtraCharacters($GeotechReport_txt; Char:C90(Double quote:K15:41))
						ut_PRJImportCreateGeotech($GeotechReport_txt; "GEOTech")
					End if 
					$TypeStudy_txt:=ut_PRJRemoveExtraCharacters($TypeStudy_txt; Char:C90(Double quote:K15:41))
					$TypeStudyApprovedType_txt:=ut_PRJRemoveExtraCharacters($TypeStudyApprovedType_txt; Char:C90(Double quote:K15:41))
					
					If ($TypeStudy_txt="")
					Else 
						ut_PRJCreateTypeStudy($TypeStudy_txt; $TypeStudyApprovedType_txt; $CurrentStructural_l)
					End if 
					$SketchPlan_txt:=ut_PRJRemoveExtraCharacters($SketchPlan_txt; Char:C90(Double quote:K15:41))
					$SketchPlanReview_txt:=ut_PRJRemoveExtraCharacters($SketchPlanReview_txt; Char:C90(Double quote:K15:41))
					$SketchPlanSigned_txt:=ut_PRJRemoveExtraCharacters($SketchPlanSigned_txt; Char:C90(Double quote:K15:41))
					$SketchPlanResponse_txt:=ut_PRJRemoveExtraCharacters($SketchPlanResponse_txt; Char:C90(Double quote:K15:41))
					
					If ($SketchPlan_txt="") & ($SketchPlanReview_txt="") & ($SketchPlanSigned_txt="") & ($SketchPlanResponse_txt="")
						
					Else 
						ut_PRJCreateSketchPlan($SketchPlan_txt; $SketchPlanReview_txt; $SketchPlanSigned_txt; $SketchPlanResponse_txt; $CurrentStructural_l)
					End if 
					C_LONGINT:C283($NumberOfReviews_l)
					$NumberOfReviews_l:=0
					$StructureReviewAll_txt:=ut_PRJRemoveExtraCharacters($StructureReviewAll_txt; Char:C90(Double quote:K15:41))
					$StructureReview1ComToDE_txt:=ut_PRJRemoveExtraCharacters($StructureReview1ComToDE_txt; Char:C90(Double quote:K15:41))
					$StructureReviewApproval_txt:=ut_PRJRemoveExtraCharacters($StructureReviewApproval_txt; Char:C90(Double quote:K15:41))
					
					If ($StructureReviewAll_txt="") & ($StructureReview1ComToDE_txt="") & ($StructureReviewApproval_txt="")
						
					Else 
						$NumberOfReviews_l:=1
						ut_PRJCreateStructuralReview(1; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview1ComToDE_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
					End if 
					$StructureReview2_txt:=ut_PRJRemoveExtraCharacters($StructureReview2_txt; Char:C90(Double quote:K15:41))
					
					If ($StructureReview2_txt="")
					Else 
						$NumberOfReviews_l:=$NumberOfReviews_l+1
						ut_PRJCreateStructuralReview(2; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview2_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
					End if 
					$StructureReview3_txt:=ut_PRJRemoveExtraCharacters($StructureReview3_txt; Char:C90(Double quote:K15:41))
					
					If ($StructureReview3_txt="")
					Else 
						$NumberOfReviews_l:=$NumberOfReviews_l+1
						ut_PRJCreateStructuralReview(3; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview3_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
					End if 
					[PRJ_ProjectDetails:115]PRJ_Comments_txt:10:=$Commments_txt
					[PRJ_ProjectDetails:115]PRJ_BridgeDataSheetComplete_s:13:=$BDS_txt
					If ($LumpSumBreakdown_txt#"")
						[PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22:=ut_PRJ_SetDate($LumpSumBreakdown_txt)
					End if 
					
					SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
					
					$Program_txt:=ut_PRJRemoveExtraCharacters($Program_txt; Char:C90(Double quote:K15:41))
					$Key_txt:=Replace string:C233($Program_txt; " "; "")
					//ARRAY TEXT($ProgramKey_atxt;0)
					//ARRAY TEXT($ProgramDescription_atxt;0)
					C_LONGINT:C283($Location_l)
					If ($Program_txt#"")
						$Location_l:=Find in array:C230($ProgramKey_atxt; $Key_txt)
						If ($Location_l>0)
							
						Else 
							INSERT IN ARRAY:C227($ProgramDescription_atxt; 0; 1)
							INSERT IN ARRAY:C227($ProgramKey_atxt; 0; 1)
							$ProgramDescription_atxt{1}:=$Program_txt
							$ProgramKey_atxt{1}:=$Key_txt
							$Location_l:=1
						End if 
						[PRJ_ProjectDetails:115]PRJ_Program_s:23:=$ProgramDescription_atxt{$Location_l}
						QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="Program"; *)
						QUERY:C277([TableOfLists:125];  & ; [TableOfLists:125]ListValue_s:2=$ProgramDescription_atxt{$Location_l})
						If ($Count_l=0)
							CREATE RECORD:C68([TableOfLists:125])
							[TableOfLists:125]ListName_s:1:="Program"
							[TableOfLists:125]ListValue_s:2:=$ProgramDescription_atxt{$Location_l}
							SAVE RECORD:C53([TableOfLists:125])
							UNLOAD RECORD:C212([TableOfLists:125])
						End if 
					End if 
					$FederalAid_txt:=ut_PRJRemoveExtraCharacters($FederalAid_txt; Char:C90(Double quote:K15:41))
					//ARRAY TEXT($FederalKey_atxt;0)
					//ARRAY TEXT($FederalDescription_atxt;0)
					$Key_txt:=Replace string:C233($FederalAid_txt; " "; "")
					
					If ($FederalAid_txt#"")
						
						$Location_l:=Find in array:C230($FederalKey_atxt; $Key_txt)
						If ($Location_l>0)
							
						Else 
							INSERT IN ARRAY:C227($FederalDescription_atxt; 0; 1)
							INSERT IN ARRAY:C227($FederalKey_atxt; 0; 1)
							$FederalDescription_atxt{1}:=$FederalAid_txt
							$FederalKey_atxt{1}:=$Key_txt
							$Location_l:=1
						End if 
						[PRJ_ProjectDetails:115]PRJ_FederalAid_s:25:=$FederalDescription_atxt{$Location_l}
						QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="FederalAid"; *)
						QUERY:C277([TableOfLists:125];  & ; [TableOfLists:125]ListValue_s:2=$FederalDescription_atxt{$Location_l})
						If ($Count_l=0)
							CREATE RECORD:C68([TableOfLists:125])
							[TableOfLists:125]ListName_s:1:="FederalAid"
							[TableOfLists:125]ListValue_s:2:=$FederalDescription_atxt{$Location_l}
							SAVE RECORD:C53([TableOfLists:125])
							UNLOAD RECORD:C212([TableOfLists:125])
						End if 
					End if 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					[PRJ_ProjectDetails:115]PRJ_BinUpdateRequest_s:26:=$BinUpdateRequest_txt
					If ($BeamCost_txt#"")
						$BeamCost_txt:=ut_PRJRemoveExtraCharacters($BeamCost_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
						If (ut_IsaRealNumber($BeamCost_txt))
							[PRJ_ProjectDetails:115]PRJ_BeamCost_r:27:=Round:C94(Num:C11($BeamCost_txt); 2)
						End if 
					End if 
					If ($BeamUnit_txt#"")
						$BeamUnit_txt:=ut_PRJRemoveExtraCharacters($BeamUnit_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
						If (ut_IsALongint($BeamUnit_txt))
							[PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28:=Num:C11($BeamUnit_txt)
						End if 
					End if 
					[PRJ_ProjectDetails:115]PRJ_BeamUnitType_s:36:=$UnitsBeam_txt
					$Item995_txt:=ut_PRJRemoveExtraCharacters($Item995_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
					//$Item995_txt:=Replace string($Item995_txt;;"")
					//$Item995_txt:=Replace string($Item995_txt;" ";"")
					//$Item995_txt:=Replace string($Item995_txt;",";"")
					//$Item995_txt:=Replace string($Item995_txt;Char(Double quote );"";100)
					If ($Item995_txt#"")
						If (ut_IsaRealNumber($Item995_txt))
							[PRJ_ProjectDetails:115]PRJ_Item995_r:29:=Num:C11($Item995_txt)
						Else 
							If (Length:C16($ImportErrors_atxt{1})>25000)
								INSERT IN ARRAY:C227($ImportErrors_atxt; 0; 1)
							End if 
							$ImportErrors_atxt{1}:=$ImportErrors_atxt{1}+"Error in Item995 "+$Bridge_txt+Char:C90(Tab:K15:37)+$Ewo_txt+Char:C90(Tab:K15:37)+$ProjectFile_txt+Char:C90(Tab:K15:37)+$LastAction_txt+Char:C90(Tab:K15:37)+$HydroReport_txt+Char:C90(Tab:K15:37)+$GeotechReport_txt+Char:C90(Tab:K15:37)+$TypeStudy_txt+Char:C90(Tab:K15:37)+$SketchPlan_txt+Char:C90(Tab:K15:37)+$SketchPlanReview_txt+Char:C90(Tab:K15:37)+$SketchPlanSigned_txt+Char:C90(Tab:K15:37)+$StructureReviewAll_txt+Char:C90(Tab:K15:37)+$StructureReview1ComToDE_txt+Char:C90(Tab:K15:37)+$StructureReview2_txt+Char:C90(Tab:K15:37)+$StructureReviewApproval_txt+Char:C90(Tab:K15:37)+$BDS_txt+Char:C90(Tab:K15:37)+$LumpSumBreakdown_txt+Char:C90(Tab:K15:37)+$Commments_txt+Char:C90(Tab:K15:37)+$Program_txt+Char:C90(Tab:K15:37)+$FederalAid_txt+Char:C90(Tab:K15:37)+$BinUpdateRequest_txt+Char:C90(Tab:K15:37)+$StructureReview3_txt+Char:C90(Tab:K15:37)+$BeamCost_txt+Char:C90(Tab:K15:37)+$BeamUnit_txt+Char:C90(Tab:K15:37)+$Item995_txt+Char:C90(Tab:K15:37)+$SketchPlanResponse_txt+Char:C90(Tab:K15:37)+$TypeStudyApprovedType_txt+Char:C90(Tab:K15:37)+$BinNumber_txt+Char:C90(Tab:K15:37)+$UnitsBeam_txt+Char:C90(Tab:K15:37)+$Tip_txt+Char:C90(Tab:K15:37)+$CompletionDate_txt+Char:C90(Tab:K15:37)+$Status_txt+Char:C90(Carriage return:K15:38)
						End if 
					End if 
					[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8:=Get_Town_Name(Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
					If (Records in selection:C76([Bridge MHD NBIS:1])=1)
						[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=[Bridge MHD NBIS:1]BIN:3
						
						CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
						[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
						[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
						[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
						[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
						SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
						UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
					End if 
					$NewBinNumber_txt:=Replace string:C233($BinNumber_txt; "("; "")
					$NewBinNumber_txt:=Replace string:C233($NewBinNumber_txt; ")"; "")
					$NewBinNumber_txt:=Replace string:C233($NewBinNumber_txt; " "; "")
					$NewBinNumber_txt:=Replace string:C233($NewBinNumber_txt; ","; "")
					$BinError_txt:=""
					
					Case of 
						: ($NewBinNumber_txt="")
						: (Length:C16($NewBinNumber_txt)#3)
							$BinError_txt:="Error in BIN length : "
							
						: ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34=$NewBinNumber_txt)
						: ($NewBinNumber_txt#"") & ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")
							$BinError_txt:="Bins do not match : "
							
						: ($NewBinNumber_txt#"") & ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
							QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$NewBinNumber_txt)
							Case of 
								: (Records in selection:C76([Bridge MHD NBIS:1])=1) & ([Bridge MHD NBIS:1]BDEPT:1=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
									[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=$NewBinNumber_txt
									CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
									[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
									[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
									[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
									[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
									SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
									UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
								: (Records in selection:C76([Bridge MHD NBIS:1])=0)
									$BinError_txt:="No Bridge Record : "
									
								: (Records in selection:C76([Bridge MHD NBIS:1])>1)
									$BinError_txt:="More than one bridge record : "
								: ([Bridge MHD NBIS:1]BDEPT:1#Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
									$BinError_txt:="BDEPT's do not match : "
									
								Else 
									$BinError_txt:="Other Bin Error: "
							End case 
							
						Else 
							$BinError_txt:="Error in BIN : "
							
					End case 
					If ($BinError_txt#"")
						If (Length:C16($Skipped_atxt{1})>25000)
							INSERT IN ARRAY:C227($Skipped_atxt; 0; 1)
						End if 
						$Skipped_atxt{1}:=$Skipped_atxt{1}+$BinError_txt+$Bridge_txt+Char:C90(Tab:K15:37)+$Ewo_txt+Char:C90(Tab:K15:37)+$ProjectFile_txt+Char:C90(Tab:K15:37)+$LastAction_txt+Char:C90(Tab:K15:37)+$HydroReport_txt+Char:C90(Tab:K15:37)+$GeotechReport_txt+Char:C90(Tab:K15:37)+$TypeStudy_txt+Char:C90(Tab:K15:37)+$SketchPlan_txt+Char:C90(Tab:K15:37)+$SketchPlanReview_txt+Char:C90(Tab:K15:37)+$SketchPlanSigned_txt+Char:C90(Tab:K15:37)+$StructureReviewAll_txt+Char:C90(Tab:K15:37)+$StructureReview1ComToDE_txt+Char:C90(Tab:K15:37)+$StructureReview2_txt+Char:C90(Tab:K15:37)+$StructureReviewApproval_txt+Char:C90(Tab:K15:37)+$BDS_txt+Char:C90(Tab:K15:37)+$LumpSumBreakdown_txt+Char:C90(Tab:K15:37)+$Commments_txt+Char:C90(Tab:K15:37)+$Program_txt+Char:C90(Tab:K15:37)+$FederalAid_txt+Char:C90(Tab:K15:37)+$BinUpdateRequest_txt+Char:C90(Tab:K15:37)+$StructureReview3_txt+Char:C90(Tab:K15:37)+$BeamCost_txt+Char:C90(Tab:K15:37)+$BeamUnit_txt+Char:C90(Tab:K15:37)+$Item995_txt+Char:C90(Tab:K15:37)+$SketchPlanResponse_txt+Char:C90(Tab:K15:37)+$TypeStudyApprovedType_txt+Char:C90(Tab:K15:37)+$BinNumber_txt+Char:C90(Tab:K15:37)+$UnitsBeam_txt+Char:C90(Tab:K15:37)+$Tip_txt+Char:C90(Tab:K15:37)+$CompletionDate_txt+Char:C90(Tab:K15:37)+$Status_txt+Char:C90(Carriage return:K15:38)
					End if 
					//
					[PRJ_ProjectDetails:115]PRJ_Completion_d:37:=ut_PRJ_SetDate($CompletionDate_txt)
					
					[PRJ_ProjectDetails:115]PRJ_Status_s:35:=$Status_txt
					SAVE RECORD:C53([PRJ_ProjectDetails:115])
					UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
					UNLOAD RECORD:C212([PRJ_ProjectFile:117])
					$SQLDocument_tm:=Append document:C265(DocmentPath_txt)
					SEND PACKET:C103($SQLDocument_tm; "Created new record for "+$Bridge_txt+<>sCR)
					CLOSE DOCUMENT:C267($SQLDocument_tm)
					
				Else 
					
					If ($DoUpdate_b)
						//OK we are now doing updates of certain elements passed in
						C_BLOB:C604($Params_x)
						VARIABLE TO BLOB:C532($CurrentStructural_l; $Params_x; *)
						VARIABLE TO BLOB:C532($LastAction_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($LumpSumBreakdown_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($Commments_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BeamCost_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BeamUnit_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($UnitsBeam_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($Item995_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($Status_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BDS_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BinUpdateRequest_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($CompletionDate_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($HydroReport_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($GeotechReport_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($TypeStudy_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($TypeStudyApprovedType_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlan_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlanReview_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlanSigned_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlanResponse_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReviewAll_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReview1ComToDE_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReviewApproval_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReview2_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReview3_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($PRJ_utReviewerID_L; $Params_x; *)
						
						//VARIABLE TO BLOB(;$Params_x;*)
						//VARIABLE TO BLOB(;$Params_x;*)
						
						//VARIABLE TO BLOB(;$Params_x;*)
						
						//VARIABLE TO BLOB(;$Params_x;*)
						If (False:C215)
							//$ErrorDescription_txt:=ut_PRJUpdateFromImport ($CurrentStructural_l;$LastAction_txt;$LumpSumBreakdown_txt;$Commments_txt;$BeamCost_txt;$BeamUnit_txt;$UnitsBeam_txt;$Item995_txt;$Status_txt)
						Else 
							$ErrorDescription_txt:=ut_PRJUpdateFromImport($Params_x)
						End if 
						SET BLOB SIZE:C606($Params_x; 0)
						If ($ErrorDescription_txt#"")
							If (Length:C16($ImportErrors_atxt{1})>25000)
								INSERT IN ARRAY:C227($ImportErrors_atxt; 0; 1)
							End if 
							$ImportErrors_atxt{1}:=$ImportErrors_atxt{1}+"Error in Item995 "+$Bridge_txt+Char:C90(Tab:K15:37)+$Ewo_txt+Char:C90(Tab:K15:37)+$ProjectFile_txt+Char:C90(Tab:K15:37)+$LastAction_txt+Char:C90(Tab:K15:37)+$HydroReport_txt+Char:C90(Tab:K15:37)+$GeotechReport_txt+Char:C90(Tab:K15:37)+$TypeStudy_txt+Char:C90(Tab:K15:37)+$SketchPlan_txt+Char:C90(Tab:K15:37)+$SketchPlanReview_txt+Char:C90(Tab:K15:37)+$SketchPlanSigned_txt+Char:C90(Tab:K15:37)+$StructureReviewAll_txt+Char:C90(Tab:K15:37)+$StructureReview1ComToDE_txt+Char:C90(Tab:K15:37)+$StructureReview2_txt+Char:C90(Tab:K15:37)+$StructureReviewApproval_txt+Char:C90(Tab:K15:37)+$BDS_txt+Char:C90(Tab:K15:37)+$LumpSumBreakdown_txt+Char:C90(Tab:K15:37)+$Commments_txt+Char:C90(Tab:K15:37)+$Program_txt+Char:C90(Tab:K15:37)+$FederalAid_txt+Char:C90(Tab:K15:37)+$BinUpdateRequest_txt+Char:C90(Tab:K15:37)+$StructureReview3_txt+Char:C90(Tab:K15:37)+$BeamCost_txt+Char:C90(Tab:K15:37)+$BeamUnit_txt+Char:C90(Tab:K15:37)+$Item995_txt+Char:C90(Tab:K15:37)+$SketchPlanResponse_txt+Char:C90(Tab:K15:37)+$TypeStudyApprovedType_txt+Char:C90(Tab:K15:37)+$BinNumber_txt+Char:C90(Tab:K15:37)+$UnitsBeam_txt+Char:C90(Tab:K15:37)+$Tip_txt+Char:C90(Tab:K15:37)+$CompletionDate_txt+Char:C90(Tab:K15:37)+$Status_txt+Char:C90(Carriage return:K15:38)
						End if 
						
					End if 
				End if 
				//End if 
			Else 
				QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7=$Bridge_txt)  //******
				C_BOOLEAN:C305($DoNewRec_b; $DoUpdate_b)
				$DoNewRec_b:=False:C215
				$DoUpdate_b:=False:C215
				If (Records in selection:C76([PRJ_ProjectDetails:115])=0)
					//New rec
					$DoNewRec_b:=True:C214
				Else 
					If (Records in selection:C76([PRJ_ProjectDetails:115])=1)
						//Single match
						//See if the projectfile number needs update
						C_LONGINT:C283($NewProjFileNo_L; $CurrProjFileNo_L)
						Case of 
							: ($ProjectFile_txt="Ch@")
								$NewProjFileNo_L:=0
							: ($ProjectFile_txt="Di@")
								$NewProjFileNo_L:=0
							Else 
								$NewProjFileNo_L:=Num:C11($ProjectFile_txt)
						End case 
						$DoUpdate_b:=True:C214
						If ($NewProjFileNo_L=0)
							//nothing
						Else 
							QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
							If ([PRJ_ProjectFile:117]PF_FileNumber_l:3=$NewProjFileNo_L)
								//Sane num - no update
							Else 
								$SQLDocument_tm:=Append document:C265(DocmentPath_txt)
								If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
									$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
								Else 
									$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
								End if 
								If ([PRJ_ProjectFile:117]PF_FileNumber_l:3<=0)
									QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=$NewProjFileNo_L)
									If (Records in selection:C76([PRJ_ProjectFile:117])=1)
										//found one = assign it
										If (ut_LoadRecord(->[PRJ_ProjectDetails:115]))
											[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
											$Changes_txt:=$Changes_txt+" Changed File number to "+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
											SAVE RECORD:C53([PRJ_ProjectDetails:115])
										Else 
											$Changes_txt:=$Changes_txt+" Record locked - Could not change File number to "+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
										End if 
									Else 
										$Changes_txt:=$Changes_txt+" Input File number not found :"+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
									End if 
									
								Else 
									//non-matching project file number - no update
									$DoUpdate_b:=False:C215
									$Changes_txt:=$Changes_txt+" Would not update record - file numbers don't match (Input: "+$ProjectFile_txt+" vs in data:"+String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)+Char:C90(Carriage return:K15:38)
								End if 
								SEND PACKET:C103($SQLDocument_tm; $Changes_txt)
								CLOSE DOCUMENT:C267($SQLDocument_tm)
							End if 
						End if 
					Else 
						QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=Num:C11($ProjectFile_txt))
						If (Records in selection:C76([PRJ_ProjectDetails:115])=1)
							//found match with file number
						Else 
							//could not match file number - set message
							$DoUpdate_b:=False:C215
							$SQLDocument_tm:=Append document:C265(DocmentPath_txt)
							If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
								$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
							Else 
								$Changes_txt:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
							End if 
							$Changes_txt:=$Changes_txt+" Multiple records - could not match file number "+$ProjectFile_txt+Char:C90(Carriage return:K15:38)
							SEND PACKET:C103($SQLDocument_tm; $Changes_txt)
							CLOSE DOCUMENT:C267($SQLDocument_tm)
						End if 
					End if 
				End if 
				
				If ($DoNewRec_b)
					CREATE RECORD:C68([PRJ_ProjectDetails:115])
					Inc_Sequence("PRJ_ProjectID_l"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
					[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7:=$Bridge_txt
					[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31:=$Ewo_txt
					$ProjectFile_txt:=ut_PRJRemoveExtraCharacters($ProjectFile_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
					If (ut_IsALongint($ProjectFile_txt))
						QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=Num:C11($ProjectFile_txt))
						If (Records in selection:C76([PRJ_ProjectFile:117])=0)
							CREATE RECORD:C68([PRJ_ProjectFile:117])
							Inc_Sequence("PF_FileID_l"; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
							[PRJ_ProjectFile:117]PF_FileNumber_l:3:=Num:C11($ProjectFile_txt)
							SAVE RECORD:C53([PRJ_ProjectFile:117])
						End if 
						[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
					End if 
					[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39:=$CurrentStructural_l
					[PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9:=$LastAction_txt
					If ($HydroReport_txt#"")
						$HydroReport_txt:=ut_PRJRemoveExtraCharacters($HydroReport_txt; Char:C90(Double quote:K15:41))
						ut_PRJImportCreateHydraulic($HydroReport_txt; "Hydraulic")
					End if 
					If ($GeotechReport_txt#"")
						$GeotechReport_txt:=ut_PRJRemoveExtraCharacters($GeotechReport_txt; Char:C90(Double quote:K15:41))
						ut_PRJImportCreateGeotech($GeotechReport_txt; "GEOTech")
					End if 
					$TypeStudy_txt:=ut_PRJRemoveExtraCharacters($TypeStudy_txt; Char:C90(Double quote:K15:41))
					$TypeStudyApprovedType_txt:=ut_PRJRemoveExtraCharacters($TypeStudyApprovedType_txt; Char:C90(Double quote:K15:41))
					
					If ($TypeStudy_txt="")
					Else 
						ut_PRJCreateTypeStudy($TypeStudy_txt; $TypeStudyApprovedType_txt; $PRJ_utReviewerID_L)
					End if 
					$SketchPlan_txt:=ut_PRJRemoveExtraCharacters($SketchPlan_txt; Char:C90(Double quote:K15:41))
					$SketchPlanReview_txt:=ut_PRJRemoveExtraCharacters($SketchPlanReview_txt; Char:C90(Double quote:K15:41))
					$SketchPlanSigned_txt:=ut_PRJRemoveExtraCharacters($SketchPlanSigned_txt; Char:C90(Double quote:K15:41))
					$SketchPlanResponse_txt:=ut_PRJRemoveExtraCharacters($SketchPlanResponse_txt; Char:C90(Double quote:K15:41))
					
					If ($SketchPlan_txt="") & ($SketchPlanReview_txt="") & ($SketchPlanSigned_txt="") & ($SketchPlanResponse_txt="")
						
					Else 
						ut_PRJCreateSketchPlan($SketchPlan_txt; $SketchPlanReview_txt; $SketchPlanSigned_txt; $SketchPlanResponse_txt; $PRJ_utReviewerID_L)
					End if 
					C_LONGINT:C283($NumberOfReviews_l)
					$NumberOfReviews_l:=0
					$StructureReviewAll_txt:=ut_PRJRemoveExtraCharacters($StructureReviewAll_txt; Char:C90(Double quote:K15:41))
					$StructureReview1ComToDE_txt:=ut_PRJRemoveExtraCharacters($StructureReview1ComToDE_txt; Char:C90(Double quote:K15:41))
					$StructureReviewApproval_txt:=ut_PRJRemoveExtraCharacters($StructureReviewApproval_txt; Char:C90(Double quote:K15:41))
					
					If ($StructureReviewAll_txt="") & ($StructureReview1ComToDE_txt="") & ($StructureReviewApproval_txt="")
						
					Else 
						$NumberOfReviews_l:=1
						ut_PRJCreateStructuralReview(1; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview1ComToDE_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
					End if 
					$StructureReview2_txt:=ut_PRJRemoveExtraCharacters($StructureReview2_txt; Char:C90(Double quote:K15:41))
					
					If ($StructureReview2_txt="")
					Else 
						$NumberOfReviews_l:=$NumberOfReviews_l+1
						ut_PRJCreateStructuralReview(2; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview2_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
					End if 
					$StructureReview3_txt:=ut_PRJRemoveExtraCharacters($StructureReview3_txt; Char:C90(Double quote:K15:41))
					
					If ($StructureReview3_txt="")
					Else 
						$NumberOfReviews_l:=$NumberOfReviews_l+1
						ut_PRJCreateStructuralReview(3; $NumberOfReviews_l; $StructureReviewAll_txt; $StructureReview3_txt; $StructureReviewApproval_txt; $PRJ_utReviewerID_L)
					End if 
					[PRJ_ProjectDetails:115]PRJ_Comments_txt:10:=$Commments_txt
					[PRJ_ProjectDetails:115]PRJ_BridgeDataSheetComplete_s:13:=$BDS_txt
					If ($LumpSumBreakdown_txt#"")
						[PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22:=ut_PRJ_SetDate($LumpSumBreakdown_txt)
					End if 
					
					SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
					
					$Program_txt:=ut_PRJRemoveExtraCharacters($Program_txt; Char:C90(Double quote:K15:41))
					$Key_txt:=Replace string:C233($Program_txt; " "; "")
					//ARRAY TEXT($ProgramKey_atxt;0)
					//ARRAY TEXT($ProgramDescription_atxt;0)
					C_LONGINT:C283($Location_l)
					If ($Program_txt#"")
						$Location_l:=Find in array:C230($ProgramKey_atxt; $Key_txt)
						If ($Location_l>0)
							
						Else 
							INSERT IN ARRAY:C227($ProgramDescription_atxt; 0; 1)
							INSERT IN ARRAY:C227($ProgramKey_atxt; 0; 1)
							$ProgramDescription_atxt{1}:=$Program_txt
							$ProgramKey_atxt{1}:=$Key_txt
							$Location_l:=1
						End if 
						[PRJ_ProjectDetails:115]PRJ_Program_s:23:=$ProgramDescription_atxt{$Location_l}
						QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="Program"; *)
						QUERY:C277([TableOfLists:125];  & ; [TableOfLists:125]ListValue_s:2=$ProgramDescription_atxt{$Location_l})
						If ($Count_l=0)
							CREATE RECORD:C68([TableOfLists:125])
							[TableOfLists:125]ListName_s:1:="Program"
							[TableOfLists:125]ListValue_s:2:=$ProgramDescription_atxt{$Location_l}
							SAVE RECORD:C53([TableOfLists:125])
							UNLOAD RECORD:C212([TableOfLists:125])
						End if 
					End if 
					$FederalAid_txt:=ut_PRJRemoveExtraCharacters($FederalAid_txt; Char:C90(Double quote:K15:41))
					//ARRAY TEXT($FederalKey_atxt;0)
					//ARRAY TEXT($FederalDescription_atxt;0)
					$Key_txt:=Replace string:C233($FederalAid_txt; " "; "")
					
					If ($FederalAid_txt#"")
						
						$Location_l:=Find in array:C230($FederalKey_atxt; $Key_txt)
						If ($Location_l>0)
							
						Else 
							INSERT IN ARRAY:C227($FederalDescription_atxt; 0; 1)
							INSERT IN ARRAY:C227($FederalKey_atxt; 0; 1)
							$FederalDescription_atxt{1}:=$FederalAid_txt
							$FederalKey_atxt{1}:=$Key_txt
							$Location_l:=1
						End if 
						[PRJ_ProjectDetails:115]PRJ_FederalAid_s:25:=$FederalDescription_atxt{$Location_l}
						QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="FederalAid"; *)
						QUERY:C277([TableOfLists:125];  & ; [TableOfLists:125]ListValue_s:2=$FederalDescription_atxt{$Location_l})
						If ($Count_l=0)
							CREATE RECORD:C68([TableOfLists:125])
							[TableOfLists:125]ListName_s:1:="FederalAid"
							[TableOfLists:125]ListValue_s:2:=$FederalDescription_atxt{$Location_l}
							SAVE RECORD:C53([TableOfLists:125])
							UNLOAD RECORD:C212([TableOfLists:125])
						End if 
					End if 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					[PRJ_ProjectDetails:115]PRJ_BinUpdateRequest_s:26:=$BinUpdateRequest_txt
					If ($BeamCost_txt#"")
						$BeamCost_txt:=ut_PRJRemoveExtraCharacters($BeamCost_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
						If (ut_IsaRealNumber($BeamCost_txt))
							[PRJ_ProjectDetails:115]PRJ_BeamCost_r:27:=Round:C94(Num:C11($BeamCost_txt); 2)
						End if 
					End if 
					If ($BeamUnit_txt#"")
						$BeamUnit_txt:=ut_PRJRemoveExtraCharacters($BeamUnit_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
						If (ut_IsALongint($BeamUnit_txt))
							[PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28:=Num:C11($BeamUnit_txt)
						End if 
					End if 
					[PRJ_ProjectDetails:115]PRJ_BeamUnitType_s:36:=$UnitsBeam_txt
					$Item995_txt:=ut_PRJRemoveExtraCharacters($Item995_txt; "$"; " "; ","; Char:C90(Double quote:K15:41))
					//$Item995_txt:=Replace string($Item995_txt;;"")
					//$Item995_txt:=Replace string($Item995_txt;" ";"")
					//$Item995_txt:=Replace string($Item995_txt;",";"")
					//$Item995_txt:=Replace string($Item995_txt;Char(Double quote );"";100)
					If ($Item995_txt#"")
						If (ut_IsaRealNumber($Item995_txt))
							[PRJ_ProjectDetails:115]PRJ_Item995_r:29:=Num:C11($Item995_txt)
						Else 
							If (Length:C16($ImportErrors_atxt{1})>25000)
								INSERT IN ARRAY:C227($ImportErrors_atxt; 0; 1)
							End if 
							$ImportErrors_atxt{1}:=$ImportErrors_atxt{1}+"Error in Item995 "+$Bridge_txt+Char:C90(Tab:K15:37)+$Ewo_txt+Char:C90(Tab:K15:37)+$ProjectFile_txt+Char:C90(Tab:K15:37)+$LastAction_txt+Char:C90(Tab:K15:37)+$HydroReport_txt+Char:C90(Tab:K15:37)+$GeotechReport_txt+Char:C90(Tab:K15:37)+$TypeStudy_txt+Char:C90(Tab:K15:37)+$SketchPlan_txt+Char:C90(Tab:K15:37)+$SketchPlanReview_txt+Char:C90(Tab:K15:37)+$SketchPlanSigned_txt+Char:C90(Tab:K15:37)+$StructureReviewAll_txt+Char:C90(Tab:K15:37)+$StructureReview1ComToDE_txt+Char:C90(Tab:K15:37)+$StructureReview2_txt+Char:C90(Tab:K15:37)+$StructureReviewApproval_txt+Char:C90(Tab:K15:37)+$BDS_txt+Char:C90(Tab:K15:37)+$LumpSumBreakdown_txt+Char:C90(Tab:K15:37)+$Commments_txt+Char:C90(Tab:K15:37)+$Program_txt+Char:C90(Tab:K15:37)+$FederalAid_txt+Char:C90(Tab:K15:37)+$BinUpdateRequest_txt+Char:C90(Tab:K15:37)+$StructureReview3_txt+Char:C90(Tab:K15:37)+$BeamCost_txt+Char:C90(Tab:K15:37)+$BeamUnit_txt+Char:C90(Tab:K15:37)+$Item995_txt+Char:C90(Tab:K15:37)+$SketchPlanResponse_txt+Char:C90(Tab:K15:37)+$TypeStudyApprovedType_txt+Char:C90(Tab:K15:37)+$BinNumber_txt+Char:C90(Tab:K15:37)+$UnitsBeam_txt+Char:C90(Tab:K15:37)+$Tip_txt+Char:C90(Tab:K15:37)+$CompletionDate_txt+Char:C90(Tab:K15:37)+$Status_txt+Char:C90(Carriage return:K15:38)
						End if 
					End if 
					[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8:=Get_Town_Name(Substring:C12([PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; 1; 6))
					If (Records in selection:C76([Bridge MHD NBIS:1])=1)
						[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=[Bridge MHD NBIS:1]BIN:3
						
						CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
						[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
						[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
						[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
						[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
						SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
						UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
					End if 
					$NewBinNumber_txt:=Replace string:C233($BinNumber_txt; "("; "")
					$NewBinNumber_txt:=Replace string:C233($NewBinNumber_txt; ")"; "")
					$NewBinNumber_txt:=Replace string:C233($NewBinNumber_txt; " "; "")
					$NewBinNumber_txt:=Replace string:C233($NewBinNumber_txt; ","; "")
					$BinError_txt:=""
					
					Case of 
						: ($NewBinNumber_txt="")
						: (Length:C16($NewBinNumber_txt)#3)
							$BinError_txt:="Error in BIN length : "
							
						: ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34=$NewBinNumber_txt)
						: ($NewBinNumber_txt#"") & ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")
							$BinError_txt:="Bins do not match : "
							
						: ($NewBinNumber_txt#"") & ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
							QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$NewBinNumber_txt)
							Case of 
								: (Records in selection:C76([Bridge MHD NBIS:1])=1) & ([Bridge MHD NBIS:1]BDEPT:1=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
									[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=$NewBinNumber_txt
									CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
									[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
									[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
									[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=False:C215
									[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
									SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
									UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
								: (Records in selection:C76([Bridge MHD NBIS:1])=0)
									$BinError_txt:="No Bridge Record : "
									
								: (Records in selection:C76([Bridge MHD NBIS:1])>1)
									$BinError_txt:="More than one bridge record : "
								: ([Bridge MHD NBIS:1]BDEPT:1#Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
									$BinError_txt:="BDEPT's do not match : "
									
								Else 
									$BinError_txt:="Other Bin Error: "
							End case 
							
						Else 
							$BinError_txt:="Error in BIN : "
							
					End case 
					If ($BinError_txt#"")
						If (Length:C16($Skipped_atxt{1})>25000)
							INSERT IN ARRAY:C227($Skipped_atxt; 0; 1)
						End if 
						$Skipped_atxt{1}:=$Skipped_atxt{1}+$BinError_txt+$Bridge_txt+Char:C90(Tab:K15:37)+$Ewo_txt+Char:C90(Tab:K15:37)+$ProjectFile_txt+Char:C90(Tab:K15:37)+$LastAction_txt+Char:C90(Tab:K15:37)+$HydroReport_txt+Char:C90(Tab:K15:37)+$GeotechReport_txt+Char:C90(Tab:K15:37)+$TypeStudy_txt+Char:C90(Tab:K15:37)+$SketchPlan_txt+Char:C90(Tab:K15:37)+$SketchPlanReview_txt+Char:C90(Tab:K15:37)+$SketchPlanSigned_txt+Char:C90(Tab:K15:37)+$StructureReviewAll_txt+Char:C90(Tab:K15:37)+$StructureReview1ComToDE_txt+Char:C90(Tab:K15:37)+$StructureReview2_txt+Char:C90(Tab:K15:37)+$StructureReviewApproval_txt+Char:C90(Tab:K15:37)+$BDS_txt+Char:C90(Tab:K15:37)+$LumpSumBreakdown_txt+Char:C90(Tab:K15:37)+$Commments_txt+Char:C90(Tab:K15:37)+$Program_txt+Char:C90(Tab:K15:37)+$FederalAid_txt+Char:C90(Tab:K15:37)+$BinUpdateRequest_txt+Char:C90(Tab:K15:37)+$StructureReview3_txt+Char:C90(Tab:K15:37)+$BeamCost_txt+Char:C90(Tab:K15:37)+$BeamUnit_txt+Char:C90(Tab:K15:37)+$Item995_txt+Char:C90(Tab:K15:37)+$SketchPlanResponse_txt+Char:C90(Tab:K15:37)+$TypeStudyApprovedType_txt+Char:C90(Tab:K15:37)+$BinNumber_txt+Char:C90(Tab:K15:37)+$UnitsBeam_txt+Char:C90(Tab:K15:37)+$Tip_txt+Char:C90(Tab:K15:37)+$CompletionDate_txt+Char:C90(Tab:K15:37)+$Status_txt+Char:C90(Carriage return:K15:38)
					End if 
					//
					[PRJ_ProjectDetails:115]PRJ_Completion_d:37:=ut_PRJ_SetDate($CompletionDate_txt)
					[PRJ_ProjectDetails:115]PRJ_NonBridgeNotes_txt:40:=$RoadWayOver_txt
					
					[PRJ_ProjectDetails:115]PRJ_Status_s:35:=$Status_txt
					SAVE RECORD:C53([PRJ_ProjectDetails:115])
					UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
					UNLOAD RECORD:C212([PRJ_ProjectFile:117])
					If (Length:C16($Skipped_atxt{1})>25000)
						INSERT IN ARRAY:C227($Skipped_atxt; 0; 1)
					End if 
					$Skipped_atxt{1}:=$Skipped_atxt{1}+"NON Bridge added: "+$Bridge_txt+Char:C90(Tab:K15:37)+$Ewo_txt+Char:C90(Tab:K15:37)+$ProjectFile_txt+Char:C90(Tab:K15:37)+$LastAction_txt+Char:C90(Tab:K15:37)+$HydroReport_txt+Char:C90(Tab:K15:37)+$GeotechReport_txt+Char:C90(Tab:K15:37)+$TypeStudy_txt+Char:C90(Tab:K15:37)+$SketchPlan_txt+Char:C90(Tab:K15:37)+$SketchPlanReview_txt+Char:C90(Tab:K15:37)+$SketchPlanSigned_txt+Char:C90(Tab:K15:37)+$StructureReviewAll_txt+Char:C90(Tab:K15:37)+$StructureReview1ComToDE_txt+Char:C90(Tab:K15:37)+$StructureReview2_txt+Char:C90(Tab:K15:37)+$StructureReviewApproval_txt+Char:C90(Tab:K15:37)+$BDS_txt+Char:C90(Tab:K15:37)+$LumpSumBreakdown_txt+Char:C90(Tab:K15:37)+$Commments_txt+Char:C90(Tab:K15:37)+$Program_txt+Char:C90(Tab:K15:37)+$FederalAid_txt+Char:C90(Tab:K15:37)+$BinUpdateRequest_txt+Char:C90(Tab:K15:37)+$StructureReview3_txt+Char:C90(Tab:K15:37)+$BeamCost_txt+Char:C90(Tab:K15:37)+$BeamUnit_txt+Char:C90(Tab:K15:37)+$Item995_txt+Char:C90(Tab:K15:37)+$SketchPlanResponse_txt+Char:C90(Tab:K15:37)+$TypeStudyApprovedType_txt+Char:C90(Tab:K15:37)+$BinNumber_txt+Char:C90(Tab:K15:37)+$UnitsBeam_txt+Char:C90(Tab:K15:37)+$Tip_txt+Char:C90(Tab:K15:37)+$CompletionDate_txt+Char:C90(Tab:K15:37)+$Status_txt+Char:C90(Carriage return:K15:38)
					
				Else 
					If ($DoUpdate_b)
						//OK we are now doing updates of certain elements passed in
						C_BLOB:C604($Params_x)
						VARIABLE TO BLOB:C532($CurrentStructural_l; $Params_x; *)
						VARIABLE TO BLOB:C532($LastAction_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($LumpSumBreakdown_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($Commments_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BeamCost_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BeamUnit_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($UnitsBeam_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($Item995_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($Status_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BDS_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($BinUpdateRequest_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($CompletionDate_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($HydroReport_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($GeotechReport_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($TypeStudy_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($TypeStudyApprovedType_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlan_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlanReview_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlanSigned_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($SketchPlanResponse_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReviewAll_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReview1ComToDE_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReviewApproval_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReview2_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($StructureReview3_txt; $Params_x; *)
						VARIABLE TO BLOB:C532($PRJ_utReviewerID_L; $Params_x; *)
						
						$ErrorDescription_txt:=ut_PRJUpdateFromImport($Params_x)
						If ($ErrorDescription_txt#"")
							If (Length:C16($ImportErrors_atxt{1})>25000)
								INSERT IN ARRAY:C227($ImportErrors_atxt; 0; 1)
							End if 
							$ImportErrors_atxt{1}:=$ImportErrors_atxt{1}+"Error in Item995 "+$Bridge_txt+Char:C90(Tab:K15:37)+$Ewo_txt+Char:C90(Tab:K15:37)+$ProjectFile_txt+Char:C90(Tab:K15:37)+$LastAction_txt+Char:C90(Tab:K15:37)+$HydroReport_txt+Char:C90(Tab:K15:37)+$GeotechReport_txt+Char:C90(Tab:K15:37)+$TypeStudy_txt+Char:C90(Tab:K15:37)+$SketchPlan_txt+Char:C90(Tab:K15:37)+$SketchPlanReview_txt+Char:C90(Tab:K15:37)+$SketchPlanSigned_txt+Char:C90(Tab:K15:37)+$StructureReviewAll_txt+Char:C90(Tab:K15:37)+$StructureReview1ComToDE_txt+Char:C90(Tab:K15:37)+$StructureReview2_txt+Char:C90(Tab:K15:37)+$StructureReviewApproval_txt+Char:C90(Tab:K15:37)+$BDS_txt+Char:C90(Tab:K15:37)+$LumpSumBreakdown_txt+Char:C90(Tab:K15:37)+$Commments_txt+Char:C90(Tab:K15:37)+$Program_txt+Char:C90(Tab:K15:37)+$FederalAid_txt+Char:C90(Tab:K15:37)+$BinUpdateRequest_txt+Char:C90(Tab:K15:37)+$StructureReview3_txt+Char:C90(Tab:K15:37)+$BeamCost_txt+Char:C90(Tab:K15:37)+$BeamUnit_txt+Char:C90(Tab:K15:37)+$Item995_txt+Char:C90(Tab:K15:37)+$SketchPlanResponse_txt+Char:C90(Tab:K15:37)+$TypeStudyApprovedType_txt+Char:C90(Tab:K15:37)+$BinNumber_txt+Char:C90(Tab:K15:37)+$UnitsBeam_txt+Char:C90(Tab:K15:37)+$Tip_txt+Char:C90(Tab:K15:37)+$CompletionDate_txt+Char:C90(Tab:K15:37)+$Status_txt+Char:C90(Carriage return:K15:38)
						End if 
						
					End if 
				End if 
			End if 
			//End if 
		Else 
			$Done_b:=True:C214
		End if 
		
	Until ($Done_b)
	
	CLOSE DOCUMENT:C267($Doc)
	CLOSE WINDOW:C154
	C_BOOLEAN:C305($CreateDocument_b)
	$CreateDocument_b:=False:C215
	If (Length:C16($Skipped_atxt{1})>0) | (Size of array:C274($Skipped_atxt)>1)
		$CreateDocument_b:=True:C214
	End if 
	If (Length:C16($ImportErrors_atxt{1})>0) | (Size of array:C274($ImportErrors_atxt)>1)
		$CreateDocument_b:=True:C214
	End if 
	If ($CreateDocument_b)
		C_LONGINT:C283($Loop_l)
		ALERT:C41("Create document where Error messages will be stored!")  //*******
		$doc:=Create document:C266(""; "TEXT")
		SEND PACKET:C103($Doc; $Header_txt+Char:C90(Carriage return:K15:38))
		For ($Loop_l; Size of array:C274($Skipped_atxt); 1; -1)
			SEND PACKET:C103($Doc; $Skipped_atxt{$Loop_l})
		End for 
		
		For ($Loop_l; Size of array:C274($ImportErrors_atxt); 1; -1)
			SEND PACKET:C103($Doc; $ImportErrors_atxt{$Loop_l})
		End for 
		CLOSE DOCUMENT:C267($Doc)
	End if 
Else 
	ALERT:C41("Import Canceled")
End if 
//End ut_PRJImportData