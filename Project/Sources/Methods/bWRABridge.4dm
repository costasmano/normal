//%attributes = {"invisible":true}
//GP: bWRABridge
//Copyright © 1995-1998,  Albert S. Leung, All Rights Reserved.
//Determine if it is a WRA bridge

C_BOOLEAN:C305($test)
C_TEXT:C284($prefix)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 12

If (Count parameters:C259=1)
	$prefix:=Substring:C12($1; 1; 3)
Else 
	//  $prefix:=Substring([Bridge MHD NBIS]Bridge Key;1;3)
	$prefix:=[Bridge MHD NBIS:1]Item8 Owner:208
End if 

$test:=($prefix="WRA")
$0:=$test  //Return true or false