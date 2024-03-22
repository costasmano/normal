//%attributes = {"invisible":true}
// Method: ut_SQLDeleteLocalRecord
// Description
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Charles Miller
	// Date and time: 07/08/10, 14:47:31
	// ----------------------------------------------------
	// Modified by: Charles Miller (7/8/10)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:18:07) 
	Mods_2016_01_bug  //   `FIX BUG WHERE [Activity Log] records were being created where they should not have been  
	//Modified by: administrator (1/5/16 14:16:58)
End if 

C_TEXT:C284($RefID_s; $ParentID_s; $LocalID_s)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($RefID_l)

C_POINTER:C301($LocalTable_ptr; $LocalFld_ptr)
$LocalTable_ptr:=Table:C252([Activity Log:59]FileID Local:24)

ut_SQLGetCorrectRecord(->$LocalID_s; ->$ParentID_s)

[Activity Log:59]Local ID:15:=$LocalID_s
[Activity Log:59]Parent ID:14:=$ParentID_s

SAVE RECORD:C53([Activity Log:59])
If (Records in selection:C76($LocalTable_ptr->)=1)
	C_LONGINT:C283($RetryCount_l)
	$RetryCount_l:=0
	Repeat 
		DELETE SELECTION:C66($LocalTable_ptr->)
		IDLE:C311
		If (Records in set:C195("LockedSet")=1)
			DELAY PROCESS:C323(Current process:C322; 60)
			$RetryCount_l:=$RetryCount_l+1
		End if 
	Until (Records in set:C195("LockedSet")=0) | ($RetryCount_l>10)
	If (Records in set:C195("LockedSet")>0)
		ut_Message("One record in table "+Table name:C256($LocalTable_ptr)+" was locked. Canceling Deletion.."+<>sCR)
		DeletionOK_b:=False:C215
	Else 
		ut_Message("Deleted "+String:C10(1)+" Records in table "+Table name:C256($LocalTable_ptr)+" .."+<>sCR)
		DeletionOK_b:=True:C214
	End if 
Else 
	//what do we do here cancel all or just report - report
	DataRefernceError_b:=True:C214  //this will allow to mark on the remote server as received but Cancel transaction locally
	ut_Message("Data reference error! Data ignored!"+<>sCR)
End if 
If (4DError_b)
	C_BOOLEAN:C305($OriginalonScreen_b)
	$OriginalonScreen_b:=vbOnScreenMessage
	vbOnScreenMessage:=False:C215
	ut_SQLWriteErrorsToLog("Act Log error in "+Current method name:C684+"  -ID"+String:C10([Activity Log:59]RefID:28)+<>sCR)
	vbOnScreenMessage:=$OriginalonScreen_b
End if 