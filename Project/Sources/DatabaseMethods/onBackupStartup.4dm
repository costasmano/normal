// Method: On Backup Startup
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Chuck Miller
	// User name (4D): Designer
	// Date and time: 02/22/22, 12:28:26
	// ----------------------------------------------------
	// First Release
	mods_2022_02  //Create new interprocess variable <>BackUpStarted_B used during transfers to know when backup is occurring
	//Modified by: Chuck Miller (2/22/22 12:28:01)
End if 
<>BackUpStarted_B:=True:C214