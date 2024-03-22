// ----------------------------------------------------
// Form Method: Chapter85.i
// User name (OS): cjmiller
// Date and time: 01/22/08, 12:12:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		ut_SetStringOrTextFilter(->[PRJ_ProjectFile:117]PF_EWO_s:4)
		
	Else 
End case 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
//End Form Method: Chapter85.i