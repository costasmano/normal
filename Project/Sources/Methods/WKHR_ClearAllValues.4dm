//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/06/05, 20:38:08
	// ----------------------------------------------------
	// Method: WKHR_ClearAllValues
	// Description
	// Clear All entry values either in page 1 - General or,
	// in the category page - values only for the category.
	
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/9/09 20:41:21)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:08:24  ` ("WKHRMODS")
End if 
If (FORM Get current page:C276=1)
	CONFIRM:C162("Clear all Data in all Categories?"; "Clear"; "Cancel")
	If (OK=1)
		WKHR_ClearCosts
		[Work_Estimate:103]DirectExpenseC:27:=0
		[Work_Estimate:103]DirectExpenseD:14:=0
		[Work_Estimate:103]SpecEngineeringC:28:=0
		[Work_Estimate:103]SpecEngineeringD:15:=0
		
		PushChange(1; ->[Work_Estimate:103]DirectExpenseC:27)
		PushChange(1; ->[Work_Estimate:103]DirectExpenseD:14)
		PushChange(1; ->[Work_Estimate:103]SpecEngineeringC:28)
		PushChange(1; ->[Work_Estimate:103]SpecEngineeringD:15)
		
		[Work_Estimate:103]WkHrEstComplete:17:=False:C215
		[Work_Estimate:103]CompletedBy:21:=""
		PushChange(1; ->[Work_Estimate:103]WkHrEstComplete:17)
		PushChange(1; ->[Work_Estimate:103]CompletedBy:21)
		WKHR_ZeroAll
		WKHR_CalcRates
		WKHR_CalcTotals
	End if 
Else 
	CONFIRM:C162("Clear all Entries?"; "Clear"; "Cancel")
	If (OK=1)
		//WKHR_ClearValues (◊a_WKH_Index_Name{(Current form page-1)};◊a_WKH_NumRows{(Curren  `t form page-1)})
		WKHR_ResetPageValues
		WKHR_CalcTotals
		WKHR_LoadItemHRs
	End if 
End if 