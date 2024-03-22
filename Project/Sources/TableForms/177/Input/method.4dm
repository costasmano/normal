
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/08/15, 16:56:27
//----------------------------------------------------
//Method: Form Method: [LSS_VerticalClearance]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/14/15 16:42:29)
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 17:17:51)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; changed object method code.
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_VerticalClearance

//End Form Method: [LSS_VerticalClearance]Input