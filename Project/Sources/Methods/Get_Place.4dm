//%attributes = {"invisible":true}
//GP Get_Place
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
//Returns Place given the bdept

C_TEXT:C284($bdeptp)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($bdept)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($Place; $0)  // Command Replaced was o_C_STRING length was 5
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$bdept:=$1
$bdeptp:=Substring:C12($bdept; 1; 3)  //get the prefix of the BDEPT
$i:=Find in array:C230(<>aBDEPT; $bdeptp)
If ($i>0)
	$Place:=<>aPlace_Code{$i}
Else 
	$Place:="?"
End if 
$0:=$Place