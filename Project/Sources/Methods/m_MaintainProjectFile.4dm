//%attributes = {"invisible":true}
// ----------------------------------------------------
// m_MaintainProjectFile
// User name (OS): cjmiller
// Date and time: 03/03/06, 12:38:53
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2022_05  //Added ability to use List box as output
	//Modified by: Chuck Miller (5/5/22 16:35:44)
End if 
Compiler_PRJ
C_LONGINT:C283($win_L)
ALL RECORDS:C47([PRJ_ProjectFile:117])
FORM SET INPUT:C55([PRJ_ProjectFile:117]; "ProjectFile.i")
If (ut_UseListBox(Current method name:C684))
	$win_L:=Open form window:C675([PRJ_ProjectFile:117]; "Output_LB"; Plain form window:K39:10; On the left:K39:2; At the top:K39:5; *)
	DIALOG:C40([PRJ_ProjectFile:117]; "Output_LB")
Else 
	$win_L:=Open form window:C675([PRJ_ProjectFile:117]; "UserList.o"; Plain form window:K39:10; On the left:K39:2; At the top:K39:5; *)
	FORM SET OUTPUT:C54([PRJ_ProjectFile:117]; "UserList.o")
	MODIFY SELECTION:C204([PRJ_ProjectFile:117]; *)
End if 

//End m_MaintainProjectFile