
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/25/14, 10:42:15
//----------------------------------------------------
//Method: Form Method: [LSS_DMeter]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_03  // 
	//Modified by: administrator (12/2/14 10:44:25)
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_DMeterInput

//End Form Method: [LSS_DMeter]Input

