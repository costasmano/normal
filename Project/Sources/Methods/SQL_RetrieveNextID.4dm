//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 04/20/10, 11:00:19
// ----------------------------------------------------
// Method: SQL_RetrieveNextID
// Description
// 
//
// Parameters
//$1 sequence name to get number for
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:36:51)
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 16:58:38)
	//Ugrade to v11
	//Modified by: Charles Miller (5/3/11 10:27:47)
End if 

C_LONGINT:C283($0)
C_LONGINT:C283(NextID_l)

C_TEXT:C284($1; SQL_SequenceName_s)  // Command Replaced was o_C_STRING length was 40
SQL_SequenceName_s:=$1
C_TEXT:C284(SQLQuery_txt)

C_LONGINT:C283(NextID_l)

SQLQuery_txt:="SELECT {fn ut_NextSEQAL(<<SQL_SequenceName_s>>) AS NUMERIC} FROM Preferences INTO :NextID_l"
ON ERR CALL:C155("SQL_ERROR")  //
Begin SQL
	EXECUTE IMMEDIATE :SQLQuery_txt;
End SQL

//SQL CANCEL LOAD
ON ERR CALL:C155("4D_Errors")
$0:=NextID_l
