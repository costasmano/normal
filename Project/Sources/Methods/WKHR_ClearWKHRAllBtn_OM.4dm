//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/09/09, 20:37:49
	// ----------------------------------------------------
	// Method: WKHR_ClearWKHRAllBtn_OM
	// Description
	// The object method for the clear all button in the work hour input form
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  //("WKHRMODS")
End if 

If (FORM Get current page:C276=1)
	CONFIRM:C162("Clear all Data in all Categories?"; "Clear"; "Cancel")
	If (OK=1)
	End if 
Else 
	CONFIRM:C162("Clear all Entries?"; "Clear"; "Cancel")
	If (OK=1)
		//WKHR_ClearValues (◊a_WKH_Index_Name{(Current form page-1)};◊a_WKH_NumRows{(Current form page-1)})
		WKHR_ResetPageValues
		WKHR_CalcTotals
		WKHR_LoadItemHRs
	End if 
End if 