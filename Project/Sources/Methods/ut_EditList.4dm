//%attributes = {"invisible":true}
//Method: ut_EditList
//Description
//  ` bring up a dialogue that allows modifications of lists 
//  `that are marked as editable by user in the desugn envirometn
// Parameters (none)
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/22/13, 15:04:27
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
End if 
//
C_LONGINT:C283($W; $H)
FORM GET PROPERTIES:C674("EditLists"; $W; $H)
NewWindow($W; $H; 0; Plain form window:K39:10; "LIST EDITOR")
DIALOG:C40("EditLists")
CLOSE WINDOW:C154

//End ut_EditList