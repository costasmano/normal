//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/09, 09:01:54
	// ----------------------------------------------------
	// Method: SCPOA_PrintPG2_FM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent_L - Optional
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(3/21/11 14:55:28)
	Mods_2011_05
	//  `added SCPOA_ImplAdDate_txt
	// Modified by: Costas Manousakis-(Designer)-(1/25/12 16:34:48)
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
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_ComplCNT_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_PropCNT_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_CNTNotReq_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_SchedInfo_txt; 9; 5)
		If (SCPOA_ImplAdDate=!00-00-00!)
			SCPOA_ImplAdDate_txt:=""
		Else 
			SCPOA_ImplAdDate_txt:=String:C10(SCPOA_ImplAdDate; Internal date short:K1:7)
		End if 
		
End case 