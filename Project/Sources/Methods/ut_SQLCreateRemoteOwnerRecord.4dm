//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 07/08/10, 14:10:45
// ----------------------------------------------------
// Method: ut_SQLCreateRemoteOwnerRecord
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (7/8/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:17:47) 
End if 
C_TEXT:C284($SQL_Insert_txt)

ARRAY LONGINT:C221(REFIDs_al; 0)
ARRAY TEXT:C222(REFOwners_as; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221(REFIDs_al; 1)
ARRAY TEXT:C222(REFOwners_as; 1)  //Command Replaced was o_ARRAY string length was 80
REFIDs_al{1}:=vKey_l
REFOwners_as{1}:=[Owners of Data:62]Owner Name:2
SQL_Command_txt:="INSERT INTO [Owners of Data] (RefID, [Owner Name]) VALUES (:REFIDs_al, :REFOwners_as);"
ON ERR CALL:C155("SQL_ERROR")  //
Begin SQL
	EXECUTE IMMEDIATE :SQL_Command_txt;
End SQL
C_BOOLEAN:C305($OriginalonScreen_b)
$OriginalonScreen_b:=vbOnScreenMessage

ON ERR CALL:C155("4D_Errors")
If (SQLError_b) | (4DError_b)
	ut_SQLWriteErrorsToLog("Error in insert "+Current method name:C684+" updating [Owners of Data] records -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
	vbOnScreenMessage:=False:C215
	ut_SQLWriteErrorsToLog(SQL_Command_txt+<>sCR)
Else 
	ut_Message("Insert [Owners of Data] records "+Current method name:C684+"  -ID "+String:C10(vKey_l)+<>sCR)
End if 

vbOnScreenMessage:=$OriginalonScreen_b
