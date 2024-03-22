
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/08/15, 17:31:29
//----------------------------------------------------
//Method: Form Method: [LSS_refInspectionType]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/8/15 17:32:49)
	
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_refInspectionTypeInput

//End Form Method: [LSS_refInspectionType]Input

