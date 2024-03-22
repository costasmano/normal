//%attributes = {"invisible":true}
//Method: ut_SQLDownLoadLoadRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/17/18, 16:58:41
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05  // Fix issue where we are not checing for locked and loaded record during download 
	//Modified by: Chuck Miller (5/17/18 16:45:49)
End if 
//
C_POINTER:C301($1; $LocalTable_ptr)
$LocalTable_ptr:=$1
XFERRecordLoaded_B:=True:C214
If (XFERCurrentProcessName_txt="BMSExternal_Transfer")
	If (ut_LoadRecord($LocalTable_ptr; 3))
	Else 
		XFERRecordLoaded_B:=False:C215
	End if 
Else 
	If (ut_LoadRecordInteractive($LocalTable_ptr))
	Else 
		XFERRecordLoaded_B:=False:C215
	End if 
	
End if 
//End ut_SQLDownLoadLoadRecord