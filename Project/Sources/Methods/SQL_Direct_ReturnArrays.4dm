//%attributes = {"invisible":true}
//Method: SQL_Direct_ReturnArrays
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/11/19, 16:05:38
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
C_LONGINT:C283($Loop_L; $ParamCount_L; $ParamCount_L; $Size_L; $TableNumber_L; $FieldNumber_L)

C_POINTER:C301(${1})

$ParamCount_L:=Count parameters:C259
C_TEXT:C284($name_txt; $SQL_SelectArrays_txt)

For ($Loop_L; 2; $ParamCount_L)
	RESOLVE POINTER:C394(${$Loop_L}; $Name_txt; $TableNumber_L; $FieldNumber_L)
	$SQL_SelectArrays_txt:=$SQL_SelectArrays_txt+$Name_txt+";"
	
End for 

$1->:=$1->+$SQL_SelectArrays_txt
//End SQL_Direct_ReturnArrays