//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRemoveExtraCharacters
// User name (OS): cjmiller
// Date and time: 06/16/06, 15:52:47
// ----------------------------------------------------
// Description
// This method will removed characters passed in param 2 and beyond from passed in string
//
// Parameters
//$1 string to replace characters in 
//$2 to n characters to replace with ""
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $Passedin_txt)
C_TEXT:C284($0)
C_LONGINT:C283($ParamCount_l)
$Passedin_txt:=$1
$ParamCount_l:=Count parameters:C259
If ($ParamCount_l>1)
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; $ParamCount_l-1)
		$Passedin_txt:=Replace string:C233($Passedin_txt; ${$Loop_l+1}; "")
	End for 
	
End if 
$0:=$Passedin_txt

//End ut_PRJRemoveExtraCharacters