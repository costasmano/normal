//%attributes = {"invisible":true}
//GP Get_BDEPTP
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Given the Town, this procedure returns the next
//Bridge Department Number prefix.

C_TEXT:C284($1; $Town)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($0; $bdeptp)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$Town:=$1
$i:=Find in array:C230(<>aTownName; $Town)
$bdeptp:=<>aBDEPT{$i}
$0:=$bdeptp