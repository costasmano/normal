// Method: Form Method: [Contract_Assignment_Maintenance]PRVAddAssignment
// Description
// 
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/11/13, 09:34:50
	// ----------------------------------------------------
	// First Release
	Mods_2013_10
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
PRV_AddAssignment_FM