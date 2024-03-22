If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/20/05, 23:01:17
	// ----------------------------------------------------
	// Method: Object Method: TrapPgdn
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
End if 
If (WKHR_PageTitles<Size of array:C274(WKHR_PageTitles))
	WKHR_PageTitles:=WKHR_PageTitles+1
	WKHR_Input_GotoPage
End if 