//%attributes = {}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/13/12, 13:59:27
//----------------------------------------------------
//Method: fn_ReturnName
//Description
// Returns the name of a person from a pointer to a variable containing the id of the person from the [Personnel] table
// Parameters
// $0 : $s (name)
// $1 : pointer to var/field containing the id of the person
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 ` 
	//Modified by: Charles Miller (9/13/12 14:31:37)
	
End if 
C_TEXT:C284($0)
C_TEXT:C284($s)
C_LONGINT:C283($n)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($1)
$s:=Get_Description(->aPeople; ->aPeople_ID; $1)
If ($s="")
Else 
	$n:=Position:C15(" "; $s)
	$s:=Delete string:C232($s; 2; $n-2)
	$s:=Insert string:C231($s; "."; 2)
End if 
$0:=$s
//End fn_ReturnName