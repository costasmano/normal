If (False:C215)
	// ----------------------------------------------------
	// Object Method: aViewDesign
	// User name (OS): cjmiller
	// Date and time: 03/15/07, 14:59:26
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(3/1/09 20:37:41)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 
OBJECT SET VISIBLE:C603(PT_ConstructionProjectList_HL; False:C215)
OBJECT SET VISIBLE:C603(PT_DesignProjectList_HL; True:C214)
OBJECT SET VISIBLE:C603(*; "PT_Scope_@"; True:C214)

If (PRJ_PT_Scope_s="@CONSTR@")
	PRJ_PT_Scope_s:=""
End if 

//End Object Method: aViewDesign