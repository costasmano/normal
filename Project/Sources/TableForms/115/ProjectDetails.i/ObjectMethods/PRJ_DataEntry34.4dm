// ----------------------------------------------------
// Object Method: PRJ_StructPrjMgr_atxt
// User name (OS): cjmiller
// Date and time: 12/14/06, 16:31:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 

ut_PRJ_ControlDDChange(->[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39; "Are you sure you wish to change current structural project manager?"; ->PRJ_StructPrjMgr_atxt; ->PRJ_StructPrjMgrID_al; ->PRJ_StructPrjMgr_txt; PRJ_StructPrjMgr_atxt)

//[PRJ_ProjectDetails]PRJ_CurrentStructutalPrjMgrID_l:=PRJ_StructPrjMgrID_al{PRJ_StructPrjMgr_atxt}
//End Object Method: PRJ_StructPrjMgr_atxt