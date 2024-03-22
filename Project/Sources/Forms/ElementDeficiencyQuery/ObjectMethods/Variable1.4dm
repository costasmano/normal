//Method: ElementDeficiencyQuery.Variable1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/13/18, 12:32:35
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//

v_171_004_atxt:=1
LSS_ClearForNewQuery("ALL")

CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "TotalElmtsFound")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "FinalElementSet")
CREATE EMPTY SET:C140([LSS_Inspection:164]; "LSSInspectionSet")
CREATE EMPTY SET:C140([LSS_Inventory:165]; "LSS_Inventory")
OBJECT SET TITLE:C194(*; "DistrictTitle"; "")
vtSearchResultCnt:=""

//End ElementDeficiencyQuery.Variable1