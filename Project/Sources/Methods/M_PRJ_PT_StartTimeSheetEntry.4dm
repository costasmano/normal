//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/11/07, 20:33:38
	// ----------------------------------------------------
	// Method: M_PRJ_PT_StartTimeSheetEntry
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_TimeTracking
	P_PRJ_StartTimeSheets
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283($ProcessID_l)
$ProcessID_l:=LSpawnProcess("P_PRJ_StartTimeSheets"; <>LStackSize; "Time Sheets"; True:C214; False:C215)
