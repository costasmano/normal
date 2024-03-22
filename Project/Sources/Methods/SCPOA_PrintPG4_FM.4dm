//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/09, 09:01:54
	// ----------------------------------------------------
	// Method: SCPOA_PrintPG4_FM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent_L - Optional
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: Costas Manousakis-(Designer)-(1/25/12 16:36:16)
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
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_DetourDesc_txt; 10; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_ReOpenResp_txt; 10; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_Contacts_txt; 10; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_BrgClosure_txt; 10; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_EmergFac_txt; 10; 5)
End case 

//End of form method