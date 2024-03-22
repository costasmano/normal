//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 07/29/10, 13:54:03
// ----------------------------------------------------
// Method: ut_SQLWriteCommonError
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (7/29/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:20:18) 
End if 
C_BOOLEAN:C305($OriginalonScreen_b)
$OriginalonScreen_b:=vbOnScreenMessage
C_TEXT:C284($1; $3)
C_LONGINT:C283($2; $Numrec_l)
$Numrec_l:=$2
C_TEXT:C284($SQLSelectQuery_txt)
$SQLSelectQuery_txt:=$3
If (SQLError_b) | (4DError_b)
	ut_SQLWriteErrorsToLog("Act Log error in select "+$1+"  -ID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
	vbOnScreenMessage:=False:C215
	ut_Message($SQLSelectQuery_txt)
Else 
	ut_SQLWriteErrorsToLog("Act Log error in select "+$1+"  -ID "+String:C10([Activity Log:59]RefID:28)+" "+String:C10($Numrec_l)+" records returned"+<>sCR)
End if 


