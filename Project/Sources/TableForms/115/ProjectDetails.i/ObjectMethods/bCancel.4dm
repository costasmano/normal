// ----------------------------------------------------
// Object Method: bCancel
// User name (OS): cjmiller
// Date and time: 12/14/06, 13:11:58
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //Do not check if no access
End if 

If (PRJ_ReturnAccessAllowed)
	PRJ_CheckForChanges
End if 
CANCEL:C270

//End Object Method: bCancel