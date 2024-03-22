//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/06/10, 16:40:22
// ----------------------------------------------------
// Method: ut_SQLWriteErrorsToLog
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (5/6/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:12:19) 
End if 
C_TEXT:C284($1)

ut_Message($1)
If (Size of array:C274(SQLErrorNumbers_al)>0)
	C_TEXT:C284($Error_txt)
	$Error_txt:="Error Number, Internal Code, Description"+<>sCR
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Size of array:C274(SQLErrorNumbers_al))
		$Error_txt:=$Error_txt+String:C10(SQLErrorNumbers_al{$Loop_l})+","+SQL_InternalCodes_atxt{$Loop_l}+","+SQL_InternalDescriptions_atxt{$Loop_l}+<>sCR
		If (Length:C16($Error_txt)>25000)
			ut_Message($Error_txt)
			$Error_txt:="'"
		End if 
	End for 
	If ($Error_txt#"")
		ut_Message($Error_txt)
	End if 
	ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
	ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
	ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
End if 