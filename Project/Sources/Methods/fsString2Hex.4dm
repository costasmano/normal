//%attributes = {"invisible":true}
//fsStringtoHex
//return  a string with hex representation of an input string

C_TEXT:C284($0; $1; $s)

C_LONGINT:C283($vLength; $i)  //Command Replaced was o_C_INTEGER

$vLength:=Length:C16($1)
$s:=""
For ($i; 1; $vLength)
	$s:=$s+String:C10(Character code:C91($1[[$i]]); "&x")
End for 
$0:=$s