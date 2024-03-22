// Method: Form Method: [Preservation_Reviews]PreservReviewInput
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/04/12, 14:35:30
	// ----------------------------------------------------
	// First Release
	Mods_2013_10
	// Modified by: Costas Manousakis-(Designer)-(3/6/14 17:27:00)
	Mods_2014_03
	//  `Changed label of Received to By Email, added field ReceivedHardCopy_d
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

PRV_ReviewInput_FM
//End Form Method: [Preservation_Reviews]PreservReviewInput