//%attributes = {"invisible":true}
//Method: ut_DisplayClientProcesses
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/27/20, 15:34:10
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08
End if 




C_LONGINT:C283($W)

$W:=Open form window:C675("TaskList"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("TaskList")

//End ut_DisplayClientProcesses