//%attributes = {"invisible":true}
//Method: SCPOA_FormTester
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/23/12, 20:36:50
	// ----------------------------------------------------
	//Created : 
	Mods_2012_02
	
	// Modified by: ManousakisC (7/19/2022)
	Mods_2022_09_bug
	// use picture name "BMS VertCLRSign" instead of RefID 886
End if 
//
C_TEXT:C284(SCPOA_SCHist_txt)
C_TEXT:C284(SCPOA_BDEPT_txt)
C_TEXT:C284(SCPOA_Dist_txt)
C_TEXT:C284(SCPOA_BIN_txt)
C_TEXT:C284(SCPOA_Town_txt)
C_TEXT:C284(SCPOA_Item8_txt)
C_TEXT:C284(SCPOA_Item7_txt)
C_TEXT:C284(SCPOA_BrName_txt)
C_TEXT:C284(SCPOA_Item27_txt)
C_TEXT:C284(SCPOA_Item106_txt)
C_TEXT:C284(SCPOA_YrRehab_txt)
C_TEXT:C284(SCPOA_Item6a_txt)
C_TEXT:C284(SCPOA_SCPRIO_txt)
C_TEXT:C284(SCPOA_Item60_txt)
C_TEXT:C284(SCPOA_Item61_txt)
C_TEXT:C284(SCPOA_Item71_txt)
C_PICTURE:C286(SCPOA_Pict1)
C_TEXT:C284(SCPOA_Pic1Lbl_txt)
C_PICTURE:C286(SCPOA_Pict2)
C_TEXT:C284(SCPOA_Pic2Lbl_txt)
C_PICTURE:C286(SCPOA_Pict3)
C_TEXT:C284(SCPOA_Pic3Lbl_txt)
C_PICTURE:C286(SCPOA_Pict4)
C_TEXT:C284(SCPOA_Pic4Lbl_txt)
C_TEXT:C284(SCPOA_Item113_txt)
C_TEXT:C284(SCPOA_RoutineDate_txt)
C_TEXT:C284(SCPOA_SourceRefs_txt)
C_TEXT:C284(SCPOA_AbutSCElev_txt)
C_TEXT:C284(SCPOA_AbutSCChordDist_txt)
C_TEXT:C284(SCPOA_PierSCChordDist_txt)
C_TEXT:C284(SCPOA_PierSCElev_txt)
C_LONGINT:C283(SCPOA_POAUpdateFreq_L)
C_DATE:C307(SCPOA_POANextUpdate_d)
C_TEXT:C284(SCPOA_AbutSCCritical_txt)
C_TEXT:C284(SCPOA_PierSCCritical_txt)
C_LONGINT:C283(SCPOA_CompleteChkBx_P)
C_LONGINT:C283(SCPOA_CompleteChkBx)
C_LONGINT:C283(SCPOA_SourceObserv_L_P)
C_LONGINT:C283(SCPOA_SourceObserv_L)
C_LONGINT:C283(SCPOA_SourceAssess_L_P)
C_LONGINT:C283(SCPOA_SourceAssess_L)
C_LONGINT:C283(SCPOA_SourceCalc_L_P)
C_LONGINT:C283(SCPOA_SourceCalc_L)
C_LONGINT:C283(SCPOA_SourceOther_L_P)
C_LONGINT:C283(SCPOA_SourceOther_L)
C_LONGINT:C283(SC_FTG_Unknown_P)
C_LONGINT:C283(SCPOA_FTMat_Unknown_P)
C_LONGINT:C283(SCPOA_BedMat_Unknown_P)
// C_WHAT(SCPOA_BedMat_Unknown)
C_LONGINT:C283(SCPOA_ApproveChkBx_2)
C_TEXT:C284(SCPOA_ComplDate_txt)
C_DATE:C307(SCPOA_Appr2Date_d)
C_DATE:C307(SCPOA_Appr3Date_d)
C_TEXT:C284(SCPOA_AbutSCCritiEmbed_txt)
C_TEXT:C284(SCPOA_AbutSCCritiExpos_txt)
C_TEXT:C284(SCPOA_PierSCCritiEmbed_txt)
C_TEXT:C284(SCPOA_PierSCCritiExpos_txt)
C_LONGINT:C283(SCPOA_SourceCalc_L_P)
C_LONGINT:C283(SCPOA_SourceCalc_L)
C_TEXT:C284(SCPOA_SourceOther_txt)
C_TEXT:C284(SCPOA_ApprBy2_txt)
C_TEXT:C284(SCPOA_ApprBy3_txt)
SCPOA_SCHist_txt:="Sample text"
SCPOA_BDEPT_txt:="Sample text"
VSINSPDEPARTMENT:="Sample text"
SCPOA_Dist_txt:="Sample text"
SCPOA_BIN_txt:="Sample text"
SCPOA_Town_txt:="Sample text"
SCPOA_Item8_txt:="Sample text"
SCPOA_Item7_txt:="Sample text"
SCPOA_BrName_txt:="Sample text"
SCPOA_Item27_txt:="Sample text"
SCPOA_Item106_txt:="Sample text"
SCPOA_YrRehab_txt:="Sample text"
SCPOA_Item6a_txt:="Sample text"
SCPOA_SCPRIO_txt:="Sample text"
SCPOA_Item60_txt:="Sample text"
SCPOA_Item61_txt:="Sample text"
SCPOA_Item71_txt:="Sample text"
GET PICTURE FROM LIBRARY:C565("BMS VertCLRSign"; SCPOA_Pict1)
SCPOA_Pic1Lbl_txt:="Sample text"
GET PICTURE FROM LIBRARY:C565("BMS VertCLRSign"; SCPOA_Pict2)
SCPOA_Pic2Lbl_txt:="Sample text"
GET PICTURE FROM LIBRARY:C565("BMS VertCLRSign"; SCPOA_Pict3)
SCPOA_Pic3Lbl_txt:="Sample text"
GET PICTURE FROM LIBRARY:C565("BMS VertCLRSign"; SCPOA_Pict4)
SCPOA_Pic4Lbl_txt:="Sample text"
SCPOA_Item113_txt:="Sample text"
SCPOA_RoutineDate_txt:="Sample text"
SCPOA_SourceRefs_txt:="Sample text"
SCPOA_AbutSCElev_txt:="Sample text"
SCPOA_AbutSCChordDist_txt:="Sample text"
SCPOA_PierSCChordDist_txt:="Sample text"
SCPOA_PierSCElev_txt:="Sample text"
SCPOA_POAUpdateFreq_L:=1
SCPOA_POANextUpdate_d:=!2011-01-01!
SCPOA_AbutSCCritical_txt:="Sample text"
SCPOA_PierSCCritical_txt:="Sample text"
SCPOA_CompleteChkBx_P:=1
SCPOA_CompleteChkBx:=1
SCPOA_SourceObserv_L_P:=1
SCPOA_SourceObserv_L:=1
SCPOA_SourceAssess_L_P:=1
SCPOA_SourceAssess_L:=1
SCPOA_SourceCalc_L_P:=1
SCPOA_SourceCalc_L:=1
SCPOA_SourceOther_L_P:=1
SCPOA_SourceOther_L:=1
SC_FTG_Unknown_P:=1
SC_FTG_Unknown:=1.5
SCPOA_FTMat_Unknown_P:=1
SCPOA_FTMat_Unknown:=1.5
SCPOA_BedMat_Unknown_P:=1
SCPOA_ApproveChkBx_2:=1
SCPOA_ComplDate_txt:="Sample text"
SCPOA_Appr2Date_d:=!2012-01-01!
SCPOA_Appr3Date_d:=!2012-01-01!
SCPOA_AbutSCCritiEmbed_txt:="Sample text"
SCPOA_AbutSCCritiExpos_txt:="Sample text"
SCPOA_PierSCCritiEmbed_txt:="Sample text"
SCPOA_PierSCCritiExpos_txt:="Sample text"
SCPOA_SourceCalc_L_P:=1
SCPOA_SourceCalc_L:=1
SCPOA_SourceOther_txt:="Sample text"
SCPOA_ApprBy2_txt:="Sample text"
SCPOA_ApprBy3_txt:="Sample text"

