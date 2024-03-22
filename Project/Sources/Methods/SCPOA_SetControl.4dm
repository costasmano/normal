//%attributes = {"invisible":true}
//Method: SCPOA_SetControl
//Description
// method to be called from menu bar. uses the selected menu item parameter
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/22/15, 11:57:18
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
End if 
//
SETUTIL_Control(Get selected menu item parameter:C1005; ->[ScourPOA:132]ScourPOAID:1)
WindowTitle
//End SCPOA_SetControl