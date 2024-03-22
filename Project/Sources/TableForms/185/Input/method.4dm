//Method: Form Method: [NTI_ELEM_TIN_INSP];"Input"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/26/16, 16:00:50
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(11/17/16 15:05:45)
	Mods_2016_11
	//  `modified from v11 version : add only on load event to navigation buttons - rest is handled in the object method
	// Modified by: Costas Manousakis-(Designer)-(3/23/18 09:58:37)
	Mods_2018_03
	//  `additions for protective system
End if 
//
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

NTI_ELEMINP_TIN_FM(Form event code:C388)

//End Form Method: [NTI_ELEM_TIN_INSP]Input