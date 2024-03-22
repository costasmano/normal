//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlChapter85Input
// User name (OS): cjmiller
// Date and time: 11/27/07, 11:25:27
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 11:25:29
	Mods_2009_04  //v449 `r001  `04/17/09, 10:36:07 `Only bring up window if there is a project file record
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
FORM SET INPUT:C55([PRJ_ProjectFile:117]; "Chapter85.i")
QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
If (Records in selection:C76([PRJ_ProjectFile:117])=1)
	ut_LoadRecord(->[PRJ_ProjectFile:117])
	C_LONGINT:C283($Width_l; $Height_l)
	FORM GET PROPERTIES:C674([PRJ_ProjectFile:117]; "Chapter85.i"; $Width_l; $Height_l)
	NewWindow($Width_l; $Height_l; 0; 4)
	ut_ResizeWindow(Frontmost window:C447; $Width_l; $Height_l)
	
	MODIFY RECORD:C57([PRJ_ProjectFile:117]; *)
	UNLOAD RECORD:C212([PRJ_ProjectFile:117])
End if 
READ ONLY:C145([PRJ_ProjectFile:117])

//End PRJ_ControlChapter85Input