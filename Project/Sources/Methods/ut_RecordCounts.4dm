//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_RecordCounts
// User name (OS): charlesmiller
// Date and time: 05/22/09, 11:16:01
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($Width_l; $Height_l)
FORM GET PROPERTIES:C674([Dialogs:21]; "RecordCount.dlg"; $Width_l; $Height_l)
ut_OpenNewWindow($Width_l; $Height_l; 0; 4)
DIALOG:C40([Dialogs:21]; "RecordCount.dlg")
CLOSE WINDOW:C154

//End ut_RecordCounts