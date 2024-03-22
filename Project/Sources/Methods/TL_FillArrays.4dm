//%attributes = {"invisible":true}
//Method: TL_FillArrays
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/27/20, 16:05:49
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08
End if 
//
Compiler_Utilities
ARRAY LONGINT:C221(ProcessNumber_al; 0)
ARRAY TEXT:C222(ProcessName_atxt; 0)
ARRAY LONGINT:C221(ProcessState_al; 0)
C_LONGINT:C283($Loop_l; $State_l; $ProcessTime_l; $ProcesssUniqueID_L; $ProcessOrigin_l)
C_TEXT:C284($ProcessName_txt)
C_BOOLEAN:C305($ProcessVisible_b)
For ($Loop_l; 1; Count tasks:C335)
	PROCESS PROPERTIES:C336($Loop_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_L; $ProcessOrigin_l)
	APPEND TO ARRAY:C911(ProcessNumber_al; $ProcesssUniqueID_L)
	APPEND TO ARRAY:C911(ProcessName_atxt; $ProcessName_txt)
	APPEND TO ARRAY:C911(ProcessState_al; $State_l)
	
End for 
C_BLOB:C604($Return_blb)
SET BLOB SIZE:C606($Return_blb; 0)

$Return_blb:=ut_SQLReturnServerCProcesses
$Loop_l:=0
ARRAY TEXT:C222($Processnames_atxt; 0)
ARRAY LONGINT:C221($ProcessNumber_aL; 0)
ARRAY LONGINT:C221($ProcessState_aL; 0)

BLOB TO VARIABLE:C533($Return_blb; $Processnames_atxt; $Loop_l)
BLOB TO VARIABLE:C533($Return_blb; $ProcessNumber_aL; $Loop_l)
BLOB TO VARIABLE:C533($Return_blb; $ProcessState_aL; $Loop_l)
For ($Loop_l; 1; Size of array:C274($Processnames_atxt))
	APPEND TO ARRAY:C911(ProcessNumber_al; $ProcessNumber_aL{$Loop_l})
	APPEND TO ARRAY:C911(ProcessName_atxt; $Processnames_atxt{$Loop_l}+"-sp")
	APPEND TO ARRAY:C911(ProcessState_al; $ProcessState_aL{$Loop_l})
	
	
End for 
SORT ARRAY:C229(ProcessName_atxt; ProcessNumber_al; ProcessState_al; >)

//End TL_FillArrays