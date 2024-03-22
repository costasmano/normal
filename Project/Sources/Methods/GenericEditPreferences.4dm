//%attributes = {"invisible":true}
//Method: GenericEditPreferences
//Description
// Allow editing of preferences - use form "EditPrefs"
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/21/17, 15:36:08
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//

C_LONGINT:C283($WinID_L; $WinW_L; $WinH_L)

FORM GET PROPERTIES:C674("EditPrefs"; $WinW_L; $WinH_L)
ut_OpenNewWindow($WinW_L; $WinH_L; 12; 728; "Edit Prefs"; "CloseLayout")

DIALOG:C40("EditPrefs")

CLOSE WINDOW:C154
//End GenericEditPreferences