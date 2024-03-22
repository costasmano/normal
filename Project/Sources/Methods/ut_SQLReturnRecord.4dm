//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/21/10, 15:30:53
// ----------------------------------------------------
// Method: ut_SQLReturnRecord
//ut_SQLReturnRecord ($SQL_Select_txt;"[Activity_Log]";String(vKey_l))
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (6/21/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:16:08) 
End if 
C_TEXT:C284($1; $2; $3; $Key_txt; $Table_txt)
$Table_txt:=$2
$Key_txt:=$3


C_TEXT:C284(SQL_Command_txt)

SQL_Command_txt:=$1
SQLError_b:=False:C215
4DError_b:=False:C215
C_BOOLEAN:C305($OriginalonScreen_b)

ON ERR CALL:C155("SQL_ERROR")

Begin SQL
	EXECUTE IMMEDIATE :SQL_Command_txt;
End SQL
ON ERR CALL:C155("4D_Errors")
$OriginalonScreen_b:=vbOnScreenMessage
$Table_txt:=$2
$Key_txt:=$3
C_TEXT:C284($SQLSelectQuery_txt)

If (SQLError_b) | (4DError_b)
	ut_SQLWriteErrorsToLog("Error in select "+$Table_txt+Current method name:C684+"-ID"+$Key_txt+<>sCR)
	vbOnScreenMessage:=False:C215
	ut_Message($SQLSelectQuery_txt)
Else 
	ut_Message("Select "+$Table_txt+"  -ID "+$Key_txt+" "+$Table_txt+" record returned"+<>sCR)
End if 
vbOnScreenMessage:=$OriginalonScreen_b

//End ut_SQLReturnRecord