// ----------------------------------------------------
// Form Method: PRJ_Empty
// User name (OS): cjmiller
// Date and time: 03/31/06, 14:54:35
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //Add ability to select by design contract
End if 
If (Form event code:C388=On Load:K2:1)
	CANCEL:C270
End if 
//End Form Method: PRJ_Empty