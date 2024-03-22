//%attributes = {"invisible":true,"executedOnServer":true}
//Method: ut_SQLReturnServerCProcesses
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/27/20, 15:59:03
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08
End if 
//
C_BLOB:C604($0; $Return_blb)
SET BLOB SIZE:C606($Return_blb; 0)
Compiler_Utilities

C_LONGINT:C283($Loop_l; $State_l; $ProcessTime_l; $ProcessOrigin_l)
C_LONGINT:C283($ProcesssUniqueID_i)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($BackupInProcess_b; $ProcessVisible_b)
$BackupInProcess_b:=False:C215
ARRAY TEXT:C222($Processnames_atxt; 0)
ARRAY LONGINT:C221($ProcessNumber_aL; 0)
ARRAY LONGINT:C221($ProcessState_aL; 0)

C_TEXT:C284($ProcessName_txt)
For ($Loop_l; 1; Count tasks:C335)
	PROCESS PROPERTIES:C336($Loop_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
	If ($State_l>=0)
		If ($ProcessOrigin_l<1)
			
			APPEND TO ARRAY:C911($Processnames_atxt; $ProcessName_txt)
			APPEND TO ARRAY:C911($ProcessNumber_aL; $ProcesssUniqueID_i)
			APPEND TO ARRAY:C911($ProcessState_aL; $State_l)
			
		End if 
	End if 
	
End for 
VARIABLE TO BLOB:C532($Processnames_atxt; $Return_blb; *)
VARIABLE TO BLOB:C532($ProcessNumber_aL; $Return_blb; *)
VARIABLE TO BLOB:C532($ProcessState_aL; $Return_blb; *)

$0:=$Return_blb
//End ut_SQLReturnServerCProcesses