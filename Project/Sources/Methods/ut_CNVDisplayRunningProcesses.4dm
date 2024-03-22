//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/16, 10:58:31
//----------------------------------------------------
//Method: ut_CNVDisplayRunningProcesses
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	Compiler_CNV  //Modified by: administrator (5/26/16 10:58:33)
	
End if 
C_LONGINT:C283($Width_L; $Height_L; $Win_l)

FORM GET PROPERTIES:C674("CNV_RunningProcesses"; $Width_L; $Height_L)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; "Stop Running Pictiure Conversion Process"; "ut_CloseCancel ")
DIALOG:C40("CNV_RunningProcesses")
//End ut_CNVDisplayRunningProcesses

