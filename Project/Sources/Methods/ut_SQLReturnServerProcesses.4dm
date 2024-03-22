//%attributes = {"invisible":true,"publishedSql":true,"executedOnServer":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/10/11, 15:48:57
//----------------------------------------------------
//Method: ut_SQLReturnServerProcesses
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (3/10/11 15:48:58)
End if 
C_BLOB:C604($0; $Return_blb)
SET BLOB SIZE:C606($Return_blb; 0)


C_LONGINT:C283($Loop_l; $State_l; $ProcessTime_l; $ProcessOrigin_l)
C_LONGINT:C283($ProcesssUniqueID_i)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($BackupInProcess_b; $ProcessVisible_b)
$BackupInProcess_b:=False:C215
ARRAY TEXT:C222($Processnames_atxt; 0)

C_TEXT:C284($ProcessName_txt)
For ($Loop_l; 1; Count tasks:C335)
	PROCESS PROPERTIES:C336($Loop_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
	If ($State_l>=0)
		If ($ProcessOrigin_l>=0)
			
			APPEND TO ARRAY:C911($Processnames_atxt; $ProcessName_txt)
			
		End if 
	End if 
	
End for 
VARIABLE TO BLOB:C532($Processnames_atxt; $Return_blb; *)

$0:=$Return_blb
//End ut_SQLReturnServerProcesses

