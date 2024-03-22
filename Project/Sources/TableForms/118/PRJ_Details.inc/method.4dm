// ----------------------------------------------------
// Form Method: PRJ_Details.inc
// User name (OS): cjmiller
// Date and time: 05/03/07, 16:16:46
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		ut_SetStringOrTextFilter(->[PRJ_ReportData:118]RPT_Comments_txt:6)
	Else 
		PRJ_SetProjectChangesMade(->[PRJ_ReportData:118]; ->[PRJ_ReportData:118]RPT_ModifiedBy_s:8; ->[PRJ_ReportData:118]RPT_ModifiedTimeStamp_s:9)
End case 
//End Form Method: PRJ_Details.inc