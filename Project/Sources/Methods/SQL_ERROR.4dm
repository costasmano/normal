//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/11/10, 11:36:27
//----------------------------------------------------
//Method: SQL_ERROR
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:36:28)
	// Modified by: Costas Manousakis-(Designer)-(6/19/14 16:49:33)
	Mods_2014_06_bug
	4D_Errors
	//  `temporarily added code to write the error codes
End if 


ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)


If (False:C215)
	C_TEXT:C284($Error_txt)
	$Error_txt:="Error Number, Internal Code, Description"+<>sCR
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Size of array:C274(SQLErrorNumbers_al))
		$Error_txt:=$Error_txt+String:C10(SQLErrorNumbers_al{$Loop_l})+","+SQL_InternalCodes_atxt{$Loop_l}+","+SQL_InternalDescriptions_atxt{$Loop_l}+<>sCR
	End for 
	ut_Message($Error_txt+Char:C90(13))
	
End if 

SQLError_b:=True:C214
//End SQL_ERROR