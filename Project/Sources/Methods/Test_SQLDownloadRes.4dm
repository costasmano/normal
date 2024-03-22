//%attributes = {"invisible":true}
//Method: Test_SQLDownloadRes
//Description
// start of test to download resource from a server in an activity log record - probably would be called in the downloadrecords
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/19/17, 13:06:36
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
End if 
//

C_TEXT:C284($LocalID_s; $ParentID_s; $RefID_s)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($RefID_l)
C_POINTER:C301($LocalTable_ptr; $LocalFld_ptr; $idparent; $ParentTable_ptr; $ParentField_ptr)
SaveActivityLogRecord_b:=True:C214


If (Not:C34(4DError_b))
	If (SaveActivityLogRecord_b)
		
		
		If (4DError_b)
			If (False:C215)
				
				4DError_b:=False:C215
			Else 
				//any other error - write the error and don't save act log record
				C_BOOLEAN:C305($OriginalonScreen_b)
				$OriginalonScreen_b:=vbOnScreenMessage
				vbOnScreenMessage:=False:C215
				ut_SQLWriteErrorsToLog("Error updating resource ["+<>sCR)
				vbOnScreenMessage:=$OriginalonScreen_b
				SaveActivityLogRecord_b:=False:C215
				
			End if 
		Else 
			ut_Message("Updated resource "+<>sCR)
			
		End if 
		
		
		If (SaveActivityLogRecord_b)
			//reset in case something has changed
			SAVE RECORD:C53([Activity Log:59])
		End if 
	Else 
		UNLOAD RECORD:C212([Activity Log:59])
		ut_Message("Resource skipped : "+<>sCR)
	End if 
Else 
	
	C_BOOLEAN:C305($OriginalonScreen_b)
	$OriginalonScreen_b:=vbOnScreenMessage
	vbOnScreenMessage:=False:C215
	ut_SQLWriteErrorsToLog("Act Log error in "+Current method name:C684+"  -ID"+String:C10([Activity Log:59]RefID:28)+<>sCR)
	vbOnScreenMessage:=$OriginalonScreen_b
	
End if 
//End Test_SQLDownloadRes