//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/06/09, 16:23:14
	// ----------------------------------------------------
	// Method: SCPOA_Variables
	// Description
	// Perform various tasks for Scour POA variables. 
	// To add a variable to be stored in the SCPOA blob
	// Add declaration at bottom of "INIT" section
	// Add "Clear" statement at "CLEAR" section
	// Add BLOB TO VARIABLE at bottom of "LOAD"
	// Add VARIABLE TO BLOB at bottom of "SAVE"
	// 
	// Parameters
	// $1 : $Action_txt : one of :
	//  `  `"INIT" 
	//  `  `"LOAD"
	//  `  `"CLEAR"
	//  `  `"SETUP"
	//  `  `"SAVE"
	//  `  `"PRINTPG1"
	//  `  `"DETOURBRIDGES"
	//  `  `"CLEARDETOURBRIDGES"
	//  `  `"PHOTOS"
	//  `  `"CLEARPHOTOS"
	//  `  `"REVIEWSCREENINIT"
	//  `  `"REVIEWSCREENLOAD"
	//  `  `"OLDNEWVERSION"
	//  `  `"SETVERSION"
	//  `  `"LOADFROMBLOB"
	
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(12/10/09 09:08:21)
	Mods_2009_12
	//Changes/Additions for new version of POA
	// Modified by: costasmanousakis-(Designer)-(12/18/09 16:50:27)
	Mods_2009_12
	//List of consultants down to 2
	// Modified by: costasmanousakis-(Designer)-(4/24/10 12:02:52)
	Mods_2010_04
	//  `Enable Scour log changes
	//  `Added missing var SCPOA_PostFlood_L in store and load
	// Modified by: costasmanousakis-(Designer)-(6/4/10 15:23:41)
	Mods_2010_06
	//  `Changed "Clough, Harbour & Associates LLP" to "Clough, Harbour & Associates" to match the limit
	//  `in the Personnel table of Employer
	// Modified by: costasmanousakis-(Designer)-(8/2/10 16:25:06)
	Mods_2010_08
	//Replaced the second occurance of SCPOA_WatchUW_txt  with SCPOA_InstLoc_txt
	// Modified by: costasmanousakis-(Designer)-(10/13/10 12:09:40)
	Mods_2010_10
	//  `Added variables SCPOA_Item91_L SCPOA_UWInspFreq_L for the summary page addition of Inspection frequency
	// Modified by: costasmanousakis-(Designer)-(1/14/11 11:42:20)
	Mods_2011_01
	//  `Added variables  SCPOA_BrgOpenPendDive_L for the Bridge reopenning plan
	
	//Added Vars
	//SCPOA_ImplAdDate_txt
	// Modified by: costasmanousakis-(Designer)-(3/23/11 17:17:12)
	Mods_2011_05
	//SCPOA Mod 2
	// Modified by: costasmanousakis-(Designer)-(6/8/11 15:34:10)
	Mods_2011_06
	//  `Added / Enabled personnel group SCPOA_MultipleView to be able to see and use both the old and new version of the POA
	//  `Implemented the use of OLDNEWVERSION and SETVERSION method parameter
	//  `Modified the page navigation drop down SectionSCPOASelect_atxt and SCPOA_SectionPage_aL to reflect that 
	// Modified by: costasmanousakis-(Designer)-(6/13/11 14:00:45)
	Mods_2011_06
	//  `Created new var SCPOA_MultipleVer_b - used to control the input form. Now default input screens are the new version,
	//  `Users in Multiview group can have both old and new versions active.
	//  `Printing is controlled by the SCPOA_OldVersion_b. (True prints old, false prints New). Now the default for
	//  `SCPOA_OldVersion_b is False.
	
	// Modified by: costasmanousakis-(Designer)-(6/14/11 15:28:49)
	Mods_2011_06
	//  `Added varibales  SCPOA_FVCAttach_L; SCPOA_Inst_WaterSurf_r; SCPOA_Inst_WaterSurf_L; fixed missing $i var
	// Modified by: costasmanousakis-(Designer)-(7/8/11 10:45:10)
	Mods_2011_07
	//  `Added missing APPEND TO ARRAY(SCPOA_SectionPage_aL;10) for non-multiview viewers.
	Mods_2011_10  // CJ Miller`10/04/11, 12:49:19      `remove String([Bridge MHD NBIS]Year Rehab'YearReh)
	// Modified by: costasmanousakis-(Designer)-(11/8/11 12:06:51)
	Mods_2011_11
	//  `Fixed assignement of SCPOA_UWInspFreq_L when there is a UW Spec mem inspection freq.
	// Modified by: Costas Manousakis-(Designer)-(2/26/12 15:23:54)
	Mods_2012_02
	//  `Changes for the new version of POA
	// Modified by: Costas Manousakis-(Designer)-(3/14/12 10:23:59)
	Mods_2012_03
	//  `added var SCPOA_Nav88_NGVD29_txt
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 10:40:07)
	Mods_2012_03
	//  `added var SCPOA_EvalTextProcess_L
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 16:24:23)
	Mods_2012_03
	//  `FV Photo changes : can have more than 4 or 5 photos -
	// ` sort first before getting the 1st 4 in "PRINTPG1"
	// Modified by: Costas Manousakis-(Designer)-(4/18/12 16:22:59)
	Mods_2012_04
	//  `added  2 pages to SectionSCPOASelect_atxt  for the FVC card data
	//  `added var SCPOA_BrStructType_txt from item 43 also stored in the POA data
	//  `added calculation of SCPOA_TrafEqDBE_txt based on the bridge district
	// Modified by: Costas Manousakis-(Designer)-(8/29/12 09:52:01)
	Mods_2012_08
	//  ` in GETUWINSPECTS make sure we leave [Inspections] in read write state.
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 14:06:16)
	Mods_2012_11
	//  `Moved update of SCPOA_PhotoAttach_L and SCPOA_DetourAttach_L after loading from the  data blob.
	//  `Also made sure SCPOA_InstCNT_L is not more than 1 after loading from data
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	// Modified by: Costas Manousakis-(Designer)-(10/6/14 16:05:20)
	Mods_2014_10_bug
	//  `General POA modifications Oct 2014
	Mods_2014_10
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(2/12/15 15:39:49)
	Mods_2015_02
	//  ` move setting of SCPOA_ReOpenResp_txt, SCPOA_Contacts_txt,SCPOA_BrgClosure_txt,SCPOA_ClosureResp_txt,SCPOA_PostFldMonAgc_txt inside
	//  ` if (Approve=0) ie. do only if POA has not been approved yet.
	//  ` use system parameters for the defaults of these varaibles depending on item8 owner. 
	//  ` for others except DOT and MUN use DOT as default
	// Modified by: Costas Manousakis-(Designer)-(2/24/15 10:08:41)
	Mods_2015_02
	//  `for  SCPOA_TrafEqDBE_txt = "Dist brg eng office phone" on FVC use the district main num from town address
	// Modified by: Costas Manousakis-(Designer)-(3/4/15 15:08:13)
	Mods_2015_03_bug
	//  `fixed bug where the latest variables  were not stored and retrieved in the correct order
	// Modified by: Costas Manousakis-(Designer)-(5/27/15 14:38:09)
	Mods_2015_05
	//  `added  action = LOADFROMBLOB - call tjhat from the LOAD action.  can be used to load Blob data in reports or outputscreens.
