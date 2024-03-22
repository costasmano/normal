//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 05/30/17, 16:18:11
//----------------------------------------------------
//Method: ut_DBSynchWriteOutErrors
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_05  //
	
	
	//Modified by: Chuck Miller (5/30/17 16:18:12)
	
End if 
C_TEXT:C284($1)

If (Size of array:C274(SQLErrorNumbers_al)>0)
	C_TEXT:C284($Error_txt)
	$Error_txt:="Error Number, Internal Code, Description of "+$1+" errors"+<>sCR
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Size of array:C274(SQLErrorNumbers_al))
		$Error_txt:=$Error_txt+String:C10(SQLErrorNumbers_al{$Loop_l})+","+SQL_InternalCodes_atxt{$Loop_l}+","+SQL_InternalDescriptions_atxt{$Loop_l}+<>sCR
	End for 
	ut_Message($Error_txt+Char:C90(13))
End if 

//End ut_DBSynchWriteOutErrors

