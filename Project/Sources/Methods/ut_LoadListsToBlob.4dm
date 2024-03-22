//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_LoadListsToBlob
// User name (OS): charlesmiller
// Date and time: 05/23/11, 10:29:15
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 pointer to blob
//$2 to n list names
// ----------------------------------------------------
If (False:C215)
	Mods_2011_05  //r002 CJ Miller`05/23/11, 10:29:17      `Fix bugs found during testing of initial release of v11
End if 
C_BLOB:C604($0; $Return_blb)
SET BLOB SIZE:C606($Return_blb; 0)
C_TEXT:C284(${1})
C_TEXT:C284($ListName_txt)
C_LONGINT:C283($Loop_l; $ListID_l)
For ($Loop_l; 1; Count parameters:C259)
	$ListID_l:=Load list:C383(${$Loop_l})
	$ListName_txt:=${$Loop_l}
	VARIABLE TO BLOB:C532($ListName_txt; $Return_blb; *)
	LIST TO BLOB:C556($ListID_l; $Return_blb; *)
End for 
$0:=$Return_blb
//End ut_LoadListsToBlob