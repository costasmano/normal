
//Method: Object Method: [Dialogs];"BigAlert".BCopyToClipBtn
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/22/12, 09:29:57
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
	// Modified by: Costas Manousakis-(Designer)-(9/17/20 16:04:06)
	Mods_2020_09_bug
	//  `put the plain text in the clipboard without style tags
End if 
//

SET TEXT TO PASTEBOARD:C523(ST Get plain text:C1092(vtMessage))
//End Object Method: [Dialogs];"BigAlert".BCopyToClipBtn