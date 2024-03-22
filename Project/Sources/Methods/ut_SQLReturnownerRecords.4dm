//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/28/10, 16:53:21
// ----------------------------------------------------
// Method: ut_SQLReturnownerRecords
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:54:31)
End if 

ON ERR CALL:C155("SQL_Error")
C_TEXT:C284($SQL_Text)
$SQL_Text:="Select [Owner Name] from [Owners of Data] where RefID = :vKey_l;"

ARRAY TEXT:C222(Owners_atxt; 0)
C_BOOLEAN:C305($OriginalonScreen_b)

SQL EXECUTE:C820($SQL_Text; Owners_atxt)

While (Not:C34(SQL End selection:C821)) & (Not:C34(SQLError_b))
	SQL LOAD RECORD:C822(SQL all records:K49:10)
End while 
SQL CANCEL LOAD:C824

ON ERR CALL:C155("4D_Errors")
$OriginalonScreen_b:=vbOnScreenMessage

If (SQLError_b) | (4DError_b)
	ut_SQLWriteErrorsToLog("Act Log error on retrieve "+Current method name:C684+" for [Owners of Data] records -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
	vbOnScreenMessage:=False:C215
	ut_SQLWriteErrorsToLog($SQL_Text+<>sCR)
End if 
vbOnScreenMessage:=$OriginalonScreen_b
//Endf ut_SQLReturnownerRecords