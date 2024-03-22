//%attributes = {"invisible":true}
//Method: Mods_2014_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/04/14, 16:29:13
	// ----------------------------------------------------
	//Created : 
	Mods_2014_09
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(9/4/14)
// Modified Method(s) : 
//maximo_UpdateMaximo
//  `Add ending statistics
//  `Added filter for combinations of  Item8Owner and Item21 (maintainer)

//**********`Modified by: Costas Manousakis-(Designer)-(9/5/14)
// Modified Method(s) : 
//G_ListTable
//  `use at  least 3/4 of the screen ht for the window.

//**********`Modified by: Costas Manousakis-(Designer)-(9/8/14)
// Modified Method(s) : 
//ut_TextToArray
//  `account for blank in $3
//ut_GetSysParameter
//  `account for blank in $3

// Created Method(s) : 
//ut_SysParamToArray
//Description
//  ` Load a system parameter to an array
// Parameters
// $1 : $ParamName_txt
// $2 : $Array_ptr
// $3 : $DefParamValue_txt
// $4 : $Value_Desc_txt (optional) ("VALUE" | "DESC" (default)) `retrieve the value or the descr
// $5 : $Delimiter_txt

// Created Method(s) : 
//ut_MessageArray
// Write an array using ut_message. 
// Will convert int, real, date arrays to strings, boolean to Y or N
// Others will print an error message
// Parameters
// $1 : $Array_ptr


// Modified Method(s) : 
//COMPILER_Utilities
//  `added  ut_SysParamToArray ; ut_MessageArray

//maximo_UpdateMaximo
//  `use new method ut_SysParamToArray
//  `added messages with the parameters used and resulting arrays

// Modified Method(s) : 
//fGetDataType
//  `added Float; int 64 bits

//End Mods_2014_09