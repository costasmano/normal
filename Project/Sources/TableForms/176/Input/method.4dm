
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/20/14, 15:43:07
//----------------------------------------------------
//Method: Form Method: [LSS_UtResult]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_03  // 
	//Modified by: administrator (11/20/14 15:43:09)
	// Modified by: Costas Manousakis-(Designer)-(11/16/16 16:37:16)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; added code to object methods
	//in v15 only add on load event to nav buttons - rest done in object method
	//  //removed automatic action from the .bnext button
	// Modified by: Costas Manousakis-(Designer)-(10/12/18 11:38:00)
	Mods_2018_10
	//  `changed headers of Location field
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_UTResults

//End Form Method: [LSS_UtResult]Input