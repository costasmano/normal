// ----------------------------------------------------
// Object Method: PRJ_StructPrjMgr_atxt
// User name (OS): cjmiller
// Date and time: 11/30/06, 16:16:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
If (Form event code:C388=On Clicked:K2:4)
	ut_PRJ_ControlDDChange(->[Conslt_Name:127]CurrentStructureProjectMgr_l:4; "Are you sure you wish to change current structural project manager?"; ->PRJ_StructPrjMgr_atxt; ->PRJ_StructPrjMgrID_al; ->PRJ_StructPrjMgr_txt; PRJ_StructPrjMgr_atxt)
End if 
//End Object Method: PRJ_StructPrjMgr_atxt