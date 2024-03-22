// ----------------------------------------------------
// Form Method: PRJ_Details.inc
// User name (OS): cjmiller
// Date and time: 01/04/07, 16:51:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		ut_SetStringOrTextFilter(->[PRJ_TypeStudy:121]TYP_Source_s:6)
		ut_SetStringOrTextFilter(->[PRJ_TypeStudy:121]TYP_Comments_txt:12)
		ut_SetStringOrTextFilter(->[PRJ_TypeStudy:121]TYP_StructureType_s:4)
		
	Else 
		PRJ_SetProjectChangesMade(->[PRJ_TypeStudy:121]; ->[PRJ_TypeStudy:121]TYP_ModifiedBy_s:13; ->[PRJ_TypeStudy:121]TYP_ModifiedTimeStamp_s:14)
End case 
//End Form Method: PRJ_Details.inc