If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/09/05, 08:57:36
	// ----------------------------------------------------
	// Method: Object Method: ZZ9
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM11
End if 

If (Not:C34(vbInspectionLocked))
	CONFIRM:C162("Exit Inspection without saving?"; "Cancel"; "Exit")
	If (OK#1)
		CANCEL TRANSACTION:C241
		CANCEL:C270
		OBJECT SET ENTERABLE:C238(*; "@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	End if 
Else 
	CANCEL TRANSACTION:C241
	CANCEL:C270
	OBJECT SET ENTERABLE:C238(*; "@"; True:C214)
	OBJECT SET ENABLED:C1123(*; "@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 
//Should be an unload record. It is in the BlankStarter method.