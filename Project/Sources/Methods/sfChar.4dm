//%attributes = {"invisible":true}
If (False:C215)
	//procedure: sfChar
	//return a string of characters  
End if 

C_TEXT:C284($1; $c)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($2; $i; $nchar)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($s; $0)

$nchar:=$2
$c:=$1
$s:=""

For ($i; 1; $nchar)
	$s:=$s+$c
End for 

$0:=$s