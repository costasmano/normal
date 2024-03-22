//%attributes = {"invisible":true}
//GP ChkYear
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284($Year)
C_LONGINT:C283($YY)  //Command Replaced was o_C_INTEGER

$Year:=$1

$YY:=Num:C11($Year)
If ($YY<100)
	$YY:=$YY+1900
End if 

$0:=String:C10($YY)