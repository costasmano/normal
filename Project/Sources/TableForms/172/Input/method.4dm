If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and timxle: 09/04/14, 16:55:45
	// ----------------------------------------------------
	// Method: Form Method: [LSS_SignPanel]Input
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 16:59:41)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; changed object method code.
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

FM_SignPanel
