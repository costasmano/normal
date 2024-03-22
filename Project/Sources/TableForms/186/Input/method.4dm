//Method: Form Method: [TIN_Insp_Images]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/03/16, 11:39:50
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(11/16/16 11:42:48)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; added code in obj methods
	//  `in v15 use only on load event ; shortcuts helptips handled in the object method
End if 
//
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

NTI_ImageInput_FM
//End Form Method: [TIN_Insp_Images]Input