
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/07/15, 16:48:41
//----------------------------------------------------
//Method: Form Method: [LSS_refStructureTypes]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_RefStructureTypesInput
//End Form Method: [LSS_refStructureTypes]Input

