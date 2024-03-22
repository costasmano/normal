//%attributes = {"invisible":true,"publishedSql":true,"executedOnServer":true}
// Method: ut_TestForBackup
// Description
// This method is used by calling program via sql function call and returns status of backup on server.
// It should not be used in the same server or DB
//
// Parameters
// ----------------------------------------------------
//$0 true if back up running false if it is not
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): Charles Miller
	// Date and time: 02/18/10, 14:52:20
	// ----------------------------------------------------
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:43:04)
	mods_2022_02  //Create new interprocess variable <>BackUpStarted_B used during transfers to know when backup is occurring
	//Modified by: Chuck Miller (2/22/22 12:28:01)
	
End if 
C_BOOLEAN:C305($0)
If (False:C215)
	C_LONGINT:C283($Loop_l; $State_l; $ProcessTime_l; $ProcessOrigin_l)
	C_LONGINT:C283($ProcesssUniqueID_i)
	C_BOOLEAN:C305($BackupInProcess_b; $ProcessVisible_b)
	$BackupInProcess_b:=False:C215
	C_TEXT:C284($ProcessName_s)  // Command Replaced was o_C_STRING length was 80
	
	For ($Loop_l; 1; Count tasks:C335)
		PROCESS PROPERTIES:C336($Loop_l; $ProcessName_s; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
		If (($ProcessOrigin_l=Backup process:K36:24) | ($ProcessOrigin_l=MSC Process:K36:27))
			$BackupInProcess_b:=True:C214
			$Loop_l:=Count tasks:C335+1
		End if 
	End for 
Else 
	$0:=<>BackUpStarted_B
End if 
