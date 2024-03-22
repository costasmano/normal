//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/23/12, 13:32:01
//----------------------------------------------------
//Method: SIA_GoToPage
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r003
	//Modified by: Charles Miller (2/23/12 13:32:02)
	Mods_2012_04  // ` duplicated in set up phase SIA_SetUpListBoxes do not need it here
	//Modified by: Charles Miller (4/17/12 )
	Mods_2013_01  //r001 ` removed code that was dupliacted from method as it was an in if (false) block
	//Modified by: Charles Miller (1/15/13 16:14:56)
End if 
C_LONGINT:C283($1; $PageNumber_L)
$PageNumber_L:=$1
FORM GOTO PAGE:C247($PageNumber_L)

//End SIA_GoToPage