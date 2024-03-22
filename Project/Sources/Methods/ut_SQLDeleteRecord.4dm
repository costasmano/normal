//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/04/10, 10:03:44
// ----------------------------------------------------
// Method: ut_SQLDeleteRecord
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------
//$0 boolean succeed or not
//$1 Number of records returned
//$2 Table name
//$3 Where part of query

// Modified by: Charles Miller (6/4/10)

If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:13:51) 
End if 
C_BOOLEAN:C305($0)

C_LONGINT:C283($1; $Numrec_l)
$Numrec_l:=$1
C_TEXT:C284($2; $3; $SQL_Delete_txt; $TableName_txt; $SQLWhereQuery_txt)

$TableName_txt:=$2
$SQLWhereQuery_txt:=$3
C_BOOLEAN:C305($OriginalonScreen_b)
$OriginalonScreen_b:=vbOnScreenMessage

If ($Numrec_l=1) & (Not:C34(SQLError_b))  //Make sure we just found one record!
	//OK now to delete it
	$SQL_Delete_txt:="DELETE FROM "+$TableName_txt+Char:C90(Carriage return:K15:38)+$SQLWhereQuery_txt+Char:C90(Carriage return:K15:38)
	ut_SQLExecuteNoReturn($SQL_Delete_txt)
	If (SQLError_b) | (4DError_b)
		ut_SQLWriteErrorsToLog("Act Log error in delete "+Current method name:C684+"  -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
		If (SQLError_b)
			vbOnScreenMessage:=False:C215
			ut_Message($SQL_Delete_txt)
		End if 
	Else 
		If (InGroupDelete_b)
		Else 
			ut_SQLUpdateServerActLog
		End if 
	End if 
	
Else 
	If (SQLError_b) | (4DError_b)
		ut_SQLWriteErrorsToLog("Act Log error in delete "+Current method name:C684+"  -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
	Else 
		ut_SQLWriteErrorsToLog("Act Log error records found is not = 1 "+Current method name:C684+"  -ID "+String:C10([Activity Log:59]RefID:28)+" "+String:C10($Numrec_l)+" records returned"+<>sCR)
	End if 
End if 
Case of 
	: (SQLError_b)
		$0:=False:C215
	: (4DError_b)
		$0:=False:C215
	Else 
		$0:=True:C214
End case 

vbOnScreenMessage:=$OriginalonScreen_b