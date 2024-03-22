//%attributes = {"invisible":true}
//Method: SQL_ReturnErrorDescriptions
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/13/19, 12:36:21
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($Error_txt)
C_LONGINT:C283($loop_l)
For ($loop_l; 1; Size of array:C274(SQL_InternalDescriptions_atxt))
	$Error_txt:=$Error_txt+String:C10(SQLErrorNumbers_al{$loop_l})+", "+SQL_InternalDescriptions_atxt{$loop_l}+Char:C90(Carriage return:K15:38)
End for 
$0:=$Error_txt
//End SQL_ReturnErrorDescriptions