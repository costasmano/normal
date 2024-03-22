//%attributes = {"invisible":true}
// ----------------------------------------------------
// SQL_SetUpReturnArrays
// User name (OS): cjmiller
// Date and time: 12/18/07, 14:47:19
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Compiler_SQL
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 11:18:16`
End if 
C_LONGINT:C283($i; $iParamCount; $iSize)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($1)
C_POINTER:C301(${2})
$iParamCount:=Count parameters:C259
If ($1="A")
	$iSize:=Size of array:C274(SQL_BindArrays_aPtr)
	INSERT IN ARRAY:C227(SQL_BindArrays_aPtr; $iSize+1; $iParamCount-1)
	
Else 
	ARRAY POINTER:C280(SQL_BindArrays_aPtr; 0)
	ARRAY POINTER:C280(SQL_BindArrays_aPtr; $iParamCount-1)
	
	$iSize:=0
End if 


$iParamCount:=Count parameters:C259

For ($i; 1; $iParamCount-1)
	//$ArrayName_txt:=${$i+1}
	SQL_BindArrays_aPtr{$iSize+$i}:=${$i+1}  //Get pointer($ArrayName_txt)
End for 

//End SQL_SetUpReturnArrays

