// ----------------------------------------------------
// Object Method: PRJ_DesignApproved_b
// User name (OS): cjmiller
// Date and time: 11/27/07, 12:41:36
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 12:41:37 `Make [PRJ_ProjectDetails]PRJ_DesignApproval_d = today if = 00/00/00
End if 
If ([PRJ_ProjectDetails:115]PRJ_DesignApproved_b:11)
	If ([PRJ_ProjectDetails:115]PRJ_DesignApproval_d:12=!00-00-00!)
		[PRJ_ProjectDetails:115]PRJ_DesignApproval_d:12:=Current date:C33(*)
	End if 
End if 
//End Object Method: PRJ_DesignApproved_b