//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/17/11, 12:52:58
//----------------------------------------------------
//Method: ut_LaunchUserMode
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (2/17/11 12:53:01)
	//Ugrade to v11
	//Modified by: Charles Miller (4/29/11 10:48:06)
	Mods_2012_02  //r003  `Modify launch of user mode to be in its own process
	//Modified by: Charles Miller (2/14/12 13:11:02)
	
End if 

C_LONGINT:C283($ProcessID_l)
$ProcessID_l:=ut_FindProcess("User_Mode")
If ($ProcessID_l=0)
	$ProcessID_l:=New process:C317("ut_DisplayUserMode"; 0; "User_Mode")
Else 
	SHOW PROCESS:C325($ProcessID_l)
	RESUME PROCESS:C320($ProcessID_l)
	BRING TO FRONT:C326($ProcessID_l)
End if 
//End ut_LaunchUserMode