C_TEXT:C284(SCPOA_BDEPT_txt)
C_TEXT:C284(SCPOA_Dist_txt)
C_TEXT:C284(SCPOA_BIN_txt)
C_TEXT:C284(SCPOA_ComplDate_txt)
C_LONGINT:C283(SCPOA_SummPFldMonY_L_P)
C_LONGINT:C283(SCPOA_SummPFldMonY_L)
C_LONGINT:C283(SCPOA_SummPFldMonN_L_P)
C_LONGINT:C283(SCPOA_SummPFldMonN_L)
C_LONGINT:C283(SCPOA_SummIMPLPFldMonY_L_P)
C_LONGINT:C283(SCPOA_SummIMPLPFldMonY_L)
C_LONGINT:C283(SCPOA_SummIMPLPFldMonN_L_P)
C_LONGINT:C283(SCPOA_SummIMPLPFldMonN_L)
C_LONGINT:C283(SCPOA_SummFldMonY_L_P)
C_LONGINT:C283(SCPOA_SummFldMonY_L)
C_LONGINT:C283(SCPOA_SummFldMonN_L_P)
C_LONGINT:C283(SCPOA_SummFldMonN_L)
C_LONGINT:C283(SCPOA_SummIMPLFldMonY_L_P)
C_LONGINT:C283(SCPOA_SummIMPLFldMonY_L)
C_LONGINT:C283(SCPOA_SummIMPLFldMonN_L_P)
C_LONGINT:C283(SCPOA_SummIMPLFldMonN_L)
C_LONGINT:C283(SCPOA_SummFixMonY_L_P)
C_LONGINT:C283(SCPOA_SummFixMonY_L)
C_LONGINT:C283(SCPOA_SummFixMonN_L_P)
C_LONGINT:C283(SCPOA_SummFixMonN_L)
C_LONGINT:C283(SCPOA_SummIMPLFixMonY_L_P)
C_LONGINT:C283(SCPOA_SummIMPLFixMonY_L)
C_LONGINT:C283(SCPOA_SummIMPLFixMonN_L_P)
C_LONGINT:C283(SCPOA_SummIMPLFixMonN_L)
C_LONGINT:C283(SCPOA_SummUWIncrY_L_P)
C_LONGINT:C283(SCPOA_SummUWIncrY_L)
C_LONGINT:C283(SCPOA_SummUWIncrN_L_P)
C_LONGINT:C283(SCPOA_SummUWIncrN_L)
C_LONGINT:C283(SCPOA_SummIMPLUWIncrY_L_P)
C_LONGINT:C283(SCPOA_SummIMPLUWIncrY_L)
C_LONGINT:C283(SCPOA_SummIMPLUWIncrN_L_P)
C_LONGINT:C283(SCPOA_SummIMPLUWIncrN_L)
C_LONGINT:C283(SCPOA_RegInpPrg_L_P)
C_LONGINT:C283(SCPOA_RegInpPrg_L)
C_LONGINT:C283(SCPOA_RegInpPrg_Surv_L_P)
C_LONGINT:C283(SCPOA_RegInpPrg_Surv_L)
C_LONGINT:C283(SCPOA_IncrInspPrg_L_P)
C_LONGINT:C283(SCPOA_IncrInspPrg_L)
C_LONGINT:C283(SCPOA_IncrInspPrg_Surv_L_P)
C_LONGINT:C283(SCPOA_IncrInspPrg_Surv_L)
C_LONGINT:C283(SCPOA_UWInspPrg_L_P)
C_LONGINT:C283(SCPOA_UWInspPrg_L)
C_LONGINT:C283(SCPOA_UWIncrInspPrg_L_P)
C_LONGINT:C283(SCPOA_UWIncrInspPrg_L)
C_LONGINT:C283(SCPOA_FixMonitDev_L_P)
C_LONGINT:C283(SCPOA_FixMonitDev_L)
C_TEXT:C284(SCPOA_WatchReg_txt)
C_LONGINT:C283(SCPOA_UWInspPrgFreq_L)
C_TEXT:C284(SCPOA_WatchUW_txt)
C_LONGINT:C283(SCPOA_RegFreq_L)
C_LONGINT:C283(SCPOA_IncrInspFreq_L)
C_TEXT:C284(SCPOA_InstTYpe_txt)
C_TEXT:C284(SCPOA_InstLoc_txt)
C_TEXT:C284(SCPOA_ScCritAction_txt)
C_TEXT:C284(SCPOA_FixedTerm_txt)
C_LONGINT:C283(SCPOA_UWIncrInspPrgFreq_L)
C_LONGINT:C283(SCPOA_SummRegIncrY_L_P)
C_LONGINT:C283(SCPOA_SummRegIncrY_L)
C_LONGINT:C283(SCPOA_SummRegIncrN_L_P)
C_LONGINT:C283(SCPOA_SummRegIncrN_L)
C_LONGINT:C283(SCPOA_SummIMPLRegIncrY_L_P)
C_LONGINT:C283(SCPOA_SummIMPLRegIncrY_L)
C_LONGINT:C283(SCPOA_SummIMPLRegIncrN_L_P)
C_LONGINT:C283(SCPOA_SummIMPLRegIncrN_L)
C_LONGINT:C283(SCPOA_IncrInspPrg_Addtl_L_P)
C_LONGINT:C283(SCPOA_IncrInspPrg_Addtl_L)
C_TEXT:C284(SCPOA_IncrInspPrg_Addtl_txt)
C_LONGINT:C283(SCPOA_UWInspRptAvail_L_P)
C_LONGINT:C283(SCPOA_UWInspRptAvail_L)
C_TEXT:C284(SCPOA_UWInspRptAvailDates_txt)
C_LONGINT:C283(SCPOA_FixMonitDev_L_P)
C_LONGINT:C283(SCPOA_FixMonitDev_L)
C_TEXT:C284(SCPOA_FixedDevProced_txt)
SCPOA_BDEPT_txt:="Sample text"
SCPOA_Dist_txt:="Sample text"
SCPOA_BIN_txt:="Sample text"
SCPOA_ComplDate_txt:="Sample text"
SCPOA_SummPFldMonY_L_P:=1
SCPOA_SummPFldMonY_L:=1
SCPOA_SummPFldMonN_L_P:=1
SCPOA_SummPFldMonN_L:=1
SCPOA_SummIMPLPFldMonY_L_P:=1
SCPOA_SummIMPLPFldMonY_L:=1
SCPOA_SummIMPLPFldMonN_L_P:=1
SCPOA_SummIMPLPFldMonN_L:=1
SCPOA_SummFldMonY_L_P:=1
SCPOA_SummFldMonY_L:=1
SCPOA_SummFldMonN_L_P:=1
SCPOA_SummFldMonN_L:=1
SCPOA_SummIMPLFldMonY_L_P:=1
SCPOA_SummIMPLFldMonY_L:=1
SCPOA_SummIMPLFldMonN_L_P:=1
SCPOA_SummIMPLFldMonN_L:=1
SCPOA_SummFixMonY_L_P:=1
SCPOA_SummFixMonY_L:=1
SCPOA_SummFixMonN_L_P:=1
SCPOA_SummFixMonN_L:=1
SCPOA_SummIMPLFixMonY_L_P:=1
SCPOA_SummIMPLFixMonY_L:=1
SCPOA_SummIMPLFixMonN_L_P:=1
SCPOA_SummIMPLFixMonN_L:=1
SCPOA_SummUWIncrY_L_P:=1
SCPOA_SummUWIncrY_L:=1
SCPOA_SummUWIncrN_L_P:=1
SCPOA_SummUWIncrN_L:=1
SCPOA_SummIMPLUWIncrY_L_P:=1
SCPOA_SummIMPLUWIncrY_L:=1
SCPOA_SummIMPLUWIncrN_L_P:=1
SCPOA_SummIMPLUWIncrN_L:=1
SCPOA_RegInpPrg_L_P:=1
SCPOA_RegInpPrg_L:=1
SCPOA_RegInpPrg_Surv_L_P:=1
SCPOA_RegInpPrg_Surv_L:=1
SCPOA_IncrInspPrg_L_P:=1
SCPOA_IncrInspPrg_L:=1
SCPOA_IncrInspPrg_Surv_L_P:=1
SCPOA_IncrInspPrg_Surv_L:=1
SCPOA_UWInspPrg_L_P:=1
SCPOA_UWInspPrg_L:=1
SCPOA_UWIncrInspPrg_L_P:=1
SCPOA_UWIncrInspPrg_L:=1
SCPOA_FixMonitDev_L_P:=1
SCPOA_FixMonitDev_L:=1
SCPOA_WatchReg_txt:="Sample text"
SCPOA_UWInspPrgFreq_L:=1
SCPOA_WatchUW_txt:="Sample text"
SCPOA_RegFreq_L:=1
SCPOA_IncrInspFreq_L:=1
SCPOA_InstTYpe_txt:="Sample text"
SCPOA_InstLoc_txt:="Sample text"
SCPOA_ScCritAction_txt:="Sample text"
SCPOA_FixedTerm_txt:="Sample text"
SCPOA_UWIncrInspPrgFreq_L:=1
SCPOA_SummRegIncrY_L_P:=1
SCPOA_SummRegIncrY_L:=1
SCPOA_SummRegIncrN_L_P:=1
SCPOA_SummRegIncrN_L:=1
SCPOA_SummIMPLRegIncrY_L_P:=1
SCPOA_SummIMPLRegIncrY_L:=1
SCPOA_SummIMPLRegIncrN_L_P:=1
SCPOA_SummIMPLRegIncrN_L:=1
SCPOA_IncrInspPrg_Addtl_L_P:=1
SCPOA_IncrInspPrg_Addtl_L:=1
SCPOA_IncrInspPrg_Addtl_txt:="Sample text"
SCPOA_UWInspRptAvail_L_P:=1
SCPOA_UWInspRptAvail_L:=1
SCPOA_UWInspRptAvailDates_txt:="Sample text"
SCPOA_FixMonitDev_L_P:=1
SCPOA_FixMonitDev_L:=1
SCPOA_FixedDevProced_txt:="Sample text"

