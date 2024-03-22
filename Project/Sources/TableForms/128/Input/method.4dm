// ----------------------------------------------------
// Form Method: Input
// User name (OS): cjmiller
// Date and time: 01/22/08, 11:32:26
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (Form event code:C388=On Load:K2:1)
	ut_SetStringOrTextFilter(->[PRJ_StrPrjManagerHistory:128]SPMH_StructuralProjManager_txt:2)
End if 
//End Form Method: Input