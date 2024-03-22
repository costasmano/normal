// ----------------------------------------------------
// Form Method: Input
// User name (OS): cjmiller
// Date and time: 01/22/08, 12:00:31
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (Form event code:C388=On Load:K2:1)
	ut_SetStringOrTextFilter(->[PRJ_Contractor:114]CTR_CompanyName_s:2)
End if 
//End Form Method: Input