C_TEXT:C284(SCPOA_BDEPT_txt)
C_TEXT:C284(SCPOA_Dist_txt)
C_TEXT:C284(SCPOA_BIN_txt)
C_TEXT:C284(SCPOA_ComplDate_txt)
C_TEXT:C284(SCPOA_BrgClosure_txt)
C_TEXT:C284(SCPOA_BrADT_txt)
C_TEXT:C284(SCPOA_TruckPct_txt)
C_TEXT:C284(SCPOA_BrLen_txt)
C_TEXT:C284(SCPOA_BrNoSpans_txt)
C_TEXT:C284(SCPOA_BrLat_txt)
C_TEXT:C284(SCPOA_BrLon_txt)
C_TEXT:C284(SCPOA_EmergFacYN_txt)
C_TEXT:C284(SCPOA_EmergFac_txt)
C_LONGINT:C283(SCPOA_PostFldUnderm_L_P)
C_LONGINT:C283(SCPOA_PostFldUnderm_L)
C_LONGINT:C283(SCPOA_PostFldProfSubstr_L_P)
C_LONGINT:C283(SCPOA_PostFldProfSubstr_L)
C_LONGINT:C283(SCPOA_PostFldRvBed_L_P)
C_LONGINT:C283(SCPOA_PostFldRvBed_L)
C_LONGINT:C283(SCPOA_PostFlood_L_P)
C_LONGINT:C283(SCPOA_PostFlood_L)
C_TEXT:C284(SCPOA_PostFldWatch_txt)
C_TEXT:C284(SCPOA_PostFldElevs_txt)
C_TEXT:C284(SCPOA_PostFldAction_txt)
C_LONGINT:C283(SCPOA_PostFldVis_L_P)
C_LONGINT:C283(SCPOA_PostFldVis_L)
C_LONGINT:C283(SCPOA_DOTSitRept_L_P)
C_LONGINT:C283(SCPOA_DOTSitRept_L)
C_LONGINT:C283(SCPOA_FldForecast_L_P)
C_LONGINT:C283(SCPOA_FldForecast_L)
C_LONGINT:C283(SCPOA_FLMTerm_Stable_L_P)
C_LONGINT:C283(SCPOA_FLMTerm_Stable_L)
C_LONGINT:C283(SCPOA_FLMTerm_RecPost_L_P)
C_LONGINT:C283(SCPOA_FLMTerm_RecPost_L)
C_LONGINT:C283(SCPOA_OtherMonitDev_L_P)
C_LONGINT:C283(SCPOA_OtherMonitDev_L)
C_TEXT:C284(SCPOA_OthScCritElev_txt)
C_TEXT:C284(SCPOA_OthFldMonFreqDesc_txt)
C_LONGINT:C283(SCPOA_OtherMonitVis_L_P)
C_LONGINT:C283(SCPOA_OtherMonitVis_L)
C_LONGINT:C283(SCPOA_OtherMonitinstr_L_P)
C_LONGINT:C283(SCPOA_OtherMonitinstr_L)
C_LONGINT:C283(SCPOA_FLMTerm_CloseB_L_P)
C_LONGINT:C283(SCPOA_FLMTerm_CloseB_L)
C_LONGINT:C283(SCPOA_FLMTerm_Revisit_L_P)
C_LONGINT:C283(SCPOA_FLMTerm_Revisit_L)
C_LONGINT:C283(SCPOA_2DFreqCont_L_P)
C_LONGINT:C283(SCPOA_2DFreqCont_L)
C_LONGINT:C283(SCPOA_2DFreq3Hr_L_P)
C_LONGINT:C283(SCPOA_2DFreq3Hr_L)
C_LONGINT:C283(SCPOA_2DFreq12Hr_L_P)
C_LONGINT:C283(SCPOA_2DFreq12Hr_L)
C_LONGINT:C283(SCPOA_2DFreqDay_L_P)
C_LONGINT:C283(SCPOA_2DFreqDay_L)
C_TEXT:C284(SCPOA_FlMonLookFor_txt)
C_LONGINT:C283(SCPOA_USGSStation_L_P)
C_LONGINT:C283(SCPOA_USGSStation_L)
C_LONGINT:C283(SCPOA_OthMonInstrPort_L_P)
C_LONGINT:C283(SCPOA_OthMonInstrPort_L)
C_LONGINT:C283(SCPOA_OthMonInstrGeo_L_P)
C_LONGINT:C283(SCPOA_OthMonInstrGeo_L)
C_LONGINT:C283(SCPOA_OthMonInstrSon_L_P)
C_LONGINT:C283(SCPOA_OthMonInstrSon_L)
C_LONGINT:C283(SCPOA_OthMonInstrOth_L_P)
C_LONGINT:C283(SCPOA_OthMonInstrOth_L)
C_TEXT:C284(SCPOA_OthMonInstrType_txt)
C_LONGINT:C283(SCPOA_2DFreqOther_L_P)
C_LONGINT:C283(SCPOA_2DFreqOther_L)
C_TEXT:C284(SCPOA_USGSStationNo_s)
C_TEXT:C284(SCPOA_Stage_s)
C_TEXT:C284(SCPOA_DischOvrFeet_txt)
C_TEXT:C284(SCPOA_USGSStationNo2_s)
C_TEXT:C284(SCPOA_Stage2_s)
C_TEXT:C284(SCPOA_DischOvrFeet2_txt)
C_TEXT:C284(SCPOA_USGSStationURL_txt)
C_TEXT:C284(SCPOA_USGSStationURL2_txt)
C_TEXT:C284(SCPOA_NWSStationPrint_txt)
C_TEXT:C284(SCPOA_FlMonLookFor_txt)
C_TEXT:C284(SCPOA_CritWSEMarkLoc_txt)
C_TEXT:C284(SCPOA_ScourCritFeat_txt)
C_LONGINT:C283(SCPOA_FixMonDevWarn_L_P)
C_LONGINT:C283(SCPOA_FixMonDevWarn_L)
C_TEXT:C284(SCPOA_USGSStProxBrg_s)
C_TEXT:C284(SCPOA_USGSSt2ProxBrg_s)
C_LONGINT:C283(SCPOA_USGSStation_L_P)
C_LONGINT:C283(SCPOA_USGSStation_L)
C_LONGINT:C283(SCPOA_NOAAStation_L_P)
C_LONGINT:C283(SCPOA_NOAAStation_L)
C_LONGINT:C283(SCPOA_PostFldUWInsp_L_P)
C_LONGINT:C283(SCPOA_PostFldUWInsp_L)
C_LONGINT:C283(SCPOA_PostFldProbing_L_P)
C_LONGINT:C283(SCPOA_PostFldProbing_L)
C_TEXT:C284(SCPOA_BrADTYr_txt)
C_TEXT:C284(SCPOA_PostFldMonAgc_txt)
C_TEXT:C284(SCPOA_PostFldContact_txt)
SCPOA_BDEPT_txt:="Sample text"
SCPOA_Dist_txt:="Sample text"
SCPOA_BIN_txt:="Sample text"
SCPOA_ComplDate_txt:="Sample text"
SCPOA_BrgClosure_txt:="Sample text"
SCPOA_BrADT_txt:="Sample text"
SCPOA_TruckPct_txt:="Sample text"
SCPOA_BrLen_txt:="Sample text"
SCPOA_BrNoSpans_txt:="Sample text"
SCPOA_BrLat_txt:="Sample text"
SCPOA_BrLon_txt:="Sample text"
SCPOA_EmergFacYN_txt:="Sample text"
SCPOA_EmergFac_txt:="Sample text"
SCPOA_PostFldUnderm_L_P:=1
SCPOA_PostFldUnderm_L:=1
SCPOA_PostFldProfSubstr_L_P:=1
SCPOA_PostFldProfSubstr_L:=1
SCPOA_PostFldRvBed_L_P:=1
SCPOA_PostFldRvBed_L:=1
SCPOA_PostFlood_L_P:=1
SCPOA_PostFlood_L:=1
SCPOA_PostFldWatch_txt:="Sample text"
SCPOA_PostFldElevs_txt:="Sample text"
SCPOA_PostFldAction_txt:="Sample text"
SCPOA_PostFldVis_L_P:=1
SCPOA_PostFldVis_L:=1
SCPOA_DOTSitRept_L_P:=1
SCPOA_DOTSitRept_L:=1
SCPOA_FldForecast_L_P:=1
SCPOA_FldForecast_L:=1
SCPOA_FLMTerm_Stable_L_P:=1
SCPOA_FLMTerm_Stable_L:=1
SCPOA_FLMTerm_RecPost_L_P:=1
SCPOA_FLMTerm_RecPost_L:=1
SCPOA_OtherMonitDev_L_P:=1
SCPOA_OtherMonitDev_L:=1
SCPOA_OthScCritElev_txt:="Sample text"
SCPOA_OthFldMonFreqDesc_txt:="Sample text"
SCPOA_OtherMonitVis_L_P:=1
SCPOA_OtherMonitVis_L:=1
SCPOA_OtherMonitinstr_L_P:=1
SCPOA_OtherMonitinstr_L:=1
SCPOA_FLMTerm_CloseB_L_P:=1
SCPOA_FLMTerm_CloseB_L:=1
SCPOA_FLMTerm_Revisit_L_P:=1
SCPOA_FLMTerm_Revisit_L:=1
SCPOA_2DFreqCont_L_P:=1
SCPOA_2DFreqCont_L:=1
SCPOA_2DFreq3Hr_L_P:=1
SCPOA_2DFreq3Hr_L:=1
SCPOA_2DFreq12Hr_L_P:=1
SCPOA_2DFreq12Hr_L:=1
SCPOA_2DFreqDay_L_P:=1
SCPOA_2DFreqDay_L:=1
SCPOA_FlMonLookFor_txt:="Sample text"
SCPOA_USGSStation_L_P:=1
SCPOA_USGSStation_L:=1
SCPOA_OthMonInstrPort_L_P:=1
SCPOA_OthMonInstrPort_L:=1
SCPOA_OthMonInstrGeo_L_P:=1
SCPOA_OthMonInstrGeo_L:=1
SCPOA_OthMonInstrSon_L_P:=1
SCPOA_OthMonInstrSon_L:=1
SCPOA_OthMonInstrOth_L_P:=1
SCPOA_OthMonInstrOth_L:=1
SCPOA_OthMonInstrType_txt:="Sample text"
SCPOA_2DFreqOther_L_P:=1
SCPOA_2DFreqOther_L:=1
SCPOA_USGSStationNo_s:="Sample text"
SCPOA_Stage_s:="Sample text"
SCPOA_DischOvrFeet_txt:="Sample text"
SCPOA_USGSStationNo2_s:="Sample text"
SCPOA_Stage2_s:="Sample text"
SCPOA_DischOvrFeet2_txt:="Sample text"
SCPOA_USGSStationURL_txt:="Sample text"
SCPOA_USGSStationURL2_txt:="Sample text"
SCPOA_NWSStationPrint_txt:="Sample text"
SCPOA_FlMonLookFor_txt:="Sample text"
SCPOA_CritWSEMarkLoc_txt:="Sample text"
SCPOA_ScourCritFeat_txt:="Sample text"
SCPOA_FixMonDevWarn_L_P:=1
SCPOA_FixMonDevWarn_L:=1
SCPOA_USGSStProxBrg_s:="Sample text"
SCPOA_USGSSt2ProxBrg_s:="Sample text"
SCPOA_USGSStation_L_P:=1
SCPOA_USGSStation_L:=1
SCPOA_NOAAStation_L_P:=1
SCPOA_NOAAStation_L:=1
SCPOA_PostFldUWInsp_L_P:=1
SCPOA_PostFldUWInsp_L:=1
SCPOA_PostFldProbing_L_P:=1
SCPOA_PostFldProbing_L:=1
SCPOA_BrADTYr_txt:="Sample text"
SCPOA_PostFldMonAgc_txt:="Sample text"
SCPOA_PostFldContact_txt:="Sample text"

