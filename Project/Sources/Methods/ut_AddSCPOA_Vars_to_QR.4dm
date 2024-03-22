//%attributes = {"invisible":true}
//Method: ut_AddSCPOA_Vars_to_QR
//Description
// Append columns containing ScourPOA variables to a quick report
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/23/13, 21:23:08
	// ----------------------------------------------------
	//Created : 
	Mods_2013_01
End if 
//

C_TEXT:C284($qrReportfle_txt)
C_TIME:C306($qrReportfle_t)
C_LONGINT:C283($LastCol_L)

$qrReportfle_t:=Open document:C264("")
If (OK=1)
	$qrReportfle_txt:=Document
	CLOSE DOCUMENT:C267($qrReportfle_t)
	C_BLOB:C604($QrReport_x)
	DOCUMENT TO BLOB:C525($qrReportfle_txt; $QrReport_x)
	
	C_LONGINT:C283($ModQRArea_)
	$ModQRArea_:=QR New offscreen area:C735
	QR BLOB TO REPORT:C771($ModQRArea_; $QrReport_x)
	
	$LastCol_L:=1+QR Count columns:C764($ModQRArea_)
	
	SCPOA_Variables("INIT")
	
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ComplCNT_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PropCNT_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PropCNT_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CntNotReq_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_InstCNT_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_RipRap_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Guide_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Spurs_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Relief_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Chann_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Monit_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_MonitDev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_ChkDam_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_SubMod_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_BrgRepl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Other_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Other_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_RipRap_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Guide_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Spurs_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Relief_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Chann_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Monit_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_MonitDev_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_ChkDam_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_SubMod_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_BrgRepl_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Other_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CloseBrg_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PropConsPrj_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_MaintPrj_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_LeadAgency_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SchedInfo_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ImplAdDate)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_MonPlan_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_MonitorAuth_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_RegInpPrg_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_RegFreq_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_RegInpPrg_Surv_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_WatchReg_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_IncrInspPrg_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_IncrInspFreq_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_IncrInspPrg_Surv_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_WatchIncr_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_UWInspPrg_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_UWInspPrgFreq_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_WatchUW_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FixMonitDev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_InstTYpe_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_InstLoc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SamplOther_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DataFreqOther_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ScCritDisch_R)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ScCritAction_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OtherMonitDev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OtherMonitVis_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OtherMonitinstr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthMonInstrType_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthMonFldMonReqY_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthMonFldMonReqN_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DischOvr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Stage_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ElevMeas_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DischOvrFeet_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Stage_s)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ElevMeas_R)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthFldMonFreq_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthScCritElev_R)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthScCritAction_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrADT_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_TruckPct_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrLen_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgClosure_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_wSurf_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_wSurf_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_Over_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_ScMeas_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_RipLoss_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_Settlm_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_EmbkLoss_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_Debris_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_Other_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_Other_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ClosureResp_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Contacts_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ReOpenResp_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DetourDesc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AvgADT_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AvgADTYear_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AvgADTTrckPct_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DetourBrgLen_r)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PhotoRecs_aL)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item8_c_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item113_c_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item60_c_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item61_c_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item71_c_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FinalRec_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Owner_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DateComp_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_LastInsp_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OtherAttach_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PrioCounter_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PrioMonitor_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Summ_IncInspF_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Summ_FloodMon_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Summ_PostFlood_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Summ_FixMonitDev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Summ_Counter_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_POAAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PhotoAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DetourAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ElevAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BoringAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SurveyAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CalcAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PlanAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FieldAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OtherAttach_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_POAEval_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_POAHist_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_WatchIncrUW_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FixedTerm_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_UWIncrInspPrg_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_UWIncrInspPrgFreq_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_NotifPublic_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FLMTerm_CloseB_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FLMTerm_Revisit_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FLMTerm_RecPost_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FLMTerm_Stable_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldVis_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldRvBed_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldProfSubstr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldUnderm_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldWatch_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldElevs_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldAction_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OtherProj_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OtherMaintPrj_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloWater_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloCritElev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloReasAbate_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloVerifyElev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloStreamEl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloStreamElAbove_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloInspCompl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloDiveCompl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloStreamElNo_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloStreamElAbNo_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ReopenResp_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloDiveCompl_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLRegIncrY_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLRegIncrN_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLUWIncrY_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLUWIncrN_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLFixMonY_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLFixMonN_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLFldMonY_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLFldMonN_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLPFldMonY_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummIMPLPFldMonN_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SourceObserv_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SourceAssess_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SourceCalc_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SourceOther_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SourceOther_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AbutSCElev_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AbutSCChordDist_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PierSCElev_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PierSCChordDist_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_EmergFacYN_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_EmergFac_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SummOtherAttach_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FldForecast_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FldWarnSys_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FldForecast_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FldWarnSys_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_POAUpdateFreq_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_POANextUpdate_d)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFlood_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgOpenPendDive_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CSamp30min_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CSamp1hr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CSamp6hr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CSamp12hr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CSampOther_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CDwnldDay_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CDwnldWk_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CDwnldMo_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CDwnldOther_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtSampCont_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtSamp10m_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtSamp30m_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtSamp1hr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtSampOth_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtFreqDay_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtFreqWk_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtFreqMo_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtFreqOth_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtSamplOther_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2CEvtFreqOther_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2cEvtScCritAction_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2cEvtFixedTerm_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthMonInstrPort_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthMonInstrGeo_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthMonInstrSon_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthMonInstrOth_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DOTSitRept_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_USGSStation_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_USGSStationNo_s)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2DFreqCont_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2DFreq3Hr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2DFreq12Hr_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2DFreqDay_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_2DFreqOther_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ImplAdDate_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AbutElevRef_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PierElevRef_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FlMonLookFor_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_EvtMonitSampl_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_EvtDataLogFreq_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_HydRptAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Summ_UWIncInspF_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DataFreqOtherDesc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SamplOtherDesc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthFldMonFreqDesc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_EvtSamplOther_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_EvtDataFreqOther_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ScCritDisch_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_OthScCritElev_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DischOvrFeet_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloStreamElNo_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgCloStreamElAbNo_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Placard_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_Placard_r)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_IncrInspPrg_Addtl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_IncrInspPrg_Addtl_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AbutSCCritical_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PierSCCritical_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_MonitorCalcAttach_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_USGSStationURL_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_USGSStationNo2_s)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Stage2_s)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_DischOvrFeet2_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_USGSStationURL2_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_NWSStation_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_NWSStationURL_txt)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FVCAttach_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_WaterSurf_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_WaterSurf_L)
	//
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_7BContactPers_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_7BInstallBy_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AbutSCCritiEmbed_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AbutSCCritiExpos_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AddtlCritCons_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Appr2Date_d)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Appr3Date_d)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ApprBy2_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ApprBy3_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ApproachNotSettl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_AssessRvrBedOK_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrADTYr_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrgRailStraight_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrLat_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrLon_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrNoSpans_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_NOAAG_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_NOAAG_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_NOAAI_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_NOAANo_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_NOAANo_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_NWS_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_USGSD_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_USGSD_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_USGSG_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_USGSG_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_USGSNo_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_USGSNo_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_WLvl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CLCri_WLvl_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CNTNotReq_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CritStrElmOK_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_CritWSEMarkLoc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Descr2_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Dist_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_EmbErosOK_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FixedDevProced_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_FixMonDevWarn_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ImplSchedCompDate)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_GroutB_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_GroutB_r)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_BrgRepl_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_Chann_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_ChkDam_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_GroutB_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_Guide_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_Monit_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_MonitDev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_Other_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_Relief_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_RipRap_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_Spurs_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_SubMod_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Inst_L_WaterSurf_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item106_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item113_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item27_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item60_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item61_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item6a_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item7_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item71_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Item8_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_NOAAStation_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PierSCCritiEmbed_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PierSCCritiExpos_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldContact_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldMonAgc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldProbing_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PostFldUWInsp_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PreExistCond_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_PrevMonForm_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_RecFixMonitDev_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_RoutineDate_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_ScourCritFeat_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SCPRIO_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_SourceRefs_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_substrPlumb_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Summ_IncUWF_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_TrafEqDBE_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_TrafEqDist_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_TrafEqLoc_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_USGSSt2ProxBrg_s)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_USGSStProxBrg_s)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_UWInspRptAvail_L)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_UWInspRptAvailDates_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_YrRehab_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_Nav88_NGVD29_txt)
	//QRUTIL_AddFldOrVar ($ModQRArea_;$LastCol_L;->SCPOA_BrStructType_txt)
	ut_scpoalist($ModQRArea_; $LastCol_L)
	
	QR REPORT TO BLOB:C770($ModQRArea_; $QrReport_x)
	
	$qrReportfle_t:=Create document:C266("")
	$qrReportfle_txt:=Document
	CLOSE DOCUMENT:C267($qrReportfle_t)
	
	BLOB TO DOCUMENT:C526($qrReportfle_txt; $QrReport_x)
	QR DELETE OFFSCREEN AREA:C754($ModQRArea_)
	
	SET BLOB SIZE:C606($QrReport_x; 0)
End if 
//End ut_AddSCPOA_Vars_to_QR