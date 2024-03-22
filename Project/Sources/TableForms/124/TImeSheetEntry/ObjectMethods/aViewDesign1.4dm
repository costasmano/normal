// ----------------------------------------------------
// Object Method: aViewConstruction
// User name (OS): cjmiller
// Date and time: 03/15/07, 14:59:42
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(3/1/09 20:38:52)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 
OBJECT SET VISIBLE:C603(PT_ConstructionProjectList_HL; True:C214)
OBJECT SET VISIBLE:C603(PT_DesignProjectList_HL; False:C215)
PRJ_PT_Scope_s:="4-CONSTR"
OBJECT SET VISIBLE:C603(*; "PT_Scope_@"; False:C215)

//End Object Method: aViewConstruction