C_TEXT:C284(SCPOA_BDEPT_txt)
C_TEXT:C284(SCPOA_Dist_txt)
C_TEXT:C284(SCPOA_BIN_txt)
C_TEXT:C284(SCPOA_ComplDate_txt)
C_TEXT:C284(SCPOA_CLCri_wSurf_txt)
C_TEXT:C284(SCPOA_CLCri_Other_txt)
C_TEXT:C284(SCPOA_ClosureResp_txt)
C_TEXT:C284(SCPOA_Contacts_txt)
C_LONGINT:C283(SCPOA_CLCri_Over_L_P)
C_LONGINT:C283(SCPOA_CLCri_Over_L)
C_LONGINT:C283(SCPOA_CLCri_RipLoss_L_P)
C_LONGINT:C283(SCPOA_CLCri_RipLoss_L)
C_LONGINT:C283(SCPOA_CLCri_EmbkLoss_L_P)
C_LONGINT:C283(SCPOA_CLCri_EmbkLoss_L)
C_LONGINT:C283(SCPOA_CLCri_Settlm_L_P)
C_LONGINT:C283(SCPOA_CLCri_Settlm_L)
C_LONGINT:C283(SCPOA_CLCri_ScMeas_L_P)
C_LONGINT:C283(SCPOA_CLCri_ScMeas_L)
C_LONGINT:C283(SCPOA_CLCri_wSurf_L_P)
C_LONGINT:C283(SCPOA_CLCri_wSurf_L)
C_LONGINT:C283(SCPOA_CLCri_Debris_L_P)
C_LONGINT:C283(SCPOA_CLCri_Debris_L)
C_LONGINT:C283(SCPOA_CLCri_Other_L_P)
C_LONGINT:C283(SCPOA_CLCri_Other_L)
C_TEXT:C284(SCPOA_CLCri_WLvl_txt)
C_LONGINT:C283(SCPOA_CLCri_WLvl_L_P)
C_LONGINT:C283(SCPOA_CLCri_WLvl_L)
C_LONGINT:C283(SCPOA_CLCri_USGSNo_L_P)
C_LONGINT:C283(SCPOA_CLCri_USGSNo_L)
C_TEXT:C284(SCPOA_CLCri_USGSNo_txt)
C_LONGINT:C283(SCPOA_CLCri_USGSG_L_P)
C_LONGINT:C283(SCPOA_CLCri_USGSG_L)
C_TEXT:C284(SCPOA_CLCri_USGSG_txt)
C_LONGINT:C283(SCPOA_CLCri_USGSD_L_P)
C_LONGINT:C283(SCPOA_CLCri_USGSD_L)
C_TEXT:C284(SCPOA_CLCri_USGSD_txt)
C_LONGINT:C283(SCPOA_CLCri_NOAANo_L_P)
C_LONGINT:C283(SCPOA_CLCri_NOAANo_L)
C_TEXT:C284(SCPOA_CLCri_NOAANo_txt)
C_LONGINT:C283(SCPOA_CLCri_NOAAG_L_P)
C_LONGINT:C283(SCPOA_CLCri_NOAAG_L)
C_TEXT:C284(SCPOA_CLCri_NOAAG_txt)
C_LONGINT:C283(SCPOA_CLCri_NWS_L_P)
C_LONGINT:C283(SCPOA_CLCri_NWS_L)
C_TEXT:C284(SCPOA_BrgCloDiveCompl_txt)
C_TEXT:C284(SCPOA_ReOpenResp_txt)
C_LONGINT:C283(SCPOA_BrgCloWater_L_P)
C_LONGINT:C283(SCPOA_BrgCloWater_L)
C_LONGINT:C283(SCPOA_BrgCloReasAbate_L_P)
C_LONGINT:C283(SCPOA_BrgCloReasAbate_L)
C_LONGINT:C283(SCPOA_BrgCloCritElev_L_P)
C_LONGINT:C283(SCPOA_BrgCloCritElev_L)
C_LONGINT:C283(SCPOA_BrgCloDiveCompl_L_P)
C_LONGINT:C283(SCPOA_BrgCloDiveCompl_L)
C_LONGINT:C283(SCPOA_BrgCloInspCompl_L_P)
C_LONGINT:C283(SCPOA_BrgCloInspCompl_L)
C_LONGINT:C283(SCPOA_BrgOpenPendDive_L_P)
C_LONGINT:C283(SCPOA_BrgOpenPendDive_L)
C_TEXT:C284(SCPOA_PreExistCond_txt)
C_LONGINT:C283(SCPOA_BrgRailStraight_L_P)
C_LONGINT:C283(SCPOA_BrgRailStraight_L)
C_LONGINT:C283(SCPOA_ApproachNotSettl_L_P)
C_LONGINT:C283(SCPOA_ApproachNotSettl_L)
C_LONGINT:C283(SCPOA_EmbErosOK_L_P)
C_LONGINT:C283(SCPOA_EmbErosOK_L)
C_LONGINT:C283(SCPOA_substrPlumb_L_P)
C_LONGINT:C283(SCPOA_substrPlumb_L)
C_LONGINT:C283(SCPOA_AssessRvrBedOK_L_P)
C_LONGINT:C283(SCPOA_AssessRvrBedOK_L)
C_LONGINT:C283(SCPOA_CritStrElmOK_L_P)
C_LONGINT:C283(SCPOA_CritStrElmOK_L)
C_TEXT:C284(SCPOA_CLCri_NOAAI_txt)
SCPOA_BDEPT_txt:="Sample text"
SCPOA_Dist_txt:="Sample text"
SCPOA_BIN_txt:="Sample text"
SCPOA_ComplDate_txt:="Sample text"
SCPOA_CLCri_wSurf_txt:="Sample text"
SCPOA_CLCri_Other_txt:="Sample text"
SCPOA_ClosureResp_txt:="Sample text"
SCPOA_Contacts_txt:="Sample text"
SCPOA_CLCri_Over_L_P:=1
SCPOA_CLCri_Over_L:=1
SCPOA_CLCri_RipLoss_L_P:=1
SCPOA_CLCri_RipLoss_L:=1
SCPOA_CLCri_EmbkLoss_L_P:=1
SCPOA_CLCri_EmbkLoss_L:=1
SCPOA_CLCri_Settlm_L_P:=1
SCPOA_CLCri_Settlm_L:=1
SCPOA_CLCri_ScMeas_L_P:=1
SCPOA_CLCri_ScMeas_L:=1
SCPOA_CLCri_wSurf_L_P:=1
SCPOA_CLCri_wSurf_L:=1
SCPOA_CLCri_Debris_L_P:=1
SCPOA_CLCri_Debris_L:=1
SCPOA_CLCri_Other_L_P:=1
SCPOA_CLCri_Other_L:=1
SCPOA_CLCri_WLvl_txt:="Sample text"
SCPOA_CLCri_WLvl_L_P:=1
SCPOA_CLCri_WLvl_L:=1
SCPOA_CLCri_USGSNo_L_P:=1
SCPOA_CLCri_USGSNo_L:=1
SCPOA_CLCri_USGSNo_txt:="Sample text"
SCPOA_CLCri_USGSG_L_P:=1
SCPOA_CLCri_USGSG_L:=1
SCPOA_CLCri_USGSG_txt:="Sample text"
SCPOA_CLCri_USGSD_L_P:=1
SCPOA_CLCri_USGSD_L:=1
SCPOA_CLCri_USGSD_txt:="Sample text"
SCPOA_CLCri_NOAANo_L_P:=1
SCPOA_CLCri_NOAANo_L:=1
SCPOA_CLCri_NOAANo_txt:="Sample text"
SCPOA_CLCri_NOAAG_L_P:=1
SCPOA_CLCri_NOAAG_L:=1
SCPOA_CLCri_NOAAG_txt:="Sample text"
SCPOA_CLCri_NWS_L_P:=1
SCPOA_CLCri_NWS_L:=1
SCPOA_BrgCloDiveCompl_txt:="Sample text"
SCPOA_ReOpenResp_txt:="Sample text"
SCPOA_BrgCloWater_L_P:=1
SCPOA_BrgCloWater_L:=1
SCPOA_BrgCloReasAbate_L_P:=1
SCPOA_BrgCloReasAbate_L:=1
SCPOA_BrgCloCritElev_L_P:=1
SCPOA_BrgCloCritElev_L:=1
SCPOA_BrgCloDiveCompl_L_P:=1
SCPOA_BrgCloDiveCompl_L:=1
SCPOA_BrgCloInspCompl_L_P:=1
SCPOA_BrgCloInspCompl_L:=1
SCPOA_BrgOpenPendDive_L_P:=1
SCPOA_BrgOpenPendDive_L:=1
SCPOA_PreExistCond_txt:="Sample text"
SCPOA_BrgRailStraight_L_P:=1
SCPOA_BrgRailStraight_L:=1
SCPOA_ApproachNotSettl_L_P:=1
SCPOA_ApproachNotSettl_L:=1
SCPOA_EmbErosOK_L_P:=1
SCPOA_EmbErosOK_L:=1
SCPOA_substrPlumb_L_P:=1
SCPOA_substrPlumb_L:=1
SCPOA_AssessRvrBedOK_L_P:=1
SCPOA_AssessRvrBedOK_L:=1
SCPOA_CritStrElmOK_L_P:=1
SCPOA_CritStrElmOK_L:=1
SCPOA_CLCri_NOAAI_txt:="Sample text"

