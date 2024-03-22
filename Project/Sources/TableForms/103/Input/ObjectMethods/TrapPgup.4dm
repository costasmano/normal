If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/20/05, 22:59:52
	// ----------------------------------------------------
	// Method: Object Method: TrapPgup
	// Description
	// simulate a page up
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
End if 
If (WKHR_PageTitles>1)
	WKHR_PageTitles:=WKHR_PageTitles-1
	WKHR_Input_GotoPage
End if 