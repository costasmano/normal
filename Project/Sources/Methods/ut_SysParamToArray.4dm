//%attributes = {"invisible":true}
//Method: ut_SysParamToArray
//Description
//  ` Load a system parameter to an array
// Parameters
// $1 : $ParamName_txt
// $2 : $Array_ptr
// $3 : $DefParamValue_txt
// $4 : $Value_Desc_txt (optional) ("VALUE" | "DESC" (default)) `retrieve the value or the descr
// $5 : $Delimiter_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/08/14, 09:51:52
	// ----------------------------------------------------
	//Created : 
	Mods_2014_09
End if 
//
C_TEXT:C284($1)
C_POINTER:C301($2)

C_TEXT:C284($ParamName_txt)
C_POINTER:C301($Array_ptr)

$ParamName_txt:=$1
$Array_ptr:=$2

C_TEXT:C284($Param_txt; $DefParamValue_txt; $Value_Desc_txt; $Delimiter_txt)
$DefParamValue_txt:=""
$Value_Desc_txt:=""
$Delimiter_txt:=""

If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$DefParamValue_txt:=$3
End if 
If (Count parameters:C259>3)
	C_TEXT:C284($4)
	$Value_Desc_txt:=$4
End if 
If (Count parameters:C259>4)
	C_TEXT:C284($5)
	$Delimiter_txt:=$5
End if 

$Param_txt:=ut_GetSysParameter($ParamName_txt; $DefParamValue_txt; $Value_Desc_txt)

ut_TextToArray($Param_txt; $Array_ptr; $Delimiter_txt)

//End ut_SysParamToArray