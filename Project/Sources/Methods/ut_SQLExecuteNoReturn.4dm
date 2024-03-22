//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/18/10, 11:36:32
// ----------------------------------------------------
// Method: ut_SQLExecuteNoReturn
// Description
// <caret/>
//ut_SQLExecuteNoReturn ($SQL_Delete_txt)
// Parameters
// ----------------------------------------------------
//$1 = Text of call

// Modified by: Charles Miller (6/18/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:14:21) 
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 17:00:36)
End if 

C_TEXT:C284($1; InternalSQLCall_txt)
InternalSQLCall_txt:=$1
ON ERR CALL:C155("SQL_ERROR")  //
Begin SQL
	EXECUTE IMMEDIATE :InternalSQLCall_txt;
End SQL
//SQL EXECUTE($SQLCall_txt)
//SQL CANCEL LOAD
ON ERR CALL:C155("4D_Errors")
