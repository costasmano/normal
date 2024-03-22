
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/20/14, 15:39:58
//----------------------------------------------------
//Method: Form Method: [LSS_TowerDistance]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_03  // 
	//Modified by: administrator (11/20/14 15:40:00)
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 17:05:49)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; changed object method code.
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_TowerDistance

//End Form Method: [LSS_TowerDistance]Input

