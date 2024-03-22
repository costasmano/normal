
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/08/15, 17:35:42
//----------------------------------------------------
//Method: Form Method: [LSS_refRouteDirection]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/8/15 17:35:45)
	
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_RefRouteDirectionInput

//End Form Method: [LSS_refRouteDirection]Input