C_TEXT:C284(SCPOA_BDEPT_txt)
C_TEXT:C284(SCPOA_Dist_txt)
C_TEXT:C284(SCPOA_BIN_txt)
C_TEXT:C284(SCPOA_ComplDate_txt)
// C_WHAT(SCPOA_DetBIns_atxt)
// C_WHAT(SCPOA_DetBDept_atxt)
// C_WHAT(SCPOA_DetI7_atxt)
// C_WHAT(SCPOA_DetI6A_atxt)
// C_WHAT(SCPOA_detVertCL_aR)
// C_WHAT(SCPOA_detWidth_aR)
// C_WHAT(SCPOA_detAASHTO_ar)
// C_WHAT(SCPOA_DetI113_atxt)
// C_WHAT(SCPOA_DetPosted_atxt)
// C_WHAT(SCPOA_DetPostVs_atxt)
// C_WHAT(SCPOA_DetADT_aL)
// C_WHAT(SCPOA_DetTrk_aL)
C_TEXT:C284(SCPOA_DetourDesc_txt)
C_TEXT:C284(SCPOA_TrafEqLoc_txt)
C_TEXT:C284(SCPOA_TrafEqDist_txt)
C_TEXT:C284(SCPOA_TrafEqDBE_txt)
C_TEXT:C284(SCPOA_AddtlCritCons_txt)
SCPOA_BDEPT_txt:="Sample text"
SCPOA_Dist_txt:="Sample text"
SCPOA_BIN_txt:="Sample text"
SCPOA_ComplDate_txt:="Sample text"
SCPOA_DetourDesc_txt:="Sample text"
SCPOA_TrafEqLoc_txt:="Sample text"
SCPOA_TrafEqDist_txt:="Sample text"
SCPOA_TrafEqDBE_txt:="Sample text"
SCPOA_AddtlCritCons_txt:="Sample text"

