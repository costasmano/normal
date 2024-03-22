If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 09/04/14, 16:56:40
	// ----------------------------------------------------
	// Method: Form Method: [LSS_UT]Input
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(11/16/16 16:37:16)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; added code to object methods
	//in v15 only add on load event to nav buttons - rest done in object method
	
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_UTInput


