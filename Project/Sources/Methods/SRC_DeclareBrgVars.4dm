//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/28/07, 12:08:07
	// ----------------------------------------------------
	// Method: SRC_DeclareBrgVars
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/24/2007 08:34:20)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(1/8/08 14:56:58)
	Mods_2007_CM_5401
End if 
C_POINTER:C301(SRC_MasterTable_ptr; SRC_BINField_ptr; SRC_BDEPTField_ptr; SRC_BRKEYField_ptr)
C_BOOLEAN:C305(SRC_NewSearchMethod_b; SRC_AllowSearchAll_b; SRC_HideLooking_b)
C_TEXT:C284(SRC_StartFieldArea_s)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284(vBIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284(vBDEPT)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(vBridgeKey)  // Command Replaced was o_C_STRING length was 12
C_TEXT:C284(vsSearchResults)
C_BOOLEAN:C305(vAddTo)