//Method: Form Method: [NTI_ELEM_BIN_INSP];"Input"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 16:18:31
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(11/16/16 11:12:43)
	Mods_2016_11
	//  `modified from v11 version : add only on load event to navigation buttons - rest is handled in the object method
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 
//
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
NTI_ELEMINP_FM(Form event code:C388)

//End Form Method: [NTI_ELEM_BIN_INSP]Input