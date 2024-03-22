//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJReturnEarliestDate
// User name (OS): cjmiller
// Date and time: 06/16/06, 14:19:17
// ----------------------------------------------------
// Description
// This method wil parse passed in text to array and return the earliest date
//
// Parameters
//$1 text to check
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2  //`06/16/06, 14:19:36
End if 
C_TEXT:C284($1; $PassedInData_txt)
$PassedInData_txt:=$1
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)
$Blob_blb:=ut_PRJParseTextToArray($PassedInData_txt)
ARRAY TEXT:C222($ParsedText_atxt; 0)
BLOB TO VARIABLE:C533($Blob_blb; $ParsedText_atxt)
C_DATE:C307($Test_d; $Return_d)
C_TEXT:C284($StringDate_s)  // Command Replaced was o_C_STRING length was 10
$Return_d:=!00-00-00!
$Test_d:=!00-00-00!
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274($ParsedText_atxt))
	$StringDate_s:=$ParsedText_atxt{$Loop_l}
	$Test_d:=Date:C102($StringDate_s)
	If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
		If ($Return_d=!00-00-00!)
			$Return_d:=$Test_d
		Else 
			Case of 
				: ($Test_d=!00-00-00!)
				: ($Test_d<$Return_d)
					$Return_d:=$Test_d
				Else 
			End case 
		End if 
	End if 
End for 

$0:=$Return_d
//End ut_PRJReturnEarliestDate