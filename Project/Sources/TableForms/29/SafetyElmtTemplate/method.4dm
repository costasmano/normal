If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/24/06, 14:19:20
	// ----------------------------------------------------
	// Method: Form Method: SafetyElmtTemplate
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/24/2006 14:19:28)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 11:36:51)
	Mods_2016_11
	//  `added keyboard shortcuts to navigation buttons and changed obj methods to include the shortcut in the help tip
	// Modified by: Costas Manousakis-(Designer)-(4/22/21 10:22:22)
	Mods_2021_04
	//  `made sure navigation buttons are named bFirst, bPrevious, bNext, bLast.  Removed variables. Set automatic action to None
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 