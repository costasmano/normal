//%attributes = {"invisible":true}
//GP: Blank Returns true if string is blank
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($test)

$test:=True:C214
For ($i; 1; Length:C16($1))
	If ($1[[$i]]#" ")
		$test:=False:C215
	End if 
End for 
$0:=$test