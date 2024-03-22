//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/12, 11:20:58
//----------------------------------------------------
//Method: ut_FindProcess
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r003  `Modify launch of user mode to be in its own process
	//Modified by: Charles Miller (2/14/12 11:20:59)
	
End if 
C_LONGINT:C283($0; $ProcessID_l)
C_TEXT:C284($1; $ProcessName_s)  // Command Replaced was o_C_STRING length was 30

C_LONGINT:C283($TestID_l; $Tasks_l; $TestTime_l; $TestState_l)

C_TEXT:C284($TestName_s)  // Command Replaced was o_C_STRING length was 31


$ProcessName_s:=$1

$ProcessID_l:=0  // Does not exist by default.
$Tasks_l:=Count tasks:C335  // How many processes are there?

For ($TestID_l; 1; $Tasks_l)
	PROCESS PROPERTIES:C336($TestID_l; $TestName_s; $TestState_l; $TestTime_l)
	
	If ($ProcessName_s=$TestName_s)  // We've found the process
		
		If ($TestState_l<0)  // It's known, but not running.
			$ProcessID_l:=0  // Return 0 to show that the process is not running.
		Else 
			$ProcessID_l:=$TestID_l  // Return the ID      
		End if   // ($TestState<0)
		
		$TestID_l:=$Tasks_l+1  // Exit the loop.
	End if   // ($ProcessName_s=$TestName_s)
	
End for   // ($i;1;$Tasks_l)

$0:=$ProcessID_l

//End ut_FindProcess

