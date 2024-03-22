//%attributes = {"invisible":true}
//GP ConvertBIN
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Converts an integer BIN to a 3-digit alphanumeric BIN.

C_LONGINT:C283($1; $BIN_Dec; $OOM)
C_TEXT:C284($0; $BIN)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($int; $i)  //Command Replaced was o_C_INTEGER// **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_TEXT:C284($BIN_Chars)  // Command Replaced was o_C_STRING length was 32
$BIN_Chars:="0123456789ABCDEFGHJKLMNPQRTUVWXY"

$BIN_Dec:=$1

For ($i; 1; 3)
	$OOM:=32^(3-$i)  //Order of Magnitude.
	$int:=Int:C8($BIN_Dec/$OOM)
	//Convert the digit from 0-31 to its BIN equivalent 0-9;A-H;J-N;P-R;T-Y.
	If (($int>=0) & ($int<=31))
		$BIN:=Insert string:C231($BIN; $BIN_Chars[[$int+1]]; $i)
	Else 
		$BIN:=Insert string:C231($BIN; "?"; $i)
	End if 
	$BIN_Dec:=$BIN_Dec%$OOM
End for 

$0:=$BIN