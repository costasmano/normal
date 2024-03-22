//%attributes = {"invisible":true}
//fRemoveChar($ch;$s)
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//Takes a string and removes the designated character from the string
//
//$ch=$1 character to be removed
//$s=$2 source

C_TEXT:C284($ch)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($p)  //Command Replaced was o_C_INTEGER

$ch:=$1
$s:=$2

If (Length:C16($ch)=1)  //Don't allow invalid characters
	While (Position:C15($ch; $s)#0)
		$p:=Position:C15($ch; $s)
		$s:=Delete string:C232($s; $p; 1)
	End while 
	$0:=$s  //Return modified string
End if 