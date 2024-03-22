//Method: Form Method: [TunnelInfo]TunnelInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/16/13, 16:47:35
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(9/6/13 16:56:30)
	Mods_2013_09
	//  `Modified the info shown under the Inspections section- added new  TunnelInfo Inspection fields and fields from bridge table
	// Modified by: Costas Manousakis-(Designer)-(11/8/13 14:24:20)
	Mods_2013_11
	//  `removed object methods from Bridge table fields. now changes are caught from method TNL_SIAInpForm_FM
End if 
//
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

TNL_SIAInpForm_FM
//End Form Method: [TunnelInfo]TunnelInput