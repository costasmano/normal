//%attributes = {"invisible":true}
// ----------------------------------------------------
// Compiler_SD
// User name (OS): charlesmiller
// Date and time: 12/29/09, 14:53:31
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_12  // r004 CJ Miller`12/29/09, 14:53:34       `Add [Bridge MHD NBIS]LegacyOwner to SD Data
	Mods_2010_03  //r002 CJ Miller`03/11/10, 15:55:51      `Add code to allow for printing different sections of the SD report
	// Modified by: Costas Manousakis-(Designer)-(6/27/14 16:58:16)
	Mods_2014_06_bug
	//  `added SD_Detail_prt_l (◊SD_Detail_l was being reset when form was printed)
End if 
C_LONGINT:C283(<>SD_Detail_l; <>SD_SubTotalByOwner_l; <>SD_CreateFile_l; <>SD_IncludeALL_l; SD_Move_l; <>SD_UseLegacy_l; <>SD_PrintHistory_l; <>SD_PrintPosted_l)
C_TEXT:C284(<>SD_Filename_txt; <>SD_DistrictSelect_txt; <>SD_ReportFilePath_txt)
C_TEXT:C284(<>SD_EndYear_s; <>SD_BeginYear_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(<>SD_EndMonth_s; <>SD_BeginMonth_s)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284(<>SD_OWNER_S)

C_LONGINT:C283(SD_Detail_prt_l)
//End Compiler_SD