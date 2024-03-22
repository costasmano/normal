// ----------------------------------------------------
// Form Method: PRJ_Details.inc
// User name (OS): cjmiller
// Date and time: 01/04/07, 16:54:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_TimeTracking
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
	: (Form event code:C388=On Display Detail:K2:22)
		ut_SetStringOrTextFilter(->[PRJ_ProjectTimeTracking:124]PT_EWO_s:8)
		PRJ_PT_GetReviewer
	: (Form event code:C388=On Validate:K2:3)
	: (Form event code:C388=On Close Detail:K2:24)
		
End case 

//End Form Method: PRJ_Details.inc