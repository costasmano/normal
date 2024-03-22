//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/25/10, 16:49:02
// ----------------------------------------------------
// Method: ut_SQLTellServeLNK
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------
// Parameters

// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:13:39) 
End if 

C_LONGINT:C283($Numrec_l)
C_LONGINT:C283($j; $n)
C_TEXT:C284(aStuff)  // Command Replaced was o_C_STRING length was 80
C_REAL:C285(rStuff)
C_TEXT:C284(tStuff)
C_DATE:C307(dStuff)
C_BOOLEAN:C305(bStuff)
C_LONGINT:C283(lStuff)
C_TIME:C306(timeStuff)
C_PICTURE:C286(picStuff)
C_BLOB:C604(xStuff)

C_BOOLEAN:C305(SQLError_b)
SQLError_b:=False:C215
C_TEXT:C284($SQLWhereQuery_txt; $SQLSelectQuery_txt)
$SQLSelectQuery_txt:=ut_SQLReturnSelect(->$SQLWhereQuery_txt)
$Numrec_l:=ut_SQLSelectForLoad($SQLWhereQuery_txt; [Activity Log:59]Local Type:18)


C_TEXT:C284($Upd_FieldName_txt; $UpdTableName_txt)
If ($Numrec_l=1) & (Not:C34(SQLError_b))  //Make sure we just found one record!
	
Else 
	If (SQLError_b)
		ut_SQLWriteErrorsToLog("Act Log error in select "+Current method name:C684+"  -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
	Else 
		ut_SQLWriteErrorsToLog("Act Log error in select "+Current method name:C684+"  -ID "+String:C10([Activity Log:59]RefID:28)+" "+String:C10($Numrec_l)+" records returned"+<>sCR)
	End if 
End if 
