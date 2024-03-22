//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_SaveorLoadLists
// User name (OS): charlesmiller
// Date and time: 05/23/11, 17:11:58
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_05  //r002 CJ Miller`05/23/11, 17:12:00      `
End if 
C_LONGINT:C283($Width_l; $Height_l)

FORM GET PROPERTIES:C674([Dialogs:21]; "saveLists"; $Width_l; $Height_l)

ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Import or Export Lists")

DIALOG:C40([Dialogs:21]; "saveLists")
CLOSE WINDOW:C154

//End ut_SaveorLoadLists