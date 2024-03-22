//%attributes = {"invisible":true}
// Method: Mods_2019_01
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 01/03/19, 13:02:31
	// ----------------------------------------------------
	// First Release
	Mods_2019_01
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(1/3/19)
// Created Method(s) : 
//Method: PON_CombineRecent
//Description
// Combine NBE elements from the previous inspections starting from the last routine inspection
// return an object containing the element tree.
// object can be used to create a new set of elements for a new inspection, or
// to export for FHWA submittal
// Parameters
// $0 : $NBEElements_o

//Method: PON_VerifyNBELinks  (Copied to bug fix release 7.2.0.a)
//Description
// Verify whether the NBEs related to the current inspection are correctly linked.
// Parameters
// $0 : $text : text containing results of check
// $1 : $InspectionID_L (optional)

//Method: dev_ObjectTotextColumns
//Description
// Convert an object that contains arrays into a text arranged by
// columns with property name as the header in a tab delimited format. text can be used to be pasted into excel,
// or saved to file.
// Parameters
// $0 : $data_txt : converted object
// $1 : $myObject_o

//**********`Modified by: Costas Manousakis-(Designer)-(1/7/19)
// Created Method(s) : 

//Method: PON_FixParentLinks
//Description
// Fix/adjust the Parent and Grandparent Links of an element. 
// use the current values of str unit, env, parent key, grand parent key
// tool is to be executed in user mode by selecting a record from PON_ELEM_INSP table
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(1/8/19)
// Modified Method(s) : 
// PON_ExportFHWANBE
//  `use method PON_CombineRecent to get all elements accumulated from the latest routine inspection.
//  `allow designer to choose if new method is used or the old of using the latest valid inspection.

//**********`Modified by: Costas Manousakis-(Designer)-(1/10/19)
// Modified Method(s) : 
// ut_AddOwnerRecs
//  `Added Alert at the end of adding records


//Final list of changes to add [LSS_ElementInspection] query and report
//LB_ControlListBoxDisplay 
//LB_ProcessLSSElementQuery 
//LSS_ControlDeficiencyQuery
//LSS_CreateElementArraysForQuery 
//LSS_OrderByJustStructure
//LSS_SetUpAndSortForElementRpt 
//LSS_SetUpArraysforElements
//LSS_SortElements
//M_CreateLSSElementReport
//Forms 
//"ElementDeficiencyQuery"
//[LSS_ElementInspection];"Rpt DefElem"

// Move ut_SQLLogout to directly after for loop so it does not wait for user to press enter on fisplayed form
//ut_ControlDBSycnh 
//ut_SQLDownloadNewRecords
//Create and use Image list subform for LSS inspections
//[LSS_Inspection];"PhotoSubFormLB"
//[LSS_Inspection];"Input_ITS"