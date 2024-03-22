//%attributes = {"invisible":true}
//Global Procedure: Returns Town Name given the bdept
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.

//TRACE
C_TEXT:C284($bdeptp)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($bdept)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$bdept:=$1
$bdeptp:=Substring:C12($bdept; 1; 3)  //get the prefix of the BDEPT
$i:=Find in array:C230(<>aBDEPT; $bdeptp)
If ($i>0)
	$0:=<>aTownName{$i}  //Return town name
Else 
	$0:="Town Unknown"
End if 