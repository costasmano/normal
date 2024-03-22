// ----------------------------------------------------
// Form Method: SketchPlans.inc
// User name (OS): cjmiller
// Date and time: 01/04/07, 16:52:39
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
		ut_SetStringOrTextFilter(->[PRJ_SketchPlans:120]SKT_Comments_txt:4)
	Else 
		PRJ_SetProjectChangesMade(->[PRJ_SketchPlans:120]; ->[PRJ_SketchPlans:120]SKT_ModifiedBy_s:14; ->[PRJ_SketchPlans:120]SKT_ModifiedTimeStamp_s:15)
End case 
//End Form Method: SketchPlans.inc