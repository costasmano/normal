//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/11/10, 14:14:47
//----------------------------------------------------
//Method: ut_SQLReturnINSPRecordKeys
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 14:14:48)
End if 

C_TEXT:C284($1; $2)
v_59_001_txt:=$1
v_59_004_txt:=$2

C_BLOB:C604(Return_blb)
C_LONGINT:C283(SQLCount_l)
C_TEXT:C284($SQLQuery_txt)

$SQLQuery_txt:="SELECT  {fn ut_CTRLReturnINSPActKeys(:v_59_001_txt,:v_59_004_txt) AS NUMERIC} FROM Preferences "
ON ERR CALL:C155("SQL_ERROR")  //
SQL EXECUTE:C820($SQLQuery_txt; SQLCount_l)
While (Not:C34(SQL End selection:C821))
	SQL LOAD RECORD:C822
End while 
SQL CANCEL LOAD:C824
ON ERR CALL:C155("4D_Errors")
//End ut_SQLReturnINSPRecordKeys

