If (False:C215)
	Mods_2006_CMz1
End if 

//verify that FY fund allocations are at least the same as the old extend date
C_TEXT:C284($msg)
C_LONGINT:C283($i; $numFYFunds)  //Command Replaced was o_C_INTEGER
If (Is new record:C668([ExtendTime_Maintenance:98]))
	$msg:="Cancel New Extension of Time?"
	QUERY:C277([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2=[ExtendTime_Maintenance:98]EOT_ID:2)
	$numFYFunds:=Records in selection:C76([CM_ExtTimeFYAlloc:111])
	CONFIRM:C162($msg; "Yes"; "No, continue Editing")
	If (OK=1)
		QUERY:C277([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2=[ExtendTime_Maintenance:98]EOT_ID:2)
		If ($numFYFunds>0)
			If (<>CM_LogChanges_b)
				For ($i; 1; $numFYFunds)
					GOTO SELECTED RECORD:C245([CM_ExtTimeFYAlloc:111]; $i)
					PushGrpDelete(->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1)
				End for 
				FlushGrpDeletions(->[ExtendTime_Maintenance:98]EOT_ID:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; 2)
			End if 
			DELETE SELECTION:C66([CM_ExtTimeFYAlloc:111])
		End if 
		CANCEL:C270
	End if 
	
Else 
	
	If (vCM_ExtTimFYFundChg_b)
		$msg:="Changes have been made and saved to Fund Allocations for Future FYs!"
		$msg:=$msg+<>sCR+"Canceling will not Undo these Changes!"
		$msg:=$msg+<>sCR+"To Cancel these changes you have to undo them manually."
		$msg:=Uppercase:C13($msg)
		$msg:=$msg+<>sCR+"Continue with cancel?"
		CONFIRM:C162($msg; "Continue"; "Stop")
		If (OK=1)
			CANCEL:C270
		End if 
		$msg:=""
	Else 
		CANCEL:C270
	End if 
End if 

