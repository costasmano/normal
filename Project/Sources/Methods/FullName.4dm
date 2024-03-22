//%attributes = {}
//GP FullName(First;Middle;Last;Suffix;Prefix)
//Copyright © 1995-1996, Thomas D. Nee, All Rights Reserved.
//$4 and $5 are optional parameters.

C_TEXT:C284($0; $FullN)  // Command Replaced was o_C_STRING length was 88
C_TEXT:C284($First)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($Middle)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($Last)  // Command Replaced was o_C_STRING length was 24
C_TEXT:C284($Suffix)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284($Prefix)  // Command Replaced was o_C_STRING length was 6

$First:=$1
$Middle:=$2
$Last:=$3

$FullN:=""
If (Count parameters:C259=5)
	$Prefix:=$5
	If ($Prefix#"")
		$FullN:=$Prefix+" "
	End if 
End if 

$FullN:=$FullN+$First

If ($Middle#"")
	$FullN:=$FullN+" "+$Middle
End if 

$FullN:=$FullN+" "+$Last

If (Count parameters:C259>=4)
	$Suffix:=$4
	If ($Suffix#"")
		$FullN:=$FullN+$Suffix
	End if 
End if 

$0:=$FullN