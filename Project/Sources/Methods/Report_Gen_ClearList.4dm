//%attributes = {"invisible":true}
// ----------------------------------------------------
// Report_Gen_ClearList
// User name (OS): cjmiller
// Date and time: 04/19/07, 13:06:40
// ----------------------------------------------------
// Description
// Clears any data in the list and initializes it again.
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 


C_POINTER:C301($1; $listPtr)

$listPtr:=$1

If (Is a list:C621($listPtr->))
	CLEAR LIST:C377($listPtr->; *)
End if 

$listPtr->:=New list:C375
SET LIST PROPERTIES:C387($listPtr->; 0; 0; 18)
REDRAW:C174($listPtr->)  // Command Replaced was o_REDRAW LIST 

//End Report_Gen_ClearList