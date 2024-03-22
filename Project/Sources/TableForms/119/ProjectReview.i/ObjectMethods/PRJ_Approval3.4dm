// ----------------------------------------------------
// Object Method: PRJ_DesignApproval_d
// User name (OS): cjmiller
// Date and time: 11/27/07, 12:46:04
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 12:46:06
End if 
If ([PRJ_ProjectDetails:115]PRJ_DesignApproval_d:12#!00-00-00!)
	[PRJ_ProjectDetails:115]PRJ_DesignApproved_b:11:=True:C214
End if 
//End Object Method: PRJ_DesignApproval_d