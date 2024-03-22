If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 09/04/14, 16:54:15
	// ----------------------------------------------------
	// Method: Form Method: [LSS_ElementInspection]Input
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 15:37:58)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; changed object method code.
	// Modified by: Costas Manousakis-(Designer)-(2/15/19 14:30:32)
	Mods_2019_02
	//  `Damage info moves on vert resize, Remarks grow on vert and horiz resize
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

FM_ElementInspection
