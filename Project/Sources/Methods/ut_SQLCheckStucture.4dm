//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/19/11, 12:08:54
//----------------------------------------------------
//Method: ut_SQLCheckStucture
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (8/19/11 12:09:01)
End if 
C_TEXT:C284(sdbStructureName)
C_TEXT:C284(SQLQuery_txt)

SQLQuery_txt:="SELECT {fn ut_ReturnStructureName() AS TEXT} FROM Preferences INTO :sdbStructureName;"
ON ERR CALL:C155("SQL_ERROR")  //

Begin SQL
	EXECUTE IMMEDIATE :SQLQuery_txt;
End SQL


//End ut_SQLCheckStucture