C_TEXT:C284(SCPOA_BDEPT_txt)
C_TEXT:C284(SCPOA_Dist_txt)
C_TEXT:C284(SCPOA_BIN_txt)
C_TEXT:C284(SCPOA_ComplDate_txt)
C_TEXT:C284(SCPOA_PropCNT_txt)
C_TEXT:C284(SCPOA_CNTNotReq_txt)
C_REAL:C285(SCPOA_Inst_WaterSurf_r)
C_LONGINT:C283(SCPOA_Inst_WaterSurf_L_P)
C_LONGINT:C283(SCPOA_Inst_WaterSurf_L)
C_REAL:C285(SCPOA_Inst_Guide_r)
C_LONGINT:C283(SCPOA_Inst_Guide_L_P)
C_LONGINT:C283(SCPOA_Inst_Guide_L)
C_REAL:C285(SCPOA_Inst_Spurs_r)
C_LONGINT:C283(SCPOA_Inst_Spurs_L_P)
C_LONGINT:C283(SCPOA_Inst_Spurs_L)
C_REAL:C285(SCPOA_Inst_Relief_r)
C_LONGINT:C283(SCPOA_Inst_Relief_L_P)
C_LONGINT:C283(SCPOA_Inst_Relief_L)
C_REAL:C285(SCPOA_Inst_Chann_r)
C_LONGINT:C283(SCPOA_Inst_Chann_L_P)
C_LONGINT:C283(SCPOA_Inst_Chann_L)
C_REAL:C285(SCPOA_Inst_ChkDam_r)
C_LONGINT:C283(SCPOA_Inst_ChkDam_L_P)
C_LONGINT:C283(SCPOA_Inst_ChkDam_L)
C_REAL:C285(SCPOA_Inst_SubMod_r)
C_LONGINT:C283(SCPOA_Inst_SubMod_L_P)
C_LONGINT:C283(SCPOA_Inst_SubMod_L)
C_REAL:C285(SCPOA_Inst_BrgRepl_r)
C_LONGINT:C283(SCPOA_Inst_BrgRepl_L_P)
C_LONGINT:C283(SCPOA_Inst_BrgRepl_L)
C_TEXT:C284(SCPOA_Inst_Other_txt)
C_REAL:C285(SCPOA_Inst_Other_r)
C_LONGINT:C283(SCPOA_Inst_Other_L_P)
C_LONGINT:C283(SCPOA_Inst_Other_L)
C_TEXT:C284(SCPOA_ComplCNT_txt)
C_DATE:C307(SCPOA_ImplAdDate)
C_TEXT:C284(SCPOA_SchedInfo_txt)
C_TEXT:C284(SCPOA_OtherProj_txt)
C_LONGINT:C283(SCPOA_CntNotReq_L_P)
C_LONGINT:C283(SCPOA_CntNotReq_L)
C_LONGINT:C283(SCPOA_InstCNT_L_P)
C_LONGINT:C283(SCPOA_InstCNT_L)
C_LONGINT:C283(SCPOA_CloseBrg_L_P)
C_LONGINT:C283(SCPOA_CloseBrg_L)
C_LONGINT:C283(SCPOA_PropConsPrj_L_P)
C_LONGINT:C283(SCPOA_PropConsPrj_L)
C_LONGINT:C283(SCPOA_OtherMaintPrj_L_P)
C_LONGINT:C283(SCPOA_OtherMaintPrj_L)
C_LONGINT:C283(SCPOA_MaintPrj_L_P)
C_LONGINT:C283(SCPOA_MaintPrj_L)
C_REAL:C285(SCPOA_Inst_RipRap_r)
C_LONGINT:C283(SCPOA_Inst_RipRap_L_P)
C_LONGINT:C283(SCPOA_Inst_RipRap_L)
C_LONGINT:C283(SCPOA_Inst_L_WaterSurf_L_P)
C_LONGINT:C283(SCPOA_Inst_L_WaterSurf_L)
C_LONGINT:C283(SCPOA_Inst_L_Guide_L_P)
C_LONGINT:C283(SCPOA_Inst_L_Guide_L)
C_LONGINT:C283(SCPOA_Inst_L_Spurs_L_P)
C_LONGINT:C283(SCPOA_Inst_L_Spurs_L)
C_LONGINT:C283(SCPOA_Inst_L_Relief_L_P)
C_LONGINT:C283(SCPOA_Inst_L_Relief_L)
C_LONGINT:C283(SCPOA_Inst_L_Chann_L_P)
C_LONGINT:C283(SCPOA_Inst_L_Chann_L)
C_LONGINT:C283(SCPOA_Inst_L_ChkDam_L_P)
C_LONGINT:C283(SCPOA_Inst_L_ChkDam_L)
C_LONGINT:C283(SCPOA_Inst_L_SubMod_L_P)
C_LONGINT:C283(SCPOA_Inst_L_SubMod_L)
C_LONGINT:C283(SCPOA_Inst_L_BrgRepl_L_P)
C_LONGINT:C283(SCPOA_Inst_L_BrgRepl_L)
C_LONGINT:C283(SCPOA_Inst_L_Other_L_P)
C_LONGINT:C283(SCPOA_Inst_L_Other_L)
C_LONGINT:C283(SCPOA_Inst_L_RipRap_L_P)
C_LONGINT:C283(SCPOA_Inst_L_RipRap_L)
C_REAL:C285(SCPOA_Inst_GroutB_r)
C_LONGINT:C283(SCPOA_Inst_GroutB_L_P)
C_LONGINT:C283(SCPOA_Inst_GroutB_L)
C_LONGINT:C283(SCPOA_Inst_L_GroutB_L_P)
C_LONGINT:C283(SCPOA_Inst_L_GroutB_L)
C_LONGINT:C283(SCPOA_PrioCounter_L_P)
C_LONGINT:C283(SCPOA_PrioCounter_L)
C_DATE:C307(SCPOA_ImplSchedCompDate)
C_TEXT:C284(SCPOA_7BContactPers_txt)
C_REAL:C285(SCPOA_Inst_Monit_r)
C_LONGINT:C283(SCPOA_Inst_Monit_L_P)
C_LONGINT:C283(SCPOA_Inst_Monit_L)
C_REAL:C285(SCPOA_Inst_MonitDev_r)
C_LONGINT:C283(SCPOA_Inst_MonitDev_L_P)
C_LONGINT:C283(SCPOA_Inst_MonitDev_L)
C_LONGINT:C283(SCPOA_Inst_L_Monit_L_P)
C_LONGINT:C283(SCPOA_Inst_L_Monit_L)
C_LONGINT:C283(SCPOA_Inst_L_MonitDev_L_P)
C_LONGINT:C283(SCPOA_Inst_L_MonitDev_L)
C_TEXT:C284(SCPOA_7BInstallBy_txt)
SCPOA_BDEPT_txt:="Sample text"
SCPOA_Dist_txt:="Sample text"
SCPOA_BIN_txt:="Sample text"
SCPOA_ComplDate_txt:="Sample text"
SCPOA_PropCNT_txt:="Sample text"
SCPOA_CNTNotReq_txt:="Sample text"
SCPOA_Inst_WaterSurf_r:=1.5
SCPOA_Inst_WaterSurf_L_P:=1
SCPOA_Inst_WaterSurf_L:=1
SCPOA_Inst_Guide_r:=1.5
SCPOA_Inst_Guide_L_P:=1
SCPOA_Inst_Guide_L:=1
SCPOA_Inst_Spurs_r:=1.5
SCPOA_Inst_Spurs_L_P:=1
SCPOA_Inst_Spurs_L:=1
SCPOA_Inst_Relief_r:=1.5
SCPOA_Inst_Relief_L_P:=1
SCPOA_Inst_Relief_L:=1
SCPOA_Inst_Chann_r:=1.5
SCPOA_Inst_Chann_L_P:=1
SCPOA_Inst_Chann_L:=1
SCPOA_Inst_ChkDam_r:=1.5
SCPOA_Inst_ChkDam_L_P:=1
SCPOA_Inst_ChkDam_L:=1
SCPOA_Inst_SubMod_r:=1.5
SCPOA_Inst_SubMod_L_P:=1
SCPOA_Inst_SubMod_L:=1
SCPOA_Inst_BrgRepl_r:=1.5
SCPOA_Inst_BrgRepl_L_P:=1
SCPOA_Inst_BrgRepl_L:=1
SCPOA_Inst_Other_txt:="Sample text"
SCPOA_Inst_Other_r:=1.5
SCPOA_Inst_Other_L_P:=1
SCPOA_Inst_Other_L:=1
SCPOA_ComplCNT_txt:="Sample text"
SCPOA_ImplAdDate:=!2011-01-01!
SCPOA_SchedInfo_txt:="Sample text"
SCPOA_OtherProj_txt:="Sample text"
SCPOA_CntNotReq_L_P:=1
SCPOA_CntNotReq_L:=1
SCPOA_InstCNT_L_P:=1
SCPOA_InstCNT_L:=1
SCPOA_CloseBrg_L_P:=1
SCPOA_CloseBrg_L:=1
SCPOA_PropConsPrj_L_P:=1
SCPOA_PropConsPrj_L:=1
SCPOA_OtherMaintPrj_L_P:=1
SCPOA_OtherMaintPrj_L:=1
SCPOA_MaintPrj_L_P:=1
SCPOA_MaintPrj_L:=1
SCPOA_Inst_RipRap_r:=1.5
SCPOA_Inst_RipRap_L_P:=1
SCPOA_Inst_RipRap_L:=1
SCPOA_Inst_L_WaterSurf_L_P:=1
SCPOA_Inst_L_WaterSurf_L:=1
SCPOA_Inst_L_Guide_L_P:=1
SCPOA_Inst_L_Guide_L:=1
SCPOA_Inst_L_Spurs_L_P:=1
SCPOA_Inst_L_Spurs_L:=1
SCPOA_Inst_L_Relief_L_P:=1
SCPOA_Inst_L_Relief_L:=1
SCPOA_Inst_L_Chann_L_P:=1
SCPOA_Inst_L_Chann_L:=1
SCPOA_Inst_L_ChkDam_L_P:=1
SCPOA_Inst_L_ChkDam_L:=1
SCPOA_Inst_L_SubMod_L_P:=1
SCPOA_Inst_L_SubMod_L:=1
SCPOA_Inst_L_BrgRepl_L_P:=1
SCPOA_Inst_L_BrgRepl_L:=1
SCPOA_Inst_L_Other_L_P:=1
SCPOA_Inst_L_Other_L:=1
SCPOA_Inst_L_RipRap_L_P:=1
SCPOA_Inst_L_RipRap_L:=1
SCPOA_Inst_GroutB_r:=1.5
SCPOA_Inst_GroutB_L_P:=1
SCPOA_Inst_GroutB_L:=1
SCPOA_Inst_L_GroutB_L_P:=1
SCPOA_Inst_L_GroutB_L:=1
SCPOA_PrioCounter_L_P:=1
SCPOA_PrioCounter_L:=1
SCPOA_ImplSchedCompDate:=!2012-01-01!
SCPOA_7BContactPers_txt:="Sample text"
SCPOA_Inst_Monit_r:=1.5
SCPOA_Inst_Monit_L_P:=1
SCPOA_Inst_Monit_L:=1
SCPOA_Inst_MonitDev_r:=1.5
SCPOA_Inst_MonitDev_L_P:=1
SCPOA_Inst_MonitDev_L:=1
SCPOA_Inst_L_Monit_L_P:=1
SCPOA_Inst_L_Monit_L:=1
SCPOA_Inst_L_MonitDev_L_P:=1
SCPOA_Inst_L_MonitDev_L:=1
SCPOA_7BInstallBy_txt:="Sample text"

