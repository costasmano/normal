//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetManyTablesReadOnly
// User name (OS): cjmiller
// Date and time: 01/26/06, 15:14:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
READ ONLY:C145([PRJ_StructuralReview:119])
READ ONLY:C145([PRJ_SketchPlans:120])
READ ONLY:C145([PRJ_TypeStudy:121])
READ ONLY:C145([PRJ_ConstructionProject:116])
READ ONLY:C145([PRJ_Contractor:114])
READ ONLY:C145([PRJ_ProjectTimeTracking:124])
READ ONLY:C145([PRJ_ProjectFile:117])
READ ONLY:C145([PRJ_DesignContracts:123])
READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
READ ONLY:C145([PRJ_ReportData:118])

//End PRJ_SetManyTablesReadOnly