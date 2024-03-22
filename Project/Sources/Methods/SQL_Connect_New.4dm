//%attributes = {"invisible":true}
//Method: SQL_Connect_New
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/13/19, 11:43:15
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
C_TEXT:C284($currentErrCall_txt)
$currentErrCall_txt:=Method called on error:C704
C_BOOLEAN:C305($0)

SQLError_b:=False:C215
ON ERR CALL:C155("SQL_ERROR")

SQL LOGIN:C817(SQL_ODBCName_s; ""; ""; *)
ON ERR CALL:C155($currentErrCall_txt)
$0:=Not:C34(SQLError_b)
//End SQL_Connect_New