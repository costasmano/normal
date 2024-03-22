//%attributes = {"invisible":true}
If (False:C215)
	//boolean function: bOnSystem
	//by: Albert Leung
	//created: 10/1/97
	//purpose: Check to see if this bridge is an on system bridge
End if 

C_BOOLEAN:C305($test; $0)
C_TEXT:C284($Item26; $1)  // Command Replaced was o_C_STRING length was 2

If (Count parameters:C259=1)
	$Item26:=$1
Else 
	$Item26:=[Bridge MHD NBIS:1]Item26:120
End if 

$test:=(Position:C15($Item26; "01.02.11.12.14.06.07.16.17")>0)

$0:=$test