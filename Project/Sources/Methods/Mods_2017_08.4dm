//%attributes = {"invisible":true}
//Method: Mods_2017_08
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/16/17, 17:29:50
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(8/16/17)
// Created Method(s) : 
//Method: ARCHIVE_GetDataAtDate
//Description
// get data for a BIN at a date from the BridgeMHDNBISArchive table
// load the data in an object passed as a pointer. Attributes are :
// "NBI" b, "NHS" b, "SD" b, "Owner" , "InspResp", "Item2", "Item49" (M), "Item52" (m), "Item34" (m), "Item32" (m), "Area" (sqm)
// Parameters
// $1 : $Obj_ptr
// $2 : $BIN_txt
// $3 : $Date_d

//Method: ARCHIVE_CalcStatus
//Description
// Calculate status changes of a record in BridgeMHDNBISArchive table compared with another date in the future
// load data in an object passed as a pointer. Attributes added to the object are :
// "NBI" b, "NHS" b, "SD" b, "Owner" , "InspResp", "Item2", "Item49" (M), "Item52" (m), "Item34" (m), "Item32" (m), "Area" (sqm)
// "NBIState", "NBIArea" (sqft), "NHSState", "NHSArea" (sqft), "SDState", "SDArea" (sqft)
// "NHSSDState", "NHSSDArea" (sqft)
// Parameters
// $1 : $Obj_ptr
// $2 : $BIN_txt
// $3 : $Date_d

//Method: DEV_DisableButton_fix
//Description
// Fix the _o_DISABLE BUTTON and _o_ENABLE BUTTON commands in all methods

//Method: DEV_logEventPath
//Description
// stuff in object DEV_LogEvents_o info with the current method name, the formevent and other info
// can be viewed with DEV_showEventPath
// Parameters
// $1 : $Methodname_txt
// $2 : $Formevent_L

//Method: DEV_showEventPath
//Description
// show the contents of the DEV_LogEvents_o object filled with data from calls to DEV_logEventPath

//Method: DEV_ShowModDateTimes
//Description
// show all methods by mod date and time - allow opening the selected one

//Method: ReadPOASummaryFromXML
//Description
// open a spreadsheet saved as XML and read the POA summary data in there.

// Modified Method(s) : 
// fGetFormEvent
//  `added all new form events

// Modified Forms : 
// [Status Report];"P_StatusReport_MDOT"
//  `fixed vert size of variables and text objects

// Created Method(s) : 
//Method: PON_Sort_BIN_Keys
//Description
//
// Parameters
// $0 : $SortValue_txt
// $1 : $SortOrder_txt  ">" | "ASC" | "<" | "DESC" (Optional def =">")

//Method: PON_Sort_BDEPT_Keys
//Description
//
// Parameters
// $0 : $SortValue_txt
// $1 : $SortOrder_txt  ">" | "ASC" | "<" | "DESC" (Optional def =">")

//Method: PON_Sort_ElemKey
//Description
//
// Parameters
// $0 : $SortValue_txt
// $1 : $SortOrder_txt  ">" | "ASC" | "<" | "DESC" (Optional def =">")

// Modified Method(s) : 
// LB_ProcessNBEQuery
//  `several mods in sorting

// [PON_ELEM_INSP];"SearchNBE"
//  `Modifications in form / form method objects to allow filtering by element type, category, material

// Created Method(s) : 
//Method: NBE_Search_ApplyFilter
//Description
// Apply the filters selected in the search by NBEs dialog
// Parameters

// Modified Method(s) : 
// SRC_ResetForm_NBE
//  `adjust for material, category, type
// G_NBEElmtQuery
//  `adjustments / bug fixes with introduction of filtering by material / type / category

// Modified Form Methods : 
// [NTI_ELEM_DEFS];"Input"
//  `added code to log changes

// Created Method(s) : 
// Method: popup_MenuFromTablePtr - all menu levels
// --- Create a Dynamic popup menu with Related One fields & get user's selection
// INPUT1: Pointer - table of origination
// OUTPUT:  Pointer - to a User selected field
// ----------------------------------------------------
// --- params passed from this method to itself
// INPUT2: Pointer - table to build this level's menu for
// INPUT3: Pointer - array of menuRefs to eventually clear, add this menu to it
// INPUT4: menuref - attach this level's menu to this higher level menu
// INPUT5: Pointer - array of Table Pointers to prevent a table loop

// Created Method(s) : 
//Method: DEV_BuildModDateName
//Description
// build the array for the "mod date-time - method names" list

// Created Form(s) : 
// Form: "MethodsList"
// Description
// Display list of methods using the OneArrayLB form - can open, and filter by date.

// Modified Method(s) : 
// SIA_OnDisplayDetail
//  `for routine (RTN/RTA) inspections blank item62 ; for CUL blank 58,59,60

//End Mods_2017_08