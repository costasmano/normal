//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/09, 09:01:54
	// ----------------------------------------------------
	// Method: SCPOA_PrintPG3_FM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent_L - Optional
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(2/23/11 16:47:33)
	Mods_2011_02
	//  `Added ut_FitPrintFormObject for  SCPOA_FldForecast_txt and SCPOA_FldWarnSys_txt
	Mods_2011_05
	//SCPOA MOD 2
	// Modified by: Costas Manousakis-(Designer)-(1/25/12 16:35:56)
	Mods_2012_01
	// SCPOA_FillFormPicButtons
End if 

// Declare local variables
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Printing Detail:K2:18)
		SCPOA_FillFormPicButtons
		C_BOOLEAN:C305($Fit_b)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchReg_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchIncr_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchUW_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchIncrUW_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_ScCritAction_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_FixedTerm_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_OthScCritAction_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldWatch_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldElevs_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldAction_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_FldForecast_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_FldWarnSys_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_2cEvtScCritAction_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_2cEvtFixedTerm_txt; 9; 5)
End case 

//End of form method