C_TEXT:C284(SCPOA_FinalRec_txt)
C_PICTURE:C286(SCPOA_SummPgPic_pic)
C_TEXT:C284(SCPOA_OtherAttach_txt)
C_LONGINT:C283(SCPOA_Summ_IncInspF_L_P)
C_LONGINT:C283(SCPOA_Summ_IncInspF_L)
C_LONGINT:C283(SCPOA_Summ_FixMonitDev_L_P)
C_LONGINT:C283(SCPOA_Summ_FixMonitDev_L)
C_LONGINT:C283(SCPOA_Summ_Counter_L_P)
C_LONGINT:C283(SCPOA_Summ_Counter_L)
C_LONGINT:C283(SCPOA_Summ_FloodMon_L_P)
C_LONGINT:C283(SCPOA_Summ_FloodMon_L)
C_LONGINT:C283(SCPOA_Summ_PostFlood_L_P)
C_LONGINT:C283(SCPOA_Summ_PostFlood_L)
C_TEXT:C284(SCPOA_Item7_txt)
C_TEXT:C284(SCPOA_Item6a_txt)
C_TEXT:C284(SCPOA_Town_txt)
C_TEXT:C284(SCPOA_BDEPT_txt)
C_TEXT:C284(SCPOA_Owner_txt)
C_TEXT:C284(SCPOA_Item60_txt)
C_TEXT:C284(SCPOA_Item61_txt)
C_TEXT:C284(SCPOA_Item71_txt)
C_TEXT:C284(SCPOA_Item113_txt)
C_TEXT:C284(SCPOA_Item60_c_txt)
C_TEXT:C284(SCPOA_Item61_c_txt)
C_TEXT:C284(SCPOA_Item71_c_txt)
C_TEXT:C284(SCPOA_Item113_c_txt)
C_LONGINT:C283(SCPOA_PrioCounter_L_P)
C_LONGINT:C283(SCPOA_PrioCounter_L)
C_LONGINT:C283(SCPOA_PrioMonitor_L_P)
C_LONGINT:C283(SCPOA_PrioMonitor_L)
C_LONGINT:C283(SCPOA_POAAttach_L_P)
C_LONGINT:C283(SCPOA_POAAttach_L)
C_LONGINT:C283(SCPOA_PhotoAttach_L_P)
C_LONGINT:C283(SCPOA_PhotoAttach_L)
C_LONGINT:C283(SCPOA_DetourAttach_L_P)
C_LONGINT:C283(SCPOA_DetourAttach_L)
C_LONGINT:C283(SCPOA_ElevAttach_L_P)
C_LONGINT:C283(SCPOA_ElevAttach_L)
C_LONGINT:C283(SCPOA_BoringAttach_L_P)
C_LONGINT:C283(SCPOA_BoringAttach_L)
C_LONGINT:C283(SCPOA_SurveyAttach_L_P)
C_LONGINT:C283(SCPOA_SurveyAttach_L)
C_LONGINT:C283(SCPOA_CalcAttach_L_P)
C_LONGINT:C283(SCPOA_CalcAttach_L)
C_LONGINT:C283(SCPOA_PlanAttach_L_P)
C_LONGINT:C283(SCPOA_PlanAttach_L)
C_LONGINT:C283(SCPOA_FieldAttach_L_P)
C_LONGINT:C283(SCPOA_FieldAttach_L)
C_LONGINT:C283(SCPOA_OtherAttach_L_P)
C_LONGINT:C283(SCPOA_OtherAttach_L)
C_TEXT:C284(SCPOA_Item8_txt)
C_LONGINT:C283(SCPOA_IncrInspFreq_L)
C_LONGINT:C283(SCPOA_RegFreq_L)
C_LONGINT:C283(SCPOA_UWInspPrgFreq_L)
C_TEXT:C284(SCPOA_BrADT_txt)
C_TEXT:C284(SCPOA_TruckPct_txt)
C_LONGINT:C283(SCPOA_HydroReptAttach_L_P)
C_LONGINT:C283(SCPOA_HydroReptAttach_L)
C_LONGINT:C283(SCPOA_Summ_IncUWF_L_P)
C_LONGINT:C283(SCPOA_Summ_IncUWF_L)
C_LONGINT:C283(SCPOA_FVCAttach_L_P)
C_LONGINT:C283(SCPOA_FVCAttach_L)
C_LONGINT:C283(SCPOA_PrevMonForm_L_P)
C_LONGINT:C283(SCPOA_PrevMonForm_L)
C_TEXT:C284(SCPOA_BrADTYr_txt)
C_LONGINT:C283(SCPOA_UWIncrInspPrgFreq_L)
C_TEXT:C284(SCPOA_ComplDate_txt)
SCPOA_FinalRec_txt:="Sample text"
GET PICTURE FROM LIBRARY:C565("BMS VertCLRSign"; SCPOA_SummPgPic_pic)
SCPOA_OtherAttach_txt:="Sample text"
SCPOA_Summ_IncInspF_L_P:=1
SCPOA_Summ_IncInspF_L:=1
SCPOA_Summ_FixMonitDev_L_P:=1
SCPOA_Summ_FixMonitDev_L:=1
SCPOA_Summ_Counter_L_P:=1
SCPOA_Summ_Counter_L:=1
SCPOA_Summ_FloodMon_L_P:=1
SCPOA_Summ_FloodMon_L:=1
SCPOA_Summ_PostFlood_L_P:=1
SCPOA_Summ_PostFlood_L:=1
SCPOA_Item7_txt:="Sample text"
SCPOA_Item6a_txt:="Sample text"
SCPOA_Town_txt:="Sample text"
SCPOA_BDEPT_txt:="Sample text"
SCPOA_Owner_txt:="Sample text"
SCPOA_Item60_txt:="Sample text"
SCPOA_Item61_txt:="Sample text"
SCPOA_Item71_txt:="Sample text"
SCPOA_Item113_txt:="Sample text"
SCPOA_Item60_c_txt:="Sample text"
SCPOA_Item61_c_txt:="Sample text"
SCPOA_Item71_c_txt:="Sample text"
SCPOA_Item113_c_txt:="Sample text"
SCPOA_PrioCounter_L_P:=1
SCPOA_PrioCounter_L:=1
SCPOA_PrioMonitor_L_P:=1
SCPOA_PrioMonitor_L:=1
SCPOA_POAAttach_L_P:=1
SCPOA_POAAttach_L:=1
SCPOA_PhotoAttach_L_P:=1
SCPOA_PhotoAttach_L:=1
SCPOA_DetourAttach_L_P:=1
SCPOA_DetourAttach_L:=1
SCPOA_ElevAttach_L_P:=1
SCPOA_ElevAttach_L:=1
SCPOA_BoringAttach_L_P:=1
SCPOA_BoringAttach_L:=1
SCPOA_SurveyAttach_L_P:=1
SCPOA_SurveyAttach_L:=1
SCPOA_CalcAttach_L_P:=1
SCPOA_CalcAttach_L:=1
SCPOA_PlanAttach_L_P:=1
SCPOA_PlanAttach_L:=1
SCPOA_FieldAttach_L_P:=1
SCPOA_FieldAttach_L:=1
SCPOA_OtherAttach_L_P:=1
SCPOA_OtherAttach_L:=1
SCPOA_Item8_txt:="Sample text"
SCPOA_IncrInspFreq_L:=1
SCPOA_RegFreq_L:=1
SCPOA_UWInspPrgFreq_L:=1
SCPOA_BrADT_txt:="Sample text"
SCPOA_TruckPct_txt:="Sample text"
SCPOA_HydroReptAttach_L_P:=1
SCPOA_HydroReptAttach_L:=1
SCPOA_Summ_IncUWF_L_P:=1
SCPOA_Summ_IncUWF_L:=1
SCPOA_FVCAttach_L_P:=1
SCPOA_FVCAttach_L:=1
SCPOA_PrevMonForm_L_P:=1
SCPOA_PrevMonForm_L:=1
SCPOA_BrADTYr_txt:="Sample text"
SCPOA_UWIncrInspPrgFreq_L:=1
SCPOA_ComplDate_txt:="Sample text"

//End SCPOA_FormTesterHOW about nothing blank!!!