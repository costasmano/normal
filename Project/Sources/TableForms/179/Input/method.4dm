//Method: Form Method: [PON_ELEM_INSP];"Input"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/20/15, 10:48:04
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(8/19/15 14:03:06)
	Mods_2015_08_bug
	//  `re-arranged objects in page 0 to allow for display of total quantity
	// Modified by: Costas Manousakis-(Designer)-(10/2/15 14:42:18)
	Mods_2015_10_bug
	//  `Trap the Enter key with the Save & Exit button
	//  `changed variable on Info and Help buttons to Button1 to avoide conflict with data entry buttons
	// Modified by: Costas Manousakis-(Designer)-(11/18/15 13:11:21)
	Mods_2015_11_bug
	//  `Remove the Delete action from the Delete button. 
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 14:24:08)
	Mods_2016_02_bug
	//  `added splitters and invisible buttons to allow resizing of defect and prot sys lists
	// Modified by: Costas Manousakis-(Designer)-(11/17/16 15:05:45)
	Mods_2016_11
	//  `added on load event to navigation buttons
End if 
//
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

PON_ELEMINP_FM(Form event code:C388)
//End Form Method: [PON_ELEM_INSP]Input