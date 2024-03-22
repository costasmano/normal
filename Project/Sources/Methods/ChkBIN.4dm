//%attributes = {"invisible":true}
//GP ChkBIN
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284($BIN)

$BIN:=$1
$BIN:=Strip($BIN)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
For ($i; 1; Length:C16($BIN))
	Case of 
		: ($BIN[[$i]]="O")
			$BIN[[$i]]:="0"
		: ($BIN[[$i]]="I")
			$BIN[[$i]]:="1"
		: ($BIN[[$i]]="Z")
			$BIN[[$i]]:="2"
		: ($BIN[[$i]]="S")
			$BIN[[$i]]:="5"
	End case 
End for 

$0:=$BIN