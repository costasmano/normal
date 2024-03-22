//%attributes = {}
//GP Strip
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
//Strip out spaces, dashes, etc.; convert all text to uppercase.

C_TEXT:C284($text; $0; $1)
C_TEXT:C284($ch)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($i)
$text:=$1
$text:=Uppercase:C13($text)
$i:=1
While ($i<=Length:C16($text))
	$ch:=$text[[$i]]
	If (($ch=" ") | ($ch="-") | ($ch="'") | ($ch="`") | ($ch="/") | ($ch=".") | ($ch=","))
		//Strip out the unwanted character.    
		$text:=Delete string:C232($text; $i; 1)
	Else 
		//Increment the counter to check the next character.    
		$i:=$i+1
	End if 
End while 

$0:=$text