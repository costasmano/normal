// ----------------------------------------------------
// Form Method: SelectFileFromDC

// User name (OS): charlesmiller
// Date and time: 05/08/09, 09:22:09
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r001  `05/08/09, 09:57:59  `Continue changes PRJ Design Contract Changes 
	Mods_2009_06  //r002 `06/11/09, 13:57:50   `Merge PRJ Design Contract Changes
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		OBJECT SET VISIBLE:C603(*; "PF_Description"; False:C215)
	: (Form event code:C388=On Unload:K2:2)
		UNLOAD RECORD:C212([PRJ_ProjectFile:117])
End case 
//End Form Method: SelectFileFromDC