End if 
C_TEXT:C284($1; $Action_txt)
$Action_txt:=$1
Case of 
	: ($Action_txt="SETUP")
		C_BOOLEAN:C305(SCPOA_LogChanges_b)
		SCPOA_LogChanges_b:=True:C214
		ARRAY TEXT:C222(SCPOA_DataLogFreq_atxt; 0)
		ARRAY TEXT:C222(SCPOA_FoundationType_atxt; 0)
		ARRAY TEXT:C222(SCPOA_MonitSampl_atxt; 0)
		ARRAY TEXT:C222(SCPOA_OthFldMonFreq_atxt; 0)
		ARRAY TEXT:C222(SCPOA_OthMonInstrType_atxt; 0)
		ARRAY TEXT:C222(SCPOA_AbutElevRef_atxt; 0)
		ARRAY TEXT:C222(SCPOA_PierElevRef_atxt; 0)
		ARRAY BOOLEAN:C223(SCPOAFieldNotesListBox; 0)
		ARRAY BOOLEAN:C223(SCPOAImagesListBox; 0)
		ARRAY BOOLEAN:C223(SCPOADetBrgListBx; 0)
		ARRAY TEXT:C222(SCPOA_NWSSites_atxt; 0)
		ARRAY TEXT:C222(SCPOA_NWSStations_atxt; 0)
		ARRAY TEXT:C222(SCPOA_NWSStationURLs_atxt; 0)
		
	: ($Action_txt="INIT")
		C_TEXT:C284(SCPOA_Town_txt; SCPOA_Item8_txt; SCPOA_BIN_txt; SCPOA_BDEPT_txt; SCPOA_Item113_txt)
		C_TEXT:C284(SCPOA_SCPRIO_txt; SCPOA_Item7_txt; SCPOA_BrName_txt; SCPOA_Item27_txt; SCPOA_Item106_txt)
		C_TEXT:C284(SCPOA_YrRehab_txt; SCPOA_Item6a_txt; SCPOA_Dist_txt)
		C_TEXT:C284(SCPOA_Item60_txt; SCPOA_Item61_txt; SCPOA_Item71_txt)
		C_LONGINT:C283(SCPOA_Item91_L; SCPOA_UWInspFreq_L)
		C_TEXT:C284(vsInspDepartment)  // Command Replaced was o_C_STRING length was 150
		//Scour descr vars
		C_TEXT:C284(SCPOA_Descr1_txt; SCPOA_Descr2_txt)
		C_BOOLEAN:C305(SCPOA_Desc1Chg_b; SCPOA_Desc2Chg_b)
		C_PICTURE:C286(SCPOA_Locus_pic)
		C_TEXT:C284(SCPOA_ScRevDate_txt; SCPOA_StrAssDate_txt; SCPOA_GeoAssDate_txt)
		C_TEXT:C284(SCPOA_ComplDate_txt; SCPOA_ApprDate_txt)
		//Page one print variables
		C_PICTURE:C286(SCPOA_Pict1; SCPOA_Pict2; SCPOA_Pict3; SCPOA_Pict4; SCPOA_Pict5; SCPOA_Pict6)
		C_TEXT:C284(SCPOA_Pic1Lbl_txt; SCPOA_Pic2Lbl_txt; SCPOA_Pic3Lbl_txt; SCPOA_Pic4Lbl_txt; SCPOA_RoutineDate_txt)
		//Other form variables
		C_TEXT:C284(SCPOA_ComplCNT_txt; SCPOA_PropCNT_txt; SCPOA_PropCNT_txt)
		C_LONGINT:C283(SCPOA_CntNotReq_L; SCPOA_InstCNT_L)
		C_LONGINT:C283(SCPOA_Inst_RipRap_L; SCPOA_Inst_Guide_L; SCPOA_Inst_Spurs_L; SCPOA_Inst_Relief_L)
		C_LONGINT:C283(SCPOA_Inst_Chann_L; SCPOA_Inst_Monit_L; SCPOA_Inst_MonitDev_L; SCPOA_Inst_ChkDam_L; SCPOA_Inst_SubMod_L)
		C_LONGINT:C283(SCPOA_Inst_BrgRepl_L; SCPOA_Inst_Other_L)
		C_TEXT:C284(SCPOA_Inst_Other_txt)
		C_REAL:C285(SCPOA_Inst_RipRap_r; SCPOA_Inst_Guide_r; SCPOA_Inst_Spurs_r; SCPOA_Inst_Relief_r)
		C_REAL:C285(SCPOA_Inst_Chann_r; SCPOA_Inst_Monit_r; SCPOA_Inst_MonitDev_r; SCPOA_Inst_ChkDam_r; SCPOA_Inst_SubMod_r)
		C_REAL:C285(SCPOA_Inst_BrgRepl_r; SCPOA_Inst_Other_r)
		C_LONGINT:C283(SCPOA_CloseBrg_L; SCPOA_PropConsPrj_L; SCPOA_MaintPrj_L)
		C_TEXT:C284(SCPOA_LeadAgency_txt; SCPOA_SchedInfo_txt)
		C_DATE:C307(SCPOA_ImplAdDate)
		C_TEXT:C284(SCPOA_MonPlan_txt; SCPOA_MonitorAuth_txt)
		C_LONGINT:C283(SCPOA_RegInpPrg_L; SCPOA_RegFreq_L; SCPOA_RegInpPrg_Surv_L)
		C_TEXT:C284(SCPOA_WatchReg_txt)
		C_LONGINT:C283(SCPOA_IncrInspPrg_L; SCPOA_IncrInspFreq_L; SCPOA_IncrInspPrg_Surv_L)
		C_TEXT:C284(SCPOA_WatchIncr_txt)
		C_LONGINT:C283(SCPOA_UWInspPrg_L; SCPOA_UWInspPrgFreq_L)
		C_TEXT:C284(SCPOA_WatchUW_txt)
		C_LONGINT:C283(SCPOA_FixMonitDev_L)
		C_TEXT:C284(SCPOA_InstTYpe_txt; SCPOA_InstLoc_txt; SCPOA_SamplOther_txt; SCPOA_DataFreqOther_txt)
		C_REAL:C285(SCPOA_ScCritDisch_R)
		C_TEXT:C284(SCPOA_ScCritAction_txt)
		C_LONGINT:C283(SCPOA_OtherMonitDev_L; SCPOA_OtherMonitVis_L; SCPOA_OtherMonitinstr_L)
		C_TEXT:C284(SCPOA_OthMonInstrType_txt)
		C_LONGINT:C283(SCPOA_OthMonFldMonReqY_L; SCPOA_OthMonFldMonReqN_L; SCPOA_DischOvr_L; SCPOA_Stage_L; SCPOA_ElevMeas_L; SCPOA_DischOvrFeet_L)
		C_TEXT:C284(SCPOA_Stage_s)
		C_REAL:C285(SCPOA_ElevMeas_R)
		C_TEXT:C284(SCPOA_OthFldMonFreq_txt)
		C_REAL:C285(SCPOA_OthScCritElev_R)
		C_TEXT:C284(SCPOA_OthScCritAction_txt; SCPOA_BrADT_txt; SCPOA_TruckPct_txt; SCPOA_BrLen_txt)
		C_TEXT:C284(SCPOA_BrgClosure_txt; SCPOA_CLCri_wSurf_txt)
		C_LONGINT:C283(SCPOA_CLCri_wSurf_L; SCPOA_CLCri_Over_L; SCPOA_CLCri_ScMeas_L; SCPOA_CLCri_RipLoss_L; SCPOA_CLCri_Settlm_L)
		C_LONGINT:C283(SCPOA_CLCri_EmbkLoss_L; SCPOA_CLCri_Debris_L; SCPOA_CLCri_Other_L)
		C_TEXT:C284(SCPOA_CLCri_Other_txt; SCPOA_ClosureResp_txt; SCPOA_Contacts_txt; SCPOA_ReOpenResp_txt; SCPOA_DetourDesc_txt)
		C_LONGINT:C283(SCPOA_AvgADT_L; SCPOA_AvgADTYear_L; SCPOA_AvgADTTrckPct_L)
		C_REAL:C285(SCPOA_DetourBrgLen_r)
		C_LONGINT:C283(SCPOACalcAvgADT_L; SCPOACalcAvgADTYear_L; SCPOACalcAvgADTTrckPct_L)
		C_REAL:C285(SCPOACalcDetourBrgLen_r)
		ARRAY LONGINT:C221(SCPOA_PhotoRecs_aL; 0)
		ARRAY TEXT:C222(SectionSCPOASelect_atxt; 0)
		ARRAY LONGINT:C221(SCPOA_SectionPage_aL; 0)
		C_TEXT:C284(SCPOA_Item8_c_txt; SCPOA_Item113_c_txt; SCPOA_Item60_c_txt; SCPOA_Item61_c_txt; SCPOA_Item71_c_txt)
		C_TEXT:C284(SCPOA_FinalRec_txt; SCPOA_Owner_txt; SCPOA_DateComp_txt; SCPOA_LastInsp_txt; SCPOA_OtherAttach_txt)
		C_LONGINT:C283(SCPOA_PrioCounter_L; SCPOA_PrioMonitor_L; SCPOA_Summ_IncInspF_L; SCPOA_Summ_FloodMon_L; SCPOA_Summ_PostFlood_L; SCPOA_Summ_FixMonitDev_L; SCPOA_Summ_Counter_L)
		C_PICTURE:C286(SCPOA_SummPgPic_pic)
		C_LONGINT:C283(SCPOA_POAAttach_L; SCPOA_PhotoAttach_L; SCPOA_DetourAttach_L; SCPOA_ElevAttach_L; SCPOA_BoringAttach_L; SCPOA_SurveyAttach_L; SCPOA_CalcAttach_L; SCPOA_PlanAttach_L; SCPOA_FieldAttach_L; SCPOA_OtherAttach_L)
		C_TEXT:C284(SCPOA_POAEval_txt; SCPOA_POAHist_txt; SCPOA_WatchIncrUW_txt; SCPOA_FixedTerm_txt)
		C_LONGINT:C283(SCPOA_UWIncrInspPrg_L; SCPOA_UWIncrInspPrgFreq_L; SCPOA_NotifPublic_L; SCPOA_FLMTerm_CloseB_L; SCPOA_FLMTerm_Revisit_L)
		C_LONGINT:C283(SCPOA_FLMTerm_RecPost_L; SCPOA_FLMTerm_Stable_L)
		C_LONGINT:C283(SCPOA_PostFldVis_L; SCPOA_PostFldRvBed_L; SCPOA_PostFldProfSubstr_L; SCPOA_PostFldUnderm_L; SCPOA_PostFlood_L)
		C_TEXT:C284(SCPOA_PostFldWatch_txt; SCPOA_PostFldElevs_txt; SCPOA_PostFldAction_txt; SCPOA_OtherProj_txt)
		C_LONGINT:C283(SCPOA_OtherMaintPrj_L)
		C_LONGINT:C283(SCPOA_BrgCloWater_L; SCPOA_BrgCloCritElev_L; SCPOA_BrgCloReasAbate_L; SCPOA_BrgCloVerifyElev_L; SCPOA_BrgCloStreamEl_L; SCPOA_BrgCloStreamElAbove_L)
		C_LONGINT:C283(SCPOA_BrgCloInspCompl_L; SCPOA_BrgCloDiveCompl_L; SCPOA_BrgCloStreamElNo_L; SCPOA_BrgCloStreamElAbNo_L; SCPOA_BrgOpenPendDive_L)
		C_TEXT:C284(SCPOA_ReopenResp_txt; SCPOA_BrgCloDiveCompl_txt)
		C_LONGINT:C283(SCPOA_SummIMPLRegIncrY_L; SCPOA_SummIMPLRegIncrN_L; SCPOA_SummIMPLUWIncrY_L; SCPOA_SummIMPLUWIncrN_L; SCPOA_SummIMPLFixMonY_L)
		C_LONGINT:C283(SCPOA_SummIMPLFixMonN_L; SCPOA_SummIMPLFldMonY_L; SCPOA_SummIMPLFldMonN_L; SCPOA_SummIMPLPFldMonY_L; SCPOA_SummIMPLPFldMonN_L)
		
		C_LONGINT:C283(SCPOA_SourceObserv_L; SCPOA_SourceAssess_L; SCPOA_SourceCalc_L; SCPOA_SourceOther_L)
		C_TEXT:C284(SCPOA_SourceOther_txt; SCPOA_AbutSCElev_txt; SCPOA_AbutSCChordDist_txt; SCPOA_PierSCElev_txt; SCPOA_PierSCChordDist_txt)
		C_TEXT:C284(SCPOA_BrNoSpans_txt; SCPOA_BrLon_txt; SCPOA_BrLat_txt; SCPOA_EmergFacYN_txt; SCPOA_EmergFac_txt; SCPOA_BrStructType_txt)
		
		C_LONGINT:C283(SCPOA_SummOtherAttach_L)
		C_LONGINT:C283(SCPOA_POAAttach_L; SCPOA_PhotoAttach_L; SCPOA_DetourAttach_L)
		C_TEXT:C284(SCPOA_Eval_txt; SCPOA_SCHist_txt; SCPOA_DateComp_txt; SCPOA_LastInsp_txt)
		C_LONGINT:C283(SCPOA_FldForecast_L; SCPOA_FldWarnSys_L)
		C_TEXT:C284(SCPOA_FldForecast_txt; SCPOA_FldWarnSys_txt)
		C_TEXT:C284(SCPOA_POANextUpdate_txt)
		C_LONGINT:C283(SCPOA_POAUpdateFreq_L)
		C_DATE:C307(SCPOA_POANextUpdate_d)
		C_LONGINT:C283(SCPOA_2CSamp30min_L; SCPOA_2CSamp1hr_L; SCPOA_2CSamp6hr_L; SCPOA_2CSamp12hr_L; SCPOA_2CSampOther_L)
		C_LONGINT:C283(SCPOA_2CDwnldDay_L; SCPOA_2CDwnldWk_L; SCPOA_2CDwnldMo_L; SCPOA_2CDwnldOther_L)
		C_LONGINT:C283(SCPOA_2CEvtSampCont_L; SCPOA_2CEvtSamp10m_L; SCPOA_2CEvtSamp30m_L; SCPOA_2CEvtSamp1hr_L; SCPOA_2CEvtSampOth_L)
		C_LONGINT:C283(SCPOA_2CEvtFreqDay_L; SCPOA_2CEvtFreqWk_L; SCPOA_2CEvtFreqMo_L; SCPOA_2CEvtFreqOth_L)
		C_TEXT:C284(SCPOA_2CEvtSamplOther_txt; SCPOA_2CEvtFreqOther_txt; SCPOA_2cEvtScCritAction_txt; SCPOA_2cEvtFixedTerm_txt)
		C_LONGINT:C283(SCPOA_OthMonInstrPort_L; SCPOA_OthMonInstrGeo_L; SCPOA_OthMonInstrSon_L; SCPOA_OthMonInstrOth_L)
		C_LONGINT:C283(SCPOA_DOTSitRept_L; SCPOA_USGSStation_L)
		C_TEXT:C284(SCPOA_USGSStationNo_s)
		C_LONGINT:C283(SCPOA_2DFreqCont_L; SCPOA_2DFreq3Hr_L; SCPOA_2DFreq12Hr_L; SCPOA_2DFreqDay_L; SCPOA_2DFreqOther_L)
		C_TEXT:C284(SCPOA_ImplAdDate_txt; SCPOA_AbutElevRef_txt; SCPOA_PierElevRef_txt; SCPOA_FlMonLookFor_txt)
		C_TEXT:C284(SCPOA_EvtMonitSampl_txt; SCPOA_EvtDataLogFreq_txt)
		C_LONGINT:C283(SCPOA_HydRptAttach_L; SCPOA_Summ_UWIncInspF_L)
		C_TEXT:C284(SCPOA_DataFreqOtherDesc_txt; SCPOA_SamplOtherDesc_txt; SCPOA_OthFldMonFreqDesc_txt; SCPOA_EvtSamplOther_txt; SCPOA_EvtDataFreqOther_txt)
		
		C_TEXT:C284(SCPOA_ScCritDisch_txt; SCPOA_OthScCritElev_txt; SCPOA_DischOvrFeet_txt; SCPOA_BrgCloStreamElNo_txt; SCPOA_BrgCloStreamElAbNo_txt)
		
		C_LONGINT:C283(SCPOA_Inst_Placard_L)
		C_REAL:C285(SCPOA_Inst_Placard_r)
		C_LONGINT:C283(SCPOA_IncrInspPrg_Addtl_L)
		C_TEXT:C284(SCPOA_IncrInspPrg_Addtl_txt)
		C_TEXT:C284(SCPOA_AbutSCCritical_txt)
		C_TEXT:C284(SCPOA_PierSCCritical_txt)
		C_LONGINT:C283(SCPOA_MonitorCalcAttach_L)
		
		C_TEXT:C284(SCPOA_USGSStationURL_txt; SCPOA_USGSStationNo2_s; SCPOA_Stage2_s; SCPOA_DischOvrFeet2_txt; SCPOA_USGSStationURL2_txt; SCPOA_NWSStation_txt; SCPOA_NWSStationURL_txt)
		
		C_LONGINT:C283(SCPOA_FVCAttach_L; SCPOA_Inst_WaterSurf_L)
		C_REAL:C285(SCPOA_Inst_WaterSurf_r)
		C_LONGINT:C283(SCPOA_ChannelFreqCur_L; SCPOA_ChannelFreqRec_L)
		C_LONGINT:C283(SCPOA_LowChordDist_L; SCPOA_LowChordDist_L_P)
		C_REAL:C285(SCPOA_LowChordDistFt_r)
		
		C_LONGINT:C283(SCPOA_StructCounter_L; SCPOA_StructCounter_L_P)
		
		C_REAL:C285(SCPOA_CLCri_WLvl_r; SCPOA_OthScCritElev_r)
		
		SCPOA_AddtlVars
		
		// ********************
		// ****Other variables not stored in blob
		// ********************
		//List of consultants
		ARRAY TEXT:C222(SCPOA_Consultant_atxt; 0)
		ut_TextToArray(ut_GetSysParameter("SCPOAConsult"); ->SCPOA_Consultant_atxt; Char:C90(13))
		
		//Pull Down and associated page arrays for form pages
		ARRAY TEXT:C222(SectionSCPOASelect_atxt; 0)
		ARRAY LONGINT:C221(SCPOA_SectionPage_aL; 0)
		C_BOOLEAN:C305(SCPOA_MultipleVer_b)
		
		If (Not:C34(SCPOA_MultipleVer_b))
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Summary")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 15)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "1 - Scour Risk Evaluation Summary")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 2)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Inspections")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 11)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Fixed Monitoring Device")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 12)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Flood Monitoring")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 13)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Post Flood Assessment")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 14)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "3 - Bridge Closure Plan")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 7)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "4 - Bridge Reopening Plan")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 9)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "5 - Detour Route")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 8)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "6 - Countermeasure Recommendations")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 3)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "7 - Countermeasure Implementation Schedule")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 4)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Photos / Field Notes")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 10)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Completion / Approval / POA Update")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 16)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Field Verification Card - General Info")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 17)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Field Verification Card - Action Criteria")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 18)
			
			If (False:C215)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Summary")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 1)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "1 - Scour Vulnerability Rating")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 2)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Inspections/Fixed Device")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 5)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Flood Monitoring/Post Flood Insp.")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 6)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "3 - Countermeasure Recommendation")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 3)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "4 - Countermeasure Implementation Schedule")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 4)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "5 - Bridge Closure Plan")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 7)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "6 - Detour Route")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 8)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "7 - Bridge Reopening Plan / Completion / Approval / POA Update")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 9)
				APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Photos / Field Notes")
				APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 10)
				
			End if 
			
		Else 
			//****CHANGING THESE NAMES AFFECTS METHOD SCPOA_InpFormMethod on Close Detail
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Summary - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 15)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "1 - Scour Vulnerability Rating - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 2)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Inspections - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 11)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Fixed Monitoring Device - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 12)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Flood Monitoring - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 13)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Post Flood Assessment - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 14)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "3 - Bridge Closure Plan - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 7)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "4 - Bridge Reopening Plan / Completion / Approval / POA Update - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 9)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "5 - Detour Route - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 8)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "6 - Countermeasure Recommendations - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 3)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "7 - Countermeasure Implementation Schedule - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 4)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Photos / Field Notes - NEW")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 10)
			
			
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Summary - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 1)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "1 - Scour Vulnerability Rating - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 2)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Inspections/Fixed Device - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 5)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "2 - Monitoring Plan - Flood Monitoring/Post Flood Insp. - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 6)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "3 - Countermeasure Recommendation - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 3)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "4 - Countermeasure Implementation Schedule - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 4)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "5 - Bridge Closure Plan - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 7)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "6 - Detour Route - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 8)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "7 - Bridge Reopening Plan / Completion / Approval / POA Update - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 9)
			APPEND TO ARRAY:C911(SectionSCPOASelect_atxt; "Photos / Field Notes - OLD")
			APPEND TO ARRAY:C911(SCPOA_SectionPage_aL; 10)
			
		End if 
		
		SectionSCPOASelect_atxt:=1
		
		//Arrays of pointers to check boxes that behave like radio buttons.
		ARRAY POINTER:C280(SCPOA_EvtSamplCkBoxes_aptr; 0)
		APPEND TO ARRAY:C911(SCPOA_EvtSamplCkBoxes_aptr; ->SCPOA_2CEvtSampCont_L)
		APPEND TO ARRAY:C911(SCPOA_EvtSamplCkBoxes_aptr; ->SCPOA_2CEvtSamp10m_L)
		APPEND TO ARRAY:C911(SCPOA_EvtSamplCkBoxes_aptr; ->SCPOA_2CEvtSamp30m_L)
		APPEND TO ARRAY:C911(SCPOA_EvtSamplCkBoxes_aptr; ->SCPOA_2CEvtSamp1hr_L)
		APPEND TO ARRAY:C911(SCPOA_EvtSamplCkBoxes_aptr; ->SCPOA_2CEvtSampOth_L)
		ARRAY POINTER:C280(SCPOA_EvtFreqCkBoxes_aptr; 0)
		APPEND TO ARRAY:C911(SCPOA_EvtFreqCkBoxes_aptr; ->SCPOA_2CEvtFreqDay_L)
		APPEND TO ARRAY:C911(SCPOA_EvtFreqCkBoxes_aptr; ->SCPOA_2CEvtFreqWk_L)
		APPEND TO ARRAY:C911(SCPOA_EvtFreqCkBoxes_aptr; ->SCPOA_2CEvtFreqMo_L)
		APPEND TO ARRAY:C911(SCPOA_EvtFreqCkBoxes_aptr; ->SCPOA_2CEvtFreqOth_L)
		ARRAY POINTER:C280(SCPOA_2CDwnldCkBx_aptr; 0)
		APPEND TO ARRAY:C911(SCPOA_2CDwnldCkBx_aptr; ->SCPOA_2CDwnldDay_L)
		APPEND TO ARRAY:C911(SCPOA_2CDwnldCkBx_aptr; ->SCPOA_2CDwnldWk_L)
		APPEND TO ARRAY:C911(SCPOA_2CDwnldCkBx_aptr; ->SCPOA_2CDwnldMo_L)
		APPEND TO ARRAY:C911(SCPOA_2CDwnldCkBx_aptr; ->SCPOA_2CDwnldOther_L)
		ARRAY POINTER:C280(SCPOA_2CSampleCkBx_aptr; 0)
		APPEND TO ARRAY:C911(SCPOA_2CSampleCkBx_aptr; ->SCPOA_2CSamp30min_L)
		APPEND TO ARRAY:C911(SCPOA_2CSampleCkBx_aptr; ->SCPOA_2CSamp1Hr_L)
		APPEND TO ARRAY:C911(SCPOA_2CSampleCkBx_aptr; ->SCPOA_2CSamp6Hr_L)
		APPEND TO ARRAY:C911(SCPOA_2CSampleCkBx_aptr; ->SCPOA_2CSamp12Hr_L)
		APPEND TO ARRAY:C911(SCPOA_2CSampleCkBx_aptr; ->SCPOA_2CSampOther_L)
		ARRAY POINTER:C280(SCPOA_2DFreqCkBx_aptr; 0)
		APPEND TO ARRAY:C911(SCPOA_2DFreqCkBx_aptr; ->SCPOA_2DFreqCont_L)
		APPEND TO ARRAY:C911(SCPOA_2DFreqCkBx_aptr; ->SCPOA_2DFreq3Hr_L)
		APPEND TO ARRAY:C911(SCPOA_2DFreqCkBx_aptr; ->SCPOA_2DFreq12Hr_L)
		APPEND TO ARRAY:C911(SCPOA_2DFreqCkBx_aptr; ->SCPOA_2DFreqDay_L)
		APPEND TO ARRAY:C911(SCPOA_2DFreqCkBx_aptr; ->SCPOA_2DFreqOther_L)
		
		C_LONGINT:C283(SCPOA_ApproveChkBx; SCPOA_CompleteChkBx; SCPOA_PMReviewChkBox)
		
		ARRAY TEXT:C222(SCPOA_NWSSites_atxt; 0)
		ARRAY TEXT:C222(SCPOA_NWSStations_atxt; 0)
		ARRAY TEXT:C222(SCPOA_NWSStationURLs_atxt; 0)
		
		APPEND TO ARRAY:C911(SCPOA_NWSStations_atxt; "Western, MA (NWS out of Albany, NY)")
		APPEND TO ARRAY:C911(SCPOA_NWSStationURLs_atxt; "http://www.erh.noaa.gov/er/aly/")
		
		APPEND TO ARRAY:C911(SCPOA_NWSStations_atxt; "Eastern, MA (NWS out of Boston (Taunton))")
		APPEND TO ARRAY:C911(SCPOA_NWSStationURLs_atxt; "http://www.erh.noaa.gov/er/box/")
		
		APPEND TO ARRAY:C911(SCPOA_NWSSites_atxt; "")
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(SCPOA_NWSStations_atxt))
			APPEND TO ARRAY:C911(SCPOA_NWSSites_atxt; SCPOA_NWSStations_atxt{$loop_L}+":"+SCPOA_NWSStationURLs_atxt{$loop_L})
		End for 
		
		C_LONGINT:C283(SCPOA_EvalTextProcess_L)
		
		// ********************
		// **** END OF variables not stored in blob
		// ********************
		
	: ($Action_txt="CLEAR")
		
		SCPOA_2CDwnldDay_L:=0
		SCPOA_2CDwnldMo_L:=0
		SCPOA_2CDwnldOther_L:=0
		SCPOA_2CDwnldWk_L:=0
		SCPOA_2cEvtFixedTerm_txt:=""
		SCPOA_2CEvtFreqDay_L:=0
		SCPOA_2CEvtFreqMo_L:=0
		SCPOA_2CEvtFreqOth_L:=0
		SCPOA_2CEvtFreqOther_txt:=""
		SCPOA_2CEvtFreqWk_L:=0
		SCPOA_2CEvtSamp10m_L:=0
		SCPOA_2CEvtSamp1hr_L:=0
		SCPOA_2CEvtSamp30m_L:=0
		SCPOA_2CEvtSampCont_L:=0
		SCPOA_2CEvtSamplOther_txt:=""
		SCPOA_2CEvtSampOth_L:=0
		SCPOA_2cEvtScCritAction_txt:=""
		SCPOA_2CSamp12hr_L:=0
		SCPOA_2CSamp1hr_L:=0
		SCPOA_2CSamp30min_L:=0
		SCPOA_2CSamp6hr_L:=0
		SCPOA_2CSampOther_L:=0
		SCPOA_2DFreq12Hr_L:=0
		SCPOA_2DFreq3Hr_L:=0
		SCPOA_2DFreqCont_L:=0
		SCPOA_2DFreqDay_L:=0
		SCPOA_2DFreqOther_L:=0
		SCPOA_7BContactPers_txt:=""
		SCPOA_7BInstallBy_txt:=""
		SCPOA_AbutElevRef_txt:=""
		SCPOA_AbutSCChordDist_txt:=""
		SCPOA_AbutSCCritical_txt:=""
		SCPOA_AbutSCCritiEmbed_txt:=""
		SCPOA_AbutSCCritiExpos_txt:=""
		SCPOA_AbutSCElev_txt:=""
		SCPOA_AddtlCritCons_txt:=""
		SCPOA_Appr2Date_d:=!00-00-00!
		SCPOA_Appr2Date_d:=!00-00-00!
		SCPOA_Appr3Date_d:=!00-00-00!
		SCPOA_Appr3Date_d:=!00-00-00!
		SCPOA_ApprBy2_txt:=""
		SCPOA_ApprBy3_txt:=""
		SCPOA_ApprDate_txt:=""
		SCPOA_ApproachNotSettl_L:=0
		SCPOA_ApproveChkBx:=0
		SCPOA_AssessRvrBedOK_L:=0
		SCPOA_AvgADT_L:=0
		SCPOA_AvgADTTrckPct_L:=0
		SCPOA_AvgADTYear_L:=0
		SCPOA_BDEPT_txt:=""
		SCPOA_BIN_txt:=""
		SCPOA_BoringAttach_L:=0
		SCPOA_BrADT_txt:=""
		SCPOA_BrADTYr_txt:=""
		SCPOA_BrgCloCritElev_L:=0
		SCPOA_BrgCloDiveCompl_L:=0
		SCPOA_BrgCloDiveCompl_txt:=""
		SCPOA_BrgCloInspCompl_L:=0
		SCPOA_BrgCloReasAbate_L:=0
		SCPOA_BrgCloStreamEl_L:=0
		SCPOA_BrgCloStreamElAbNo_L:=0
		SCPOA_BrgCloStreamElAbNo_txt:=""
		SCPOA_BrgCloStreamElAbove_L:=0
		SCPOA_BrgCloStreamElNo_L:=0
		SCPOA_BrgCloStreamElNo_txt:=""
		SCPOA_BrgClosure_txt:=""
		SCPOA_BrgCloVerifyElev_L:=0
		SCPOA_BrgCloWater_L:=0
		SCPOA_BrgOpenPendDive_L:=0
		SCPOA_BrgRailStraight_L:=0
		SCPOA_BrLat_txt:=""
		SCPOA_BrStructType_txt:=""
		SCPOA_BrLen_txt:=""
		SCPOA_BrLon_txt:=""
		SCPOA_BrName_txt:=""
		SCPOA_BrNoSpans_txt:=""
		SCPOA_CalcAttach_L:=0
		SCPOA_CLCri_Debris_L:=0
		SCPOA_CLCri_EmbkLoss_L:=0
		SCPOA_CLCri_NOAAG_L:=0
		SCPOA_CLCri_NOAAG_txt:=""
		SCPOA_CLCri_NOAAI_txt:=""
		SCPOA_CLCri_NOAANo_L:=0
		SCPOA_CLCri_NOAANo_txt:=""
		SCPOA_CLCri_NWS_L:=0
		SCPOA_CLCri_Other_L:=0
		SCPOA_CLCri_Other_txt:=""
		SCPOA_CLCri_Over_L:=0
		SCPOA_CLCri_RipLoss_L:=0
		SCPOA_CLCri_ScMeas_L:=0
		SCPOA_CLCri_Settlm_L:=0
		SCPOA_CLCri_USGSD_L:=0
		SCPOA_CLCri_USGSD_txt:=""
		SCPOA_CLCri_USGSG_L:=0
		SCPOA_CLCri_USGSG_txt:=""
		SCPOA_CLCri_USGSNo_L:=0
		SCPOA_CLCri_USGSNo_txt:=""
		SCPOA_CLCri_WLvl_L:=0
		SCPOA_CLCri_WLvl_txt:=""
		SCPOA_CLCri_wSurf_L:=0
		SCPOA_CLCri_wSurf_txt:=""
		SCPOA_CloseBrg_L:=0
		SCPOA_ClosureResp_txt:=""
		SCPOA_CntNotReq_L:=0
		SCPOA_CNTNotReq_txt:=""
		SCPOA_ComplCNT_txt:=""
		SCPOA_ComplDate_txt:=""
		SCPOA_Contacts_txt:=""
		SCPOA_CritStrElmOK_L:=0
		SCPOA_CritWSEMarkLoc_txt:=""
		SCPOA_DataFreqOther_txt:=""
		SCPOA_DataFreqOtherDesc_txt:=""
		SCPOA_DateComp_txt:=""
		SCPOA_Desc1Chg_b:=False:C215
		SCPOA_Desc2Chg_b:=False:C215
		SCPOA_Descr1_txt:=""
		SCPOA_Descr2_txt:=""
		SCPOA_DetourAttach_L:=0
		SCPOA_DetourBrgLen_r:=0
		SCPOA_DetourDesc_txt:=""
		SCPOA_DischOvr_L:=0
		SCPOA_DischOvrFeet_L:=0
		SCPOA_DischOvrFeet_txt:=""
		SCPOA_DischOvrFeet2_txt:=""
		SCPOA_Dist_txt:=""
		SCPOA_DOTSitRept_L:=0
		SCPOA_ElevAttach_L:=0
		SCPOA_ElevMeas_L:=0
		SCPOA_ElevMeas_r:=0
		SCPOA_EmbErosOK_L:=0
		SCPOA_EmergFac_txt:=""
		SCPOA_EmergFacYN_txt:=""
		SCPOA_Eval_txt:=""
		SCPOA_EvtDataFreqOther_txt:=""
		SCPOA_EvtDataLogFreq_txt:=""
		SCPOA_EvtMonitSampl_txt:=""
		SCPOA_EvtSamplOther_txt:=""
		SCPOA_FieldAttach_L:=0
		SCPOA_FinalRec_txt:=""
		SCPOA_FixedDevProced_txt:=""
		SCPOA_FixedTerm_txt:=""
		SCPOA_FixMonDevWarn_L:=0
		SCPOA_FixMonitDev_L:=0
		SCPOA_FldForecast_L:=0
		SCPOA_FldForecast_txt:=""
		SCPOA_FldWarnSys_L:=0
		SCPOA_FldWarnSys_txt:=""
		SCPOA_FlMonLookFor_txt:=""
		SCPOA_FLMTerm_CloseB_L:=0
		SCPOA_FLMTerm_RecPost_L:=0
		SCPOA_FLMTerm_Revisit_L:=0
		SCPOA_FLMTerm_Stable_L:=0
		SCPOA_FVCAttach_L:=0
		SCPOA_GeoAssDate_txt:=""
		SCPOA_HydRptAttach_L:=0
		SCPOA_ImplAdDate_txt:=""
		SCPOA_ImplAdDate:=!00-00-00!
		SCPOA_ImplSchedCompDate:=!00-00-00!
		SCPOA_ImplSchedCompDate:=!00-00-00!
		SCPOA_IncrInspFreq_L:=0
		SCPOA_IncrInspPrg_Addtl_L:=0
		SCPOA_IncrInspPrg_Addtl_txt:=""
		SCPOA_IncrInspPrg_L:=0
		SCPOA_IncrInspPrg_Surv_L:=0
		SCPOA_Inst_BrgRepl_L:=0
		SCPOA_Inst_BrgRepl_r:=0
		SCPOA_Inst_Chann_L:=0
		SCPOA_Inst_Chann_r:=0
		SCPOA_Inst_ChkDam_L:=0
		SCPOA_Inst_ChkDam_r:=0
		SCPOA_Inst_GroutB_L:=0
		SCPOA_Inst_GroutB_r:=0
		SCPOA_Inst_Guide_L:=0
		SCPOA_Inst_Guide_r:=0
		SCPOA_Inst_L_BrgRepl_L:=0
		SCPOA_Inst_L_Chann_L:=0
		SCPOA_Inst_L_ChkDam_L:=0
		SCPOA_Inst_L_GroutB_L:=0
		SCPOA_Inst_L_Guide_L:=0
		SCPOA_Inst_L_Monit_L:=0
		SCPOA_Inst_L_MonitDev_L:=0
		SCPOA_Inst_L_Other_L:=0
		SCPOA_Inst_L_Relief_L:=0
		SCPOA_Inst_L_RipRap_L:=0
		SCPOA_Inst_L_Spurs_L:=0
		SCPOA_Inst_L_SubMod_L:=0
		SCPOA_Inst_L_WaterSurf_L:=0
		SCPOA_Inst_Monit_L:=0
		SCPOA_Inst_Monit_r:=0
		SCPOA_Inst_MonitDev_L:=0
		SCPOA_Inst_MonitDev_r:=0
		SCPOA_Inst_Other_L:=0
		SCPOA_Inst_Other_r:=0
		SCPOA_Inst_Other_txt:=""
		SCPOA_Inst_Placard_L:=0
		SCPOA_Inst_Placard_r:=0
		SCPOA_Inst_Relief_L:=0
		SCPOA_Inst_Relief_r:=0
		SCPOA_Inst_RipRap_L:=0
		SCPOA_Inst_RipRap_r:=0
		SCPOA_Inst_Spurs_L:=0
		SCPOA_Inst_Spurs_r:=0
		SCPOA_Inst_SubMod_L:=0
		SCPOA_Inst_SubMod_r:=0
		SCPOA_Inst_WaterSurf_L:=0
		SCPOA_Inst_WaterSurf_r:=0
		SCPOA_InstCNT_L:=0
		SCPOA_InstLoc_txt:=""
		SCPOA_InstTYpe_txt:=""
		SCPOA_Item106_txt:=""
		SCPOA_Item113_c_txt:=""
		SCPOA_Item113_txt:=""
		SCPOA_Item27_txt:=""
		SCPOA_Item60_c_txt:=""
		SCPOA_Item60_txt:=""
		SCPOA_Item61_c_txt:=""
		SCPOA_Item61_txt:=""
		SCPOA_Item6a_txt:=""
		SCPOA_Item7_txt:=""
		SCPOA_Item71_c_txt:=""
		SCPOA_Item71_txt:=""
		SCPOA_Item8_c_txt:=""
		SCPOA_Item8_txt:=""
		SCPOA_Item91_L:=0
		SCPOA_LastInsp_txt:=""
		SCPOA_LeadAgency_txt:=""
		SCPOA_Locus_pic:=SCPOA_Locus_pic*0
		SCPOA_MaintPrj_L:=0
		SCPOA_MonitorAuth_txt:=""
		SCPOA_MonitorCalcAttach_L:=0
		SCPOA_MonPlan_txt:=""
		SCPOA_NOAAStation_L:=0
		SCPOA_NotifPublic_L:=0
		SCPOA_NWSStation_txt:=""
		SCPOA_NWSStationURL_txt:=""
		SCPOA_OtherAttach_L:=0
		SCPOA_OtherAttach_txt:=""
		SCPOA_OtherMaintPrj_L:=0
		SCPOA_OtherMonitDev_L:=0
		SCPOA_OtherMonitinstr_L:=0
		SCPOA_OtherMonitVis_L:=0
		SCPOA_OtherProj_txt:=""
		SCPOA_OthFldMonFreq_txt:=""
		SCPOA_OthFldMonFreqDesc_txt:=""
		SCPOA_OthMonFldMonReqN_L:=0
		SCPOA_OthMonFldMonReqY_L:=0
		SCPOA_OthMonInstrGeo_L:=0
		SCPOA_OthMonInstrOth_L:=0
		SCPOA_OthMonInstrPort_L:=0
		SCPOA_OthMonInstrSon_L:=0
		SCPOA_OthMonInstrType_txt:=""
		SCPOA_OthScCritAction_txt:=""
		SCPOA_OthScCritElev_r:=0
		SCPOA_OthScCritElev_txt:=""
		SCPOA_Owner_txt:=""
		SCPOA_PhotoAttach_L:=0
		SCPOA_Pic1Lbl_txt:=""
		SCPOA_Pic2Lbl_txt:=""
		SCPOA_Pic3Lbl_txt:=""
		SCPOA_Pic4Lbl_txt:=""
		SCPOA_Pic5Lbl_txt:=""
		SCPOA_Pic5Lbl_txt:=""
		SCPOA_Pict1:=SCPOA_Pict1*0
		SCPOA_Pict2:=SCPOA_Pict2*0
		SCPOA_Pict3:=SCPOA_Pict3*0
		SCPOA_Pict4:=SCPOA_Pict3*0
		SCPOA_Pict5:=SCPOA_Pict3*0
		SCPOA_Pict6:=SCPOA_Pict3*0
		SCPOA_PierElevRef_txt:=""
		SCPOA_PierSCChordDist_txt:=""
		SCPOA_PierSCCritical_txt:=""
		SCPOA_PierSCCritiEmbed_txt:=""
		SCPOA_PierSCCritiExpos_txt:=""
		SCPOA_PierSCElev_txt:=""
		SCPOA_PlanAttach_L:=0
		SCPOA_PMLockButton_L:=0
		SCPOA_PMReviewChkBox:=0
		SCPOA_POAAttach_L:=0
		SCPOA_POAEval_txt:=""
		SCPOA_POAHist_txt:=""
		SCPOA_POANextUpdate_d:=!00-00-00!
		SCPOA_POAUpdateFreq_L:=0
		SCPOA_PostFldAction_txt:=""
		SCPOA_PostFldContact_txt:=""
		SCPOA_PostFldElevs_txt:=""
		SCPOA_PostFldMonAgc_txt:=""
		SCPOA_PostFldProbing_L:=0
		SCPOA_PostFldProfSubstr_L:=0
		SCPOA_PostFldRvBed_L:=0
		SCPOA_PostFldUnderm_L:=0
		SCPOA_PostFldUWInsp_L:=0
		SCPOA_PostFldVis_L:=0
		SCPOA_PostFldWatch_txt:=""
		SCPOA_PostFlood_L:=0
		SCPOA_PreExistCond_txt:=""
		SCPOA_PrevMonForm_L:=0
		SCPOA_PrioCounter_L:=0
		SCPOA_PrioMonitor_L:=0
		SCPOA_PropCNT_txt:=""
		SCPOA_PropConsPrj_L:=0
		SCPOA_RecFixMonitDev_L:=0
		SCPOA_RegFreq_L:=0
		SCPOA_RegInpPrg_L:=0
		SCPOA_RegInpPrg_Surv_L:=0
		SCPOA_ReopenResp_txt:=""
		SCPOA_RoutineDate_txt:=""
		SCPOA_SamplOther_txt:=""
		SCPOA_SamplOtherDesc_txt:=""
		SCPOA_ScCritAction_txt:=""
		SCPOA_ScCritDisch_r:=0
		SCPOA_ScCritDisch_txt:=""
		SCPOA_SchedInfo_txt:=""
		SCPOA_SCHist_txt:=""
		SCPOA_ScourCritFeat_txt:=""
		SCPOA_SCPRIO_txt:=""
		SCPOA_ScRevDate_txt:=""
		SCPOA_SourceAssess_L:=0
		SCPOA_SourceCalc_L:=0
		SCPOA_SourceObserv_L:=0
		SCPOA_SourceOther_L:=0
		SCPOA_SourceOther_txt:=""
		SCPOA_SourceRefs_txt:=""
		SCPOA_Stage_L:=0
		SCPOA_Stage_s:=""
		SCPOA_Stage2_s:=""
		SCPOA_StrAssDate_txt:=""
		SCPOA_substrPlumb_L:=0
		SCPOA_Summ_Counter_L:=0
		SCPOA_Summ_FixMonitDev_L:=0
		SCPOA_Summ_FloodMon_L:=0
		SCPOA_Summ_IncInspF_L:=0
		SCPOA_Summ_IncUWF_L:=0
		SCPOA_Summ_PostFlood_L:=0
		SCPOA_Summ_UWIncInspF_L:=0
		SCPOA_SummIMPLFixMonN_L:=0
		SCPOA_SummIMPLFixMonY_L:=0
		SCPOA_SummIMPLFldMonN_L:=0
		SCPOA_SummIMPLFldMonY_L:=0
		SCPOA_SummIMPLPFldMonN_L:=0
		SCPOA_SummIMPLPFldMonY_L:=0
		SCPOA_SummIMPLRegIncrN_L:=0
		SCPOA_SummIMPLRegIncrY_L:=0
		SCPOA_SummIMPLUWIncrN_L:=0
		SCPOA_SummIMPLUWIncrY_L:=0
		SCPOA_SummOtherAttach_L:=0
		SCPOA_SummPgPic_pic:=SCPOA_SummPgPic_pic*0
		SCPOA_SurveyAttach_L:=0
		SCPOA_Town_txt:=""
		SCPOA_TrafEqDBE_txt:=""
		SCPOA_TrafEqDist_txt:=""
		SCPOA_TrafEqLoc_txt:=""
		SCPOA_TruckPct_txt:=""
		SCPOA_USGSSt2ProxBrg_s:=""
		SCPOA_USGSStation_L:=0
		SCPOA_USGSStationNo_s:=""
		SCPOA_USGSStationNo2_s:=""
		SCPOA_USGSStationURL_txt:=""
		SCPOA_USGSStationURL2_txt:=""
		SCPOA_USGSStProxBrg_s:=""
		SCPOA_UWIncrInspPrg_L:=0
		SCPOA_UWIncrInspPrgFreq_L:=0
		SCPOA_UWInspFreq_L:=0
		SCPOA_UWInspPrg_L:=0
		SCPOA_UWInspPrgFreq_L:=0
		SCPOA_UWInspRptAvail_L:=0
		SCPOA_UWInspRptAvailDates_txt:=""
		SCPOA_WatchIncr_txt:=""
		SCPOA_WatchIncrUW_txt:=""
		SCPOA_WatchReg_txt:=""
		SCPOA_WatchUW_txt:=""
		SCPOA_YrRehab_txt:=""
		SCPOACalcAvgADT_L:=0
		SCPOACalcAvgADTTrckPct_L:=0
		SCPOACalcAvgADTYear_L:=0
		SCPOACalcDetourBrgLen_r:=0
		VSINSPDEPARTMENT:=""
		SCPOA_ReviitEvery_txt:=""
		SCPOA_Nav88_NGVD29_txt:=""
		SCPOA_EvalTextProcess_L:=0
		SCPOA_ChannelFreqCur_L:=0
		SCPOA_ChannelFreqRec_L:=0
		SCPOA_LowChordDist_L:=0
		SCPOA_LowChordDist_L_P:=0
		SCPOA_LowChordDistFt_r:=0
		SCPOA_StructCounter_L:=0
		SCPOA_StructCounter_L_P:=0
		SCPOA_CLCri_WLvl_r:=0
		SCPOA_OthScCritElev_r:=0
		SCPOA_CLCri_WLvl_p_txt:=""
		SCPOA_OthScCritElev_p_txt:=""
		
	: ($Action_txt="LOAD")
		G_SIA_BuildTownLine
		SCPOA_BDEPT_txt:=sBDEPT
		SCPOA_Town_txt:=sTown
		SCPOA_BIN_txt:=[ScourPOA:132]BIN:2
		SCPOA_Dist_txt:=[Bridge MHD NBIS:1]Item2:60
		SCPOA_BrLon_txt:=String:C10([Bridge MHD NBIS:1]Item17A:70)+Char:C90(188)+" - "+String:C10([Bridge MHD NBIS:1]Item17B:71)+Char:C90(39)+" - "+String:C10([Bridge MHD NBIS:1]Item17C:136; "##.00")+<>sQU
		SCPOA_BrLat_txt:=String:C10([Bridge MHD NBIS:1]Item16A:68)+Char:C90(188)+" - "+String:C10([Bridge MHD NBIS:1]Item16B:69)+Char:C90(39)+" - "+String:C10([Bridge MHD NBIS:1]Item16C:109; "##.00")+<>sQU
		SCPOA_BrLen_txt:=String:C10((3.2808*[Bridge MHD NBIS:1]Item49:93); "###,###,##0.0")
		SCPOA_BrNoSpans_txt:=String:C10([Bridge MHD NBIS:1]Item45:77)
		SCPOA_BrStructType_txt:=QR_Item43A+" "+QR_Item43B
		
		C_BLOB:C604($tempBlb)
		C_LONGINT:C283($compr_L; $blobExpSize_L; $blbsize_L)
		BLOB PROPERTIES:C536([ScourPOA:132]ScourEvalSummary:6; $compr_L; $blobExpSize_L; $blbsize_L)
		If ($blbsize_L>0)
			$tempBlb:=[ScourPOA:132]ScourEvalSummary:6
			If ($compr_L#Is not compressed:K22:11)
				EXPAND BLOB:C535($tempBlb)
			End if 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Descr1_txt)
		End if 
		
		BLOB PROPERTIES:C536([ScourPOA:132]ScourHistory:7; $compr_L; $blobExpSize_L; $blbsize_L)
		If ($blbsize_L>0)
			$tempBlb:=[ScourPOA:132]ScourHistory:7
			If ($compr_L#Is not compressed:K22:11)
				EXPAND BLOB:C535($tempBlb)
			End if 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Descr2_txt)
		End if 
		SCPOA_ScRevDate_txt:=F_dateToString([ScourPOA:132]ScourReviewDate:12; Internal date short:K1:7)
		SCPOA_StrAssDate_txt:=F_dateToString([ScourPOA:132]StructAssessDate:13; Internal date short:K1:7)
		SCPOA_GeoAssDate_txt:=F_dateToString([ScourPOA:132]GeotechAssessDate:14; Internal date short:K1:7)
		SCPOA_ComplDate_txt:=F_dateToString([ScourPOA:132]DateCompleted:8; Internal date short:K1:7)
		SCPOA_ApprDate_txt:=F_dateToString([ScourPOA:132]DateApproved:5; Internal date short:K1:7)
		
		SCPOA_ApproveChkBx:=[ScourPOA:132]Approved:23
		SCPOA_CompleteChkBx:=Num:C11(f_Boolean2String([ScourPOA:132]Completed:21; "10"))
		SCPOA_PMReviewChkBox:=[ScourPOA:132]PMReviewed:29
		
		Case of 
			: ([Bridge MHD NBIS:1]InspResp:173="MTA")
				vsInspDepartment:="MASSACHUSETTS TURNPIKE AUTHORITY"
			: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
				vsInspDepartment:="MASSACHUSETTS BAY TRANSPORTATION AUTHORITY"
			: ([Bridge MHD NBIS:1]InspResp:173="MDC")
				vsInspDepartment:="DEPARTMENT OF CONSERVATION AND RECREATION"
			Else 
				vsInspDepartment:="MASSACHUSETTS DEPARTMENT OF TRANSPORTATION"
		End case 
		SCPOA_Variables("LOADFROMBLOB")
		
		SCPOA_FVCAttach_L:=1  //fvc automatically checked
		
		If (SCPOA_InstCNT_L>1)
			SCPOA_InstCNT_L:=1
		End if 
		
		SCPOA_POAAttach_L:=1  //POA automatically checked
		C_LONGINT:C283($numpics_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $numpics_L)
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)  //Update Attachm G photos checkbox
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="Photo")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($numpics_L>0)
			SCPOA_PhotoAttach_L:=1
		Else 
			SCPOA_PhotoAttach_L:=0
		End if 
		SET QUERY DESTINATION:C396(Into variable:K19:4; $numpics_L)
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)  //Update Detour route checkbox
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="Detour")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($numpics_L>0)
			SCPOA_DetourAttach_L:=1
		Else 
			SCPOA_DetourAttach_L:=0
		End if 
		
		If ([ScourPOA:132]Approved:23=0)
			SCPOA_Item113_txt:=[Bridge MHD NBIS:1]Item113:151
			SCPOA_Item8_txt:=[Bridge MHD NBIS:1]Item8:206
			QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			If (Records in selection:C76([ScourPriorityRank:108])=1)
				SCPOA_SCPRIO_txt:=[ScourPriorityRank:108]Category:5+" / "+String:C10([ScourPriorityRank:108]Rank:6)
			Else 
				SCPOA_SCPRIO_txt:=""
			End if 
			
			SCPOA_Item7_txt:=[Bridge MHD NBIS:1]Item7:65
			SCPOA_BrName_txt:=[Bridge MHD NBIS:1]Bridge Name:29
			SCPOA_Item27_txt:=String:C10([Bridge MHD NBIS:1]Item27:83)
			SCPOA_Item106_txt:=String:C10([Bridge MHD NBIS:1]Item106:84)
			SCPOA_Item91_L:=[Bridge MHD NBIS:1]Item91:162
			SCPOA_UWInspFreq_L:=[Bridge MHD NBIS:1]Item92BB:166
			If ([Bridge MHD NBIS:1]UWSpInsp:212)
				If ([Bridge MHD NBIS:1]UWSpInspFreq:213>0) & ([Bridge MHD NBIS:1]UWSpInspFreq:213<[Bridge MHD NBIS:1]Item92BB:166)
					SCPOA_UWInspFreq_L:=[Bridge MHD NBIS:1]UWSpInspFreq:213
				End if 
			End if 
			SCPOA_YrRehab_txt:=""
			SCPOA_Item6a_txt:=[Bridge MHD NBIS:1]Item6A:63
			SCPOA_Item60_txt:=[Bridge MHD NBIS:1]Item60:132
			SCPOA_Item61_txt:=[Bridge MHD NBIS:1]Item61:133
			SCPOA_Item71_txt:=[Bridge MHD NBIS:1]Item71:145
			SCPOA_RoutineDate_txt:=F_dateToString([Bridge MHD NBIS:1]Item90:161; Internal date short:K1:7)
			SCPOA_BrADT_txt:=String:C10([Bridge MHD NBIS:1]Item29:88)
			SCPOA_TruckPct_txt:=String:C10([Bridge MHD NBIS:1]Item109:90)
			SCPOA_BrADTYr_txt:=String:C10([Bridge MHD NBIS:1]Item30:89)
			SCPOA_DetourBrgLen_R:=0
			Case of 
				: ([Bridge MHD NBIS:1]Item19:91>=199)
				: ([Bridge MHD NBIS:1]Item19:91<=0)
				Else 
					SCPOA_DetourBrgLen_R:=Round:C94(([Bridge MHD NBIS:1]Item19:91*0.621371192); 3)
			End case 
			
			If (SCPOA_Owner_txt="")
				SCPOA_Owner_txt:=[Bridge MHD NBIS:1]Item8 Owner:208
			End if 
			C_TEXT:C284(v_78_004_txt)
			If (SCPOA_TrafEqDBE_txt="")
				v_78_004_txt:="District "+String:C10(Num:C11(SCPOA_Dist_txt))
				Begin SQL
					select [Town Address].[ContactPhone]
					from [Town Address]
					where
					[Town Address].[OfficialTownName] = :v_78_004_txt
					into :SCPOA_TrafEqDBE_txt
				End SQL
				[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
			Else 
				// this was implemented at the same time when datemodified was added to the save
				// so all records have 00/00/00 for datemodified
				If ([ScourPOA:132]DateModified:4>!00-00-00!)
				Else 
					v_78_004_txt:="District "+String:C10(Num:C11(SCPOA_Dist_txt))
					Begin SQL
						select [Town Address].[ContactPhone]
						from [Town Address]
						where
						[Town Address].[OfficialTownName] = :v_78_004_txt
						into :SCPOA_TrafEqDBE_txt
					End SQL
					[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
				End if 
				
			End if 
			
			SCPOA_ReOpenResp_txt:=ut_GetSysParameter("SCPOA_4B_Agency"; "MassDOT District Bridge Engineer")  //section 4b - Agency
			
			Case of 
				: ([Bridge MHD NBIS:1]Item8 Owner:208="DOT")
					If (SCPOA_Contacts_txt="")
						SCPOA_Contacts_txt:=ut_GetSysParameter("SCPOA_3F_DOT")
					End if 
					If (SCPOA_BrgClosure_txt="")
						SCPOA_BrgClosure_txt:=ut_GetSysParameter("SCPOA_3C_DOT")
					End if 
					//these two are not enterable
					SCPOA_ClosureResp_txt:=ut_GetSysParameter("SCPOA_3E_DOT"; "MassDOT District Bridge Engineer")  // section 3e
					SCPOA_PostFldMonAgc_txt:=ut_GetSysParameter("SCPOA_2E_Agency_DOT"; "MassDOT District Bridge Engineer")  //section 2e - Agency
					
				: ([Bridge MHD NBIS:1]Item8 Owner:208="MUN")
					If (SCPOA_Contacts_txt="")
						SCPOA_Contacts_txt:=ut_GetSysParameter("SCPOA_3F_MUN")
					End if 
					If (SCPOA_BrgClosure_txt="")
						SCPOA_BrgClosure_txt:=ut_GetSysParameter("SCPOA_3C_MUN")
					End if 
					//these two are not enterable
					SCPOA_ClosureResp_txt:=ut_GetSysParameter("SCPOA_3E_MUN"; "Local Bridge Owner")  // section 3e
					SCPOA_PostFldMonAgc_txt:=ut_GetSysParameter("SCPOA_2E_Agency_MUN"; "Local Bridge Owner")  //section 2e - Agency
					
				Else 
					//default to DOT settings
					If (SCPOA_Contacts_txt="")
						SCPOA_Contacts_txt:=ut_GetSysParameter("SCPOA_3F_"+SCPOA_Owner_txt; ut_GetSysParameter("SCPOA_3F_DOT"))
					End if 
					If (SCPOA_BrgClosure_txt="")
						SCPOA_BrgClosure_txt:=ut_GetSysParameter("SCPOA_3C_"+SCPOA_Owner_txt; ut_GetSysParameter("SCPOA_3C_DOT"))
					End if 
					//these two are not enterable
					SCPOA_ClosureResp_txt:=ut_GetSysParameter("SCPOA_3E_"+SCPOA_Owner_txt; "MassDOT District Bridge Engineer")  // section 3e
					SCPOA_PostFldMonAgc_txt:=ut_GetSysParameter("SCPOA_2E_Agency_"+SCPOA_Owner_txt; "MassDOT District Bridge Engineer")  //section 2e - Agency
					
			End case 
		End if 
		SCPOA_MonitorChecks
		SCPOA_Variables("GETUWINSPECTS")
		
		If (Type:C295(SCPOA_NWSSites_atxt)=Text array:K8:16)
			SCPOA_NWSSites_atxt:=0
			
			If (SCPOA_NWSStation_txt#"")
				C_LONGINT:C283($Kfound_L)
				$Kfound_L:=Find in array:C230(SCPOA_NWSSites_atxt; (SCPOA_NWSStation_txt+"@"))
				If ($Kfound_L>0)
					SCPOA_NWSSites_atxt:=$Kfound_L
				End if 
				
			End if 
			
		End if 
		
	: ($Action_txt="LOADFROMBLOB")
		BLOB PROPERTIES:C536([ScourPOA:132]StoreBlob_x:24; $compr_L; $blobExpSize_L; $blbsize_L)
		If ($blbsize_L>0)
			$tempBlb:=[ScourPOA:132]StoreBlob_x:24
			If ($compr_L#Is not compressed:K22:11)
				EXPAND BLOB:C535($tempBlb)
			End if 
			C_LONGINT:C283($BlbOffset)
			$BlbOffset:=0
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ComplCNT_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PropCNT_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PropCNT_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CntNotReq_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_InstCNT_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_RipRap_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Guide_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Spurs_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Relief_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Chann_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Monit_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_MonitDev_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_ChkDam_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_SubMod_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_BrgRepl_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Other_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Other_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_RipRap_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Guide_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Spurs_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Relief_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Chann_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Monit_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_MonitDev_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_ChkDam_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_SubMod_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_BrgRepl_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Other_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CloseBrg_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PropConsPrj_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_MaintPrj_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_LeadAgency_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SchedInfo_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ImplAdDate; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_MonPlan_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_MonitorAuth_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_RegInpPrg_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_RegFreq_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_RegInpPrg_Surv_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_WatchReg_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_IncrInspPrg_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_IncrInspFreq_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_IncrInspPrg_Surv_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_WatchIncr_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_UWInspPrg_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_UWInspPrgFreq_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_WatchUW_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FixMonitDev_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_InstTYpe_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_InstLoc_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SamplOther_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DataFreqOther_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ScCritDisch_R; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ScCritAction_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OtherMonitDev_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OtherMonitVis_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OtherMonitinstr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthMonInstrType_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthMonFldMonReqY_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthMonFldMonReqN_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DischOvr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Stage_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ElevMeas_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DischOvrFeet_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Stage_s; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ElevMeas_R; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthFldMonFreq_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthScCritElev_R; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthScCritAction_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrADT_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_TruckPct_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrLen_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgClosure_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_wSurf_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_wSurf_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_Over_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_ScMeas_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_RipLoss_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_Settlm_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_EmbkLoss_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_Debris_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_Other_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_Other_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ClosureResp_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Contacts_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ReOpenResp_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DetourDesc_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AvgADT_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AvgADTYear_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AvgADTTrckPct_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DetourBrgLen_r; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PhotoRecs_aL; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item8_c_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item113_c_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item60_c_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item61_c_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item71_c_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FinalRec_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Owner_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DateComp_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_LastInsp_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OtherAttach_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PrioCounter_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PrioMonitor_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Summ_IncInspF_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Summ_FloodMon_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Summ_PostFlood_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Summ_FixMonitDev_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Summ_Counter_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_POAAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PhotoAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DetourAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ElevAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BoringAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SurveyAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CalcAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PlanAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FieldAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OtherAttach_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_POAEval_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_POAHist_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_WatchIncrUW_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FixedTerm_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_UWIncrInspPrg_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_UWIncrInspPrgFreq_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_NotifPublic_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FLMTerm_CloseB_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FLMTerm_Revisit_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FLMTerm_RecPost_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FLMTerm_Stable_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldVis_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldRvBed_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldProfSubstr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldUnderm_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldWatch_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldElevs_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldAction_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OtherProj_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OtherMaintPrj_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloWater_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloCritElev_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloReasAbate_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloVerifyElev_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloStreamEl_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloStreamElAbove_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloInspCompl_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloDiveCompl_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloStreamElNo_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloStreamElAbNo_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ReopenResp_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloDiveCompl_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLRegIncrY_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLRegIncrN_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLUWIncrY_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLUWIncrN_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLFixMonY_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLFixMonN_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLFldMonY_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLFldMonN_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLPFldMonY_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummIMPLPFldMonN_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SourceObserv_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SourceAssess_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SourceCalc_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SourceOther_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SourceOther_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AbutSCElev_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AbutSCChordDist_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PierSCElev_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PierSCChordDist_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_EmergFacYN_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_EmergFac_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SummOtherAttach_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FldForecast_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FldWarnSys_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FldForecast_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FldWarnSys_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_POAUpdateFreq_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_POANextUpdate_d; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFlood_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgOpenPendDive_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CSamp30min_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CSamp1hr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CSamp6hr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CSamp12hr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CSampOther_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CDwnldDay_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CDwnldWk_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CDwnldMo_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CDwnldOther_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtSampCont_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtSamp10m_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtSamp30m_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtSamp1hr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtSampOth_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtFreqDay_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtFreqWk_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtFreqMo_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtFreqOth_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtSamplOther_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2CEvtFreqOther_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2cEvtScCritAction_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2cEvtFixedTerm_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthMonInstrPort_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthMonInstrGeo_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthMonInstrSon_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthMonInstrOth_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DOTSitRept_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_USGSStation_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_USGSStationNo_s; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2DFreqCont_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2DFreq3Hr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2DFreq12Hr_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2DFreqDay_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_2DFreqOther_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ImplAdDate_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AbutElevRef_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PierElevRef_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FlMonLookFor_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_EvtMonitSampl_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_EvtDataLogFreq_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_HydRptAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Summ_UWIncInspF_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DataFreqOtherDesc_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SamplOtherDesc_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthFldMonFreqDesc_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_EvtSamplOther_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_EvtDataFreqOther_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ScCritDisch_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthScCritElev_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DischOvrFeet_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloStreamElNo_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgCloStreamElAbNo_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Placard_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_Placard_r; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_IncrInspPrg_Addtl_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_IncrInspPrg_Addtl_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AbutSCCritical_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PierSCCritical_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_MonitorCalcAttach_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_USGSStationURL_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_USGSStationNo2_s; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Stage2_s; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_DischOvrFeet2_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_USGSStationURL2_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_NWSStation_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_NWSStationURL_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FVCAttach_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_WaterSurf_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_WaterSurf_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_7BContactPers_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_7BInstallBy_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AbutSCCritiEmbed_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AbutSCCritiExpos_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AddtlCritCons_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Appr2Date_d; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Appr3Date_d; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ApprBy2_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ApprBy3_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ApproachNotSettl_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_AssessRvrBedOK_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrADTYr_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrgRailStraight_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrLat_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrLon_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrNoSpans_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_NOAAG_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_NOAAG_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_NOAAI_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_NOAANo_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_NOAANo_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_NWS_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_USGSD_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_USGSD_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_USGSG_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_USGSG_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_USGSNo_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_USGSNo_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_WLvl_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_WLvl_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CNTNotReq_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CritStrElmOK_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CritWSEMarkLoc_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Descr2_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Dist_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_EmbErosOK_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FixedDevProced_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_FixMonDevWarn_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ImplSchedCompDate; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_GroutB_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_GroutB_r; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_BrgRepl_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_Chann_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_ChkDam_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_GroutB_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_Guide_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_Monit_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_MonitDev_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_Other_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_Relief_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_RipRap_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_Spurs_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_SubMod_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Inst_L_WaterSurf_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item106_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item113_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item27_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item60_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item61_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item6a_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item7_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item71_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Item8_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_NOAAStation_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PierSCCritiEmbed_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PierSCCritiExpos_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldContact_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldMonAgc_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldProbing_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PostFldUWInsp_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PreExistCond_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_PrevMonForm_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_RecFixMonitDev_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_RoutineDate_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ScourCritFeat_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SCPRIO_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_SourceRefs_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_substrPlumb_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Summ_IncUWF_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_TrafEqDBE_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_TrafEqDist_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_TrafEqLoc_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_USGSSt2ProxBrg_s; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_USGSStProxBrg_s; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_UWInspRptAvail_L; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_UWInspRptAvailDates_txt; $BlbOffset)  //  SCPOA_InpFormMethod 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_YrRehab_txt; $BlbOffset)  //  SCPOA_PrintPG1_FM 
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_Nav88_NGVD29_txt; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_BrStructType_txt; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ChannelFreqCur_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_ChannelFreqRec_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_LowChordDist_L; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_LowChordDistFt_r; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_StructCounter_L; $BlbOffset)
			
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_CLCri_WLvl_r; $BlbOffset)
			BLOB TO VARIABLE:C533($tempBlb; SCPOA_OthScCritElev_r; $BlbOffset)
			
		End if 
		SET BLOB SIZE:C606($tempBlb; 0)
		
	: ($Action_txt="SAVE")
		
		If (SCPOA_Desc1Chg_b)
			VARIABLE TO BLOB:C532(SCPOA_Descr1_txt; [ScourPOA:132]ScourEvalSummary:6)
			COMPRESS BLOB:C534([ScourPOA:132]ScourEvalSummary:6)
			PushChange(1; ->[ScourPOA:132]ScourEvalSummary:6)
		End if 
		If (SCPOA_Desc2Chg_b)
			VARIABLE TO BLOB:C532(SCPOA_Descr2_txt; [ScourPOA:132]ScourHistory:7)
			COMPRESS BLOB:C534([ScourPOA:132]ScourHistory:7)
			PushChange(1; ->[ScourPOA:132]ScourHistory:7)
		End if 
		C_BLOB:C604($tempBlb)
		
		VARIABLE TO BLOB:C532(SCPOA_ComplCNT_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PropCNT_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PropCNT_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CntNotReq_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_InstCNT_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_RipRap_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Guide_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Spurs_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Relief_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Chann_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Monit_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_MonitDev_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_ChkDam_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_SubMod_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_BrgRepl_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Other_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Other_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_RipRap_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Guide_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Spurs_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Relief_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Chann_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Monit_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_MonitDev_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_ChkDam_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_SubMod_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_BrgRepl_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Other_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CloseBrg_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PropConsPrj_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_MaintPrj_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_LeadAgency_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SchedInfo_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ImplAdDate; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_MonPlan_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_MonitorAuth_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_RegInpPrg_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_RegFreq_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_RegInpPrg_Surv_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_WatchReg_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_IncrInspPrg_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_IncrInspFreq_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_IncrInspPrg_Surv_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_WatchIncr_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_UWInspPrg_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_UWInspPrgFreq_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_WatchUW_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FixMonitDev_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_InstTYpe_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_InstLoc_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SamplOther_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DataFreqOther_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ScCritDisch_R; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ScCritAction_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OtherMonitDev_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OtherMonitVis_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OtherMonitinstr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthMonInstrType_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthMonFldMonReqY_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthMonFldMonReqN_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DischOvr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Stage_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ElevMeas_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DischOvrFeet_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Stage_s; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ElevMeas_R; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthFldMonFreq_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthScCritElev_R; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthScCritAction_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrADT_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_TruckPct_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrLen_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgClosure_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_wSurf_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_wSurf_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_Over_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_ScMeas_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_RipLoss_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_Settlm_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_EmbkLoss_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_Debris_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_Other_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CLCri_Other_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ClosureResp_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Contacts_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ReOpenResp_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DetourDesc_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_AvgADT_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_AvgADTYear_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_AvgADTTrckPct_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DetourBrgLen_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PhotoRecs_aL; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_Item8_c_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Item113_c_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Item60_c_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Item61_c_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Item71_c_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FinalRec_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Owner_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DateComp_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_LastInsp_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OtherAttach_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_PrioCounter_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PrioMonitor_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Summ_IncInspF_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Summ_FloodMon_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Summ_PostFlood_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Summ_FixMonitDev_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Summ_Counter_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_POAAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PhotoAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DetourAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ElevAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BoringAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SurveyAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_CalcAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PlanAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FieldAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OtherAttach_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_POAEval_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_POAHist_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_WatchIncrUW_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FixedTerm_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_UWIncrInspPrg_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_UWIncrInspPrgFreq_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_NotifPublic_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FLMTerm_CloseB_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FLMTerm_Revisit_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_FLMTerm_RecPost_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FLMTerm_Stable_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_PostFldVis_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PostFldRvBed_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PostFldProfSubstr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PostFldUnderm_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_PostFldWatch_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PostFldElevs_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PostFldAction_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OtherProj_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_OtherMaintPrj_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_BrgCloWater_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloCritElev_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloReasAbate_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloVerifyElev_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloStreamEl_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloStreamElAbove_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_BrgCloInspCompl_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloDiveCompl_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloStreamElNo_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloStreamElAbNo_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_ReopenResp_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloDiveCompl_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLRegIncrY_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLRegIncrN_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLUWIncrY_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLUWIncrN_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLFixMonY_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLFixMonN_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLFldMonY_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLFldMonN_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLPFldMonY_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SummIMPLPFldMonN_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_SourceObserv_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SourceAssess_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SourceCalc_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SourceOther_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_SourceOther_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_AbutSCElev_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_AbutSCChordDist_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PierSCElev_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PierSCChordDist_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_EmergFacYN_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_EmergFac_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_SummOtherAttach_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_FldForecast_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FldWarnSys_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FldForecast_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FldWarnSys_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_POAUpdateFreq_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_POANextUpdate_d; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_PostFlood_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgOpenPendDive_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_2CSamp30min_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CSamp1hr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CSamp6hr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CSamp12hr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CSampOther_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CDwnldDay_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CDwnldWk_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CDwnldMo_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CDwnldOther_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtSampCont_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtSamp10m_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtSamp30m_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtSamp1hr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtSampOth_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtFreqDay_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtFreqWk_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtFreqMo_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtFreqOth_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtSamplOther_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2CEvtFreqOther_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2cEvtScCritAction_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2cEvtFixedTerm_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthMonInstrPort_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthMonInstrGeo_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthMonInstrSon_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthMonInstrOth_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DOTSitRept_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_USGSStation_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_USGSStationNo_s; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2DFreqCont_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2DFreq3Hr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2DFreq12Hr_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2DFreqDay_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_2DFreqOther_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ImplAdDate_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_AbutElevRef_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PierElevRef_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_FlMonLookFor_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_EvtMonitSampl_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_EvtDataLogFreq_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_HydRptAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Summ_UWIncInspF_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DataFreqOtherDesc_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_SamplOtherDesc_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthFldMonFreqDesc_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_EvtSamplOther_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_EvtDataFreqOther_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_ScCritDisch_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthScCritElev_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DischOvrFeet_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloStreamElNo_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_BrgCloStreamElAbNo_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_Inst_Placard_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_Placard_r; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_IncrInspPrg_Addtl_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_IncrInspPrg_Addtl_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_AbutSCCritical_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_PierSCCritical_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_MonitorCalcAttach_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_USGSStationURL_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_USGSStationNo2_s; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Stage2_s; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_DischOvrFeet2_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_USGSStationURL2_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_NWSStation_txt; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_NWSStationURL_txt; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_FVCAttach_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_WaterSurf_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_Inst_WaterSurf_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_7BContactPers_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_7BInstallBy_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_AbutSCCritiEmbed_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_AbutSCCritiExpos_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_AddtlCritCons_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Appr2Date_d; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Appr3Date_d; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_ApprBy2_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_ApprBy3_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_ApproachNotSettl_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_AssessRvrBedOK_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_BrADTYr_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_BrgRailStraight_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_BrLat_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_BrLon_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_BrNoSpans_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_NOAAG_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_NOAAG_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_NOAAI_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_NOAANo_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_NOAANo_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_NWS_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_USGSD_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_USGSD_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_USGSG_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_USGSG_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_USGSNo_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_USGSNo_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_WLvl_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CLCri_WLvl_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CNTNotReq_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CritStrElmOK_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_CritWSEMarkLoc_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Descr2_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Dist_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_EmbErosOK_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_FixedDevProced_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_FixMonDevWarn_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_ImplSchedCompDate; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_GroutB_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_GroutB_r; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_BrgRepl_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_Chann_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_ChkDam_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_GroutB_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_Guide_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_Monit_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_MonitDev_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_Other_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_Relief_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_RipRap_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_Spurs_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_SubMod_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Inst_L_WaterSurf_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Item106_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item113_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item27_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item60_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item61_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item6a_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item7_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item71_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Item8_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_NOAAStation_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PierSCCritiEmbed_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PierSCCritiExpos_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PostFldContact_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PostFldMonAgc_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PostFldProbing_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PostFldUWInsp_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PreExistCond_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_PrevMonForm_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_RecFixMonitDev_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_RoutineDate_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_ScourCritFeat_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_SCPRIO_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_SourceRefs_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_substrPlumb_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_Summ_IncUWF_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_TrafEqDBE_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_TrafEqDist_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_TrafEqLoc_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_USGSSt2ProxBrg_s; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_USGSStProxBrg_s; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_UWInspRptAvail_L; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_UWInspRptAvailDates_txt; $tempBlb; *)  //  SCPOA_InpFormMethod 
		VARIABLE TO BLOB:C532(SCPOA_YrRehab_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_Nav88_NGVD29_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		VARIABLE TO BLOB:C532(SCPOA_BrStructType_txt; $tempBlb; *)  //  SCPOA_PrintPG1_FM 
		
		VARIABLE TO BLOB:C532(SCPOA_ChannelFreqCur_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_ChannelFreqRec_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_LowChordDist_L; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_LowChordDistFt_r; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_StructCounter_L; $tempBlb; *)
		
		VARIABLE TO BLOB:C532(SCPOA_CLCri_WLvl_r; $tempBlb; *)
		VARIABLE TO BLOB:C532(SCPOA_OthScCritElev_r; $tempBlb; *)
		
		COMPRESS BLOB:C534($tempBlb)
		[ScourPOA:132]StoreBlob_x:24:=$tempBlb
		PushChange(1; ->[ScourPOA:132]StoreBlob_x:24)
		SET BLOB SIZE:C606($tempBlb; 0)
		
	: ($Action_txt="PRINTPG1")
		C_PICTURE:C286(SCPOA_Pict1; SCPOA_Pict2; SCPOA_Pict3; SCPOA_Pict4)
		C_TEXT:C284(SCPOA_Pic1Lbl_txt; SCPOA_Pic2Lbl_txt; SCPOA_Pic3Lbl_txt; SCPOA_Pic4Lbl_txt)
		C_LONGINT:C283($numPics; $i)
		ARRAY LONGINT:C221($SeqCopy_aL; 0)
		ARRAY LONGINT:C221($RecNumCopy_aL; 0)
		COPY ARRAY:C226(SCPOA_PhotoSeq_aL; $SeqCopy_aL)
		COPY ARRAY:C226(SCPOA_PhotoRecs_aL; $RecNumCopy_aL)
		
		SORT ARRAY:C229($SeqCopy_aL; $RecNumCopy_aL)
		CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; $RecNumCopy_aL)
		$numPics:=Records in selection:C76([ScourPOA_Images:134])
		If ($numPics>0)
			C_POINTER:C301($PicVar_ptr; $DescVar_ptr)
			C_PICTURE:C286($TempPic)
			READ ONLY:C145([ScourPOA_Images:134])
			For ($i; 1; $numPics)
				If ($i<=4)
					$PicVar_ptr:=Get pointer:C304("SCPOA_Pict"+String:C10($i))
					$DescVar_ptr:=Get pointer:C304("SCPOA_Pic"+String:C10($i)+"Lbl_txt")
					GOTO SELECTED RECORD:C245([ScourPOA_Images:134]; $i)
					LOAD RECORD:C52([ScourPOA_Images:134])
					If (BLOB size:C605([ScourPOA_Images:134]Image_x:3)>0)
						BLOB TO PICTURE:C682([ScourPOA_Images:134]Image_x:3; $TempPic)
						$PicVar_ptr->:=$TempPic
					Else 
						$PicVar_ptr->:=$TempPic*0
					End if 
					$DescVar_ptr->:=[ScourPOA_Images:134]ImgDescr_txt:4
				End if 
				
				
			End for 
			READ WRITE:C146([ScourPOA_Images:134])
			$TempPic:=$TempPic*0
		End if 
		CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
		SCPOA_ApproveChkBx:=[ScourPOA:132]Approved:23
		SCPOA_CompleteChkBx:=Num:C11(f_Boolean2String([ScourPOA:132]Completed:21; "10"))
		SCPOA_PMReviewChkBox:=[ScourPOA:132]PMReviewed:29
		
	: ($Action_txt="DETOURBRIDGES")
		C_LONGINT:C283($numDetBridges_L)
		$numDetBridges_L:=Records in selection:C76([ScourPOA_DetourBridge:133])
		
		ARRAY TEXT:C222(SCPOA_DetBIns_atxt; $numDetBridges_L)
		ARRAY LONGINT:C221(SCPOA_DetBIns_aL; $numDetBridges_L)
		ARRAY LONGINT:C221(SCPOA_DetBInIDs_aL; $numDetBridges_L)
		ARRAY TEXT:C222(SCPOA_DetBDept_atxt; $numDetBridges_L)
		ARRAY TEXT:C222(SCPOA_DetI6A_atxt; $numDetBridges_L)
		ARRAY TEXT:C222(SCPOA_DetI7_atxt; $numDetBridges_L)
		ARRAY TEXT:C222(SCPOA_DetAASHTO_atxt; $numDetBridges_L)
		ARRAY TEXT:C222(SCPOA_DetI113_atxt; $numDetBridges_L)
		ARRAY REAL:C219(SCPOA_detAASHTO_ar; $numDetBridges_L)
		ARRAY TEXT:C222(SCPOA_detPosted_atxt; $numDetBridges_L)
		ARRAY LONGINT:C221(SCPOA_detPost2_AL; $numDetBridges_L)
		ARRAY LONGINT:C221(SCPOA_detPost3_AL; $numDetBridges_L)
		ARRAY LONGINT:C221(SCPOA_detPost5_AL; $numDetBridges_L)
		ARRAY LONGINT:C221(SCPOA_detADT_AL; $numDetBridges_L)
		ARRAY LONGINT:C221(SCPOA_detTrk_AL; $numDetBridges_L)
		ARRAY TEXT:C222(SCPOA_detPostVs_atxt; $numDetBridges_L)
		ARRAY REAL:C219(SCPOA_detVertCL_aR; $numDetBridges_L)
		ARRAY REAL:C219(SCPOA_detWidth_aR; $numDetBridges_L)
		
		ARRAY TEXT:C222($DetBDept_atxt; $numDetBridges_L)
		ARRAY TEXT:C222($DetBIns_atxt; $numDetBridges_L)
		ARRAY TEXT:C222($DetI6A_atxt; $numDetBridges_L)
		ARRAY TEXT:C222($DetI7_atxt; $numDetBridges_L)
		ARRAY TEXT:C222($DetAASHTO_atxt; $numDetBridges_L)
		ARRAY TEXT:C222($DetI113_atxt; $numDetBridges_L)
		ARRAY REAL:C219($detAASHTO_ar; $numDetBridges_L)
		ARRAY TEXT:C222($detPosted_atxt; $numDetBridges_L)
		ARRAY INTEGER:C220($detPost2_AL; $numDetBridges_L)
		ARRAY INTEGER:C220($detPost3_AL; $numDetBridges_L)
		ARRAY INTEGER:C220($detPost5_AL; $numDetBridges_L)
		ARRAY LONGINT:C221($detADT_AL; $numDetBridges_L)
		ARRAY INTEGER:C220($detTrk_AL; $numDetBridges_L)
		ARRAY REAL:C219($detItm51_ar; $numDetBridges_L)
		ARRAY REAL:C219($detItm53_ar; $numDetBridges_L)
		
		SELECTION TO ARRAY:C260([ScourPOA_DetourBridge:133]DetourBIN:3; SCPOA_DetBIns_atxt; [ScourPOA_DetourBridge:133]; SCPOA_DetBIns_aL; [ScourPOA_DetourBridge:133]DetourBridgeID_L:1; SCPOA_DetBInIDs_aL)
		QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; SCPOA_DetBIns_atxt)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $DetBIns_atxt; [Bridge MHD NBIS:1]BDEPT:1; $DetBDept_atxt; [Bridge MHD NBIS:1]Item6A:63; $DetI6A_atxt; [Bridge MHD NBIS:1]Item113:151; $DetI113_atxt; [Bridge MHD NBIS:1]AASHTO:5; $detAASHTO_ar)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]PostingStatus:8; $detPosted_atxt; [Bridge MHD NBIS:1]Posting2Axle:9; $detPost2_AL; [Bridge MHD NBIS:1]Posting3Axle:10; $detPost3_AL; [Bridge MHD NBIS:1]Posting5Axle:11; $detPost5_AL)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item7:65; $DetI7_atxt; [Bridge MHD NBIS:1]Item29:88; $detADT_AL; [Bridge MHD NBIS:1]Item109:90; $detTrk_AL; [Bridge MHD NBIS:1]Item51:96; $detItm51_ar; [Bridge MHD NBIS:1]Item53:105; $detItm53_ar)
		C_LONGINT:C283($Loop; $Pos_L)
		For ($Loop; 1; $numDetBridges_L)
			$Pos_L:=Find in array:C230($DetBIns_atxt; SCPOA_DetBIns_atxt{$Loop})
			SCPOA_DetBDept_atxt{$Loop}:=$DetBDept_atxt{$Pos_L}
			SCPOA_DetI6A_atxt{$Loop}:=$DetI6A_atxt{$Pos_L}
			SCPOA_DetI7_atxt{$Loop}:=$DetI7_atxt{$Pos_L}
			SCPOA_DetI113_atxt{$Loop}:=$DetI113_atxt{$Pos_L}
			SCPOA_detAASHTO_ar{$Loop}:=$detAASHTO_ar{$Pos_L}
			SCPOA_detPosted_atxt{$Loop}:=$detPosted_atxt{$Pos_L}
			If ($detPosted_atxt{$Pos_L}="POSTED")
				SCPOA_detPostVs_atxt{$Loop}:=String:C10($detPost2_AL{$Pos_L})+"-"+String:C10($detPost3_AL{$Pos_L})+"-"+String:C10($detPost5_AL{$Pos_L})
			Else 
				SCPOA_detPostVs_atxt{$Loop}:=""
			End if 
			SCPOA_detPost2_AL{$Loop}:=$detPost2_AL{$Pos_L}
			SCPOA_detPost3_AL{$Loop}:=$detPost3_AL{$Pos_L}
			SCPOA_detPost5_AL{$Loop}:=$detPost5_AL{$Pos_L}
			SCPOA_detADT_AL{$Loop}:=$detADT_AL{$Pos_L}
			SCPOA_detTrk_AL{$Loop}:=$detTrk_AL{$Pos_L}
			SCPOA_detWidth_aR{$Loop}:=Round:C94(3.280839895*$detItm51_ar{$Pos_L}; 1)
			If ($detItm53_ar{$Pos_L}>=99.99)
				SCPOA_detVertCL_aR{$Loop}:=-1  //as NA
			Else 
				SCPOA_detVertCL_aR{$Loop}:=Round:C94(3.280839895*$detItm53_ar{$Pos_L}; 1)
			End if 
			
		End for 
		
		ARRAY TEXT:C222($DetBDept_atxt; 0)
		ARRAY TEXT:C222($DetBIns_atxt; 0)
		ARRAY TEXT:C222($DetI6A_atxt; 0)
		ARRAY TEXT:C222($DetI7_atxt; 0)
		ARRAY TEXT:C222($DetAASHTO_atxt; 0)
		ARRAY TEXT:C222($DetI113_atxt; 0)
		ARRAY REAL:C219($detAASHTO_ar; 0)
		ARRAY TEXT:C222($detPosted_atxt; 0)
		ARRAY INTEGER:C220($detPost2_AL; 0)
		ARRAY INTEGER:C220($detPost3_AL; 0)
		ARRAY INTEGER:C220($detPost5_AL; 0)
		ARRAY LONGINT:C221($detADT_AL; 0)
		ARRAY INTEGER:C220($detTrk_AL; 0)
		SORT ARRAY:C229(SCPOA_DetBDept_atxt; SCPOA_DetBIns_atxt; SCPOA_DetBIns_aL; SCPOA_DetI6A_atxt; SCPOA_DetI7_atxt; SCPOA_DetAASHTO_atxt; SCPOA_DetI113_atxt; SCPOA_detAASHTO_ar; SCPOA_detPosted_atxt; SCPOA_detPost2_AL; SCPOA_detPost3_AL; SCPOA_detPost5_AL; SCPOA_detPostVs_atxt; SCPOA_DetBInIDs_aL; SCPOA_detADT_AL; SCPOA_detTrk_AL; SCPOA_detVertCL_aR; SCPOA_detWidth_aR)
		CREATE SELECTION FROM ARRAY:C640([ScourPOA_DetourBridge:133]; SCPOA_DetBIns_aL)
		
	: ($Action_txt="CLEARDETOURBRIDGES")
		ARRAY TEXT:C222(SCPOA_DetBIns_atxt; 0)
		ARRAY TEXT:C222(SCPOA_DetBDept_atxt; 0)
		ARRAY TEXT:C222(SCPOA_DetI6A_atxt; 0)
		ARRAY TEXT:C222(SCPOA_DetI7_atxt; 0)
		ARRAY TEXT:C222(SCPOA_DetAASHTO_atxt; 0)
		ARRAY TEXT:C222(SCPOA_detPosted_atxt; 0)
		ARRAY TEXT:C222(SCPOA_DetI113_atxt; 0)
		ARRAY REAL:C219(SCPOA_detAASHTO_ar; 0)
		ARRAY TEXT:C222(SCPOA_detPostVs_atxt; 0)
		ARRAY LONGINT:C221(SCPOA_detPost2_AL; 0)
		ARRAY LONGINT:C221(SCPOA_detPost3_AL; 0)
		ARRAY LONGINT:C221(SCPOA_detPost5_AL; 0)
		ARRAY LONGINT:C221(SCPOA_detADT_AL; 0)
		ARRAY LONGINT:C221(SCPOA_detTrk_AL; 0)
		ARRAY TEXT:C222(SCPOA_detPostVs_atxt; 0)
		ARRAY REAL:C219(SCPOA_detVertCL_aR; 0)
		ARRAY REAL:C219(SCPOA_detWidth_aR; 0)
		
	: ($Action_txt="INITPHOTOS")
		C_LONGINT:C283(SCPOA_IMAGETYPELIST_L; SCPOA_MaxFVPhotoIndx_L)
		C_TEXT:C284(SCPOA_PHOTOLISTMODE_TXT)
		SCPOA_PHOTOLISTMODE_TXT:="Inventory List"
		//SCPOA_IMAGETYPELIST_L = 1 : Inv photos
		//SCPOA_IMAGETYPELIST_L = 2 : Field Verification
		SCPOA_IMAGETYPELIST_L:=1  //start with inv photos
		SCPOA_MaxFVPhotoIndx_L:=99999
		ARRAY BOOLEAN:C223(SCPOAImagesListBox; 0)
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
		QUERY SELECTION:C341([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageType:5="Photo")
		ORDER BY:C49([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageSeq:6)
		SCPOA_Variables("PHOTOS")
		
	: ($Action_txt="PHOTOS")
		C_LONGINT:C283($numPhotos_L)
		$numPhotos_L:=Records in selection:C76([ScourPOA_Images:134])
		
		ARRAY TEXT:C222(SCPOA_PhotoDesc_atxt; $numPhotos_L)
		ARRAY LONGINT:C221(SCPOA_PhotoIDs_aL; $numPhotos_L)
		ARRAY LONGINT:C221(SCPOA_PhotoSeq_aL; $numPhotos_L)
		ARRAY LONGINT:C221(SCPOA_PhotoRecs_aL; $numPhotos_L)
		ARRAY LONGINT:C221(SCPOA_FVPhotoSeq_aL; $numPhotos_L)
		SELECTION TO ARRAY:C260([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL; [ScourPOA_Images:134]ImgDescr_txt:4; SCPOA_PhotoDesc_atxt; [ScourPOA_Images:134]ScourPOAImgID:1; SCPOA_PhotoIDs_aL; [ScourPOA_Images:134]ImageSeq:6; SCPOA_PhotoSeq_aL; [ScourPOA_Images:134]OnPage1:7; SCPOA_FVPhotoSeq_aL)
		C_LONGINT:C283($loop_L; $maxcurrFV_L)
		$maxcurrFV_L:=0
		For ($loop_L; 1; Size of array:C274(SCPOA_FVPhotoSeq_aL))
			If (SCPOA_FVPhotoSeq_aL{$loop_L}>$maxcurrFV_L)
				$maxcurrFV_L:=SCPOA_FVPhotoSeq_aL{$loop_L}
			End if 
		End for 
		For ($loop_L; 1; Size of array:C274(SCPOA_FVPhotoSeq_aL))
			If (SCPOA_FVPhotoSeq_aL{$loop_L}=0)
				$maxcurrFV_L:=$maxcurrFV_L+1
				SCPOA_FVPhotoSeq_aL{$loop_L}:=$maxcurrFV_L
			End if 
			
		End for 
		
	: ($Action_txt="CLEARPHOTOS")
		ARRAY TEXT:C222(SCPOA_PhotoDesc_atxt; 0)
		ARRAY LONGINT:C221(SCPOA_PhotoIDs_aL; 0)
		ARRAY LONGINT:C221(SCPOA_PhotoSeq_aL; 0)
		ARRAY LONGINT:C221(SCPOA_PhotoRecs_aL; 0)
		ARRAY LONGINT:C221(SCPOA_FVPhotoSeq_aL; 0)
		
	: ($Action_txt="REVIEWSCREENINIT")
		ARRAY TEXT:C222(SCPOA_Rev_BIN_atxt; 0)
		ARRAY TEXT:C222(SCPOA_Rev_BDEPT_atxt; 0)
		ARRAY TEXT:C222(SCPOA_Rev_CONS_atxt; 0)
		ARRAY LONGINT:C221(SCPOA_Rev_Compl_aL; 0)
		ARRAY DATE:C224(SCPOA_Rev_Compl_ad; 0)
		ARRAY LONGINT:C221(SCPOA_Rev_PMReview_aL; 0)
		ARRAY DATE:C224(SCPOA_Rev_PMReview_ad; 0)
		ARRAY LONGINT:C221(SCPOA_Rev_ABEReview_aL; 0)
		ARRAY DATE:C224(SCPOA_Rev_ABEReview_ad; 0)
		ARRAY LONGINT:C221(SCPOA_Rev_RecNum_aL; 0)
		
	: ($Action_txt="REVIEWSCREENLOAD")
		C_LONGINT:C283($Recs_L)
		$Recs_L:=Records in selection:C76([ScourPOA:132])
		ARRAY TEXT:C222(SCPOA_Rev_BIN_atxt; $Recs_L)
		ARRAY TEXT:C222(SCPOA_Rev_BDEPT_atxt; $Recs_L)
		ARRAY TEXT:C222(SCPOA_Rev_CONS_atxt; $Recs_L)
		ARRAY LONGINT:C221(SCPOA_Rev_Compl_aL; $Recs_L)
		ARRAY DATE:C224(SCPOA_Rev_Compl_ad; $Recs_L)
		ARRAY LONGINT:C221(SCPOA_Rev_PMReview_aL; $Recs_L)
		ARRAY DATE:C224(SCPOA_Rev_PMReview_ad; $Recs_L)
		ARRAY LONGINT:C221(SCPOA_Rev_ABEReview_aL; $Recs_L)
		ARRAY DATE:C224(SCPOA_Rev_ABEReview_ad; $Recs_L)
		ARRAY LONGINT:C221(SCPOA_Rev_RecNum_aL; $Recs_L)
		ARRAY BOOLEAN:C223($SCPOA_Rev_Compl_ab; $Recs_L)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		SELECTION TO ARRAY:C260([ScourPOA:132]BIN:2; SCPOA_Rev_BIN_atxt; [ScourPOA:132]; SCPOA_Rev_RecNum_aL; [ScourPOA:132]Consultant:26; SCPOA_Rev_CONS_atxt; [ScourPOA:132]Completed:21; $SCPOA_Rev_Compl_ab; [ScourPOA:132]DateCompleted:8; SCPOA_Rev_Compl_ad; [Bridge MHD NBIS:1]BDEPT:1; SCPOA_Rev_BDEPT_atxt)
		SELECTION TO ARRAY:C260([ScourPOA:132]PMReviewed:29; SCPOA_Rev_PMReview_aL; [ScourPOA:132]PMReviewDate:28; SCPOA_Rev_PMReview_ad; [ScourPOA:132]Approved:23; SCPOA_Rev_ABEReview_aL; [ScourPOA:132]DateApproved:5; SCPOA_Rev_ABEReview_ad)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($SCPOA_Rev_Compl_ab))
			SCPOA_Rev_Compl_aL{$loop_L}:=Num:C11(f_Boolean2String($SCPOA_Rev_Compl_ab{$loop_L}; "10"))
		End for 
		
	: ($Action_txt="OLDNEWVERSION")
		C_BOOLEAN:C305(SCPOA_OldVersion_b)
		SCPOA_OldVersion_b:=False:C215
		If ((GRP_UserInGroup("SCPOA_Proj@")=1) | (GRP_UserInGroup("SCPOA_App@")=1) | (GRP_UserInGroup("SCPOA_MultipleView")=1) | User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			CONFIRM:C162(<>CurrentUser_Name+" : Old or new version?"; "Old"; "New")
			SCPOA_OldVersion_b:=(OK=1)
		End if 
		
	: ($Action_txt="SETVERSION")
		//default is the New Version
		C_BOOLEAN:C305(SCPOA_OldVersion_b; SCPOA_MultipleVer_b)
		SCPOA_MultipleVer_b:=False:C215
		SCPOA_OldVersion_b:=False:C215
		If ((GRP_UserInGroup("SCPOA_Proj@")=1) | (GRP_UserInGroup("SCPOA_App@")=1) | (GRP_UserInGroup("SCPOA_MultipleView")=1) | User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			SCPOA_MultipleVer_b:=True:C214
		End if 
		
	: ($Action_txt="GETUWINSPECTS")
		C_BOOLEAN:C305($inspRO_b)
		$inspRO_b:=Read only state:C362([Inspections:27])
		READ ONLY:C145([Inspections:27])
		QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[ScourPOA:132]BIN:2)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="DVE"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="DVL")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspComplete:168=True:C214)
		ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
		
		If (Records in selection:C76([Inspections:27])>0)
			REDUCE SELECTION:C351([Inspections:27]; 2)
			SCPOA_UWInspRptAvail_L:=1
			ARRAY DATE:C224($uwDates_ad; Records in selection:C76([Inspections:27]))
			SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $uwDates_ad)
			SCPOA_UWInspRptAvailDates_txt:=String:C10($uwDates_ad{1}; Internal date short:K1:7)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 2; Size of array:C274($uwDates_ad))
				SCPOA_UWInspRptAvailDates_txt:=SCPOA_UWInspRptAvailDates_txt+Char:C90(13)+String:C10($uwDates_ad{$loop_L}; Internal date short:K1:7)
			End for 
		End if 
		If (Not:C34($inspRO_b))
			READ WRITE:C146([Inspections:27])
		End if 
	: ($Action_txt="VERIFYRECACTIONS")
		If ((SCPOA_Inst_MonitDev_L+SCPOA_Inst_WaterSurf_L)>0)
			SCPOA_Inst_Monit_L:=1
		Else 
			SCPOA_Inst_Monit_L:=0
		End if 
		
		If ((SCPOA_Inst_RipRap_L+SCPOA_Inst_GroutB_L+SCPOA_Inst_Guide_L+SCPOA_Inst_Spurs_L+SCPOA_Inst_Chann_L+SCPOA_Inst_ChkDam_L+SCPOA_Inst_SubMod_L+SCPOA_Inst_Other_L)>0)
			SCPOA_StructCounter_L:=1
		Else 
			SCPOA_StructCounter_L:=0
		End if 
		
End case 