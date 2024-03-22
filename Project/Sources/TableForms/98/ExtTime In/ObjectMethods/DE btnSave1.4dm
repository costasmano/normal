If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/11/2006 08:55:58)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(5/15/2006 14:18:05)
	Mods_2006_CMz1
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (<>CM_LogChanges_b)
		If (Is new record:C668([ExtendTime_Maintenance:98]))
			LogNewRecord(->[Contract_Maintenance:97]ContractNo:1; ->[ExtendTime_Maintenance:98]ContractNo:1; ->[ExtendTime_Maintenance:98]EOT_ID:2; 1; "ExtTimeMaint")
		End if 
		FlushGrpChgs(2; ->[Contract_Maintenance:97]ContractNo:1; ->[ExtendTime_Maintenance:98]ContractNo:1; ->[ExtendTime_Maintenance:98]EOT_ID:2; 1)
	End if 
	
	SAVE RECORD:C53([ExtendTime_Maintenance:98])
	//update the FY fund data for curr FY
	QUERY:C277([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2=[ExtendTime_Maintenance:98]EOT_ID:2)
	If (Records in selection:C76([CM_ExtTimeFYAlloc:111])>0)
		ORDER BY:C49([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]FYear_I:4)
		GOTO SELECTED RECORD:C245([CM_ExtTimeFYAlloc:111]; 1)
		[CM_ExtTimeFYAlloc:111]FYAmmount_R:3:=CurrentFYFunds_R
		If (<>CM_LogChanges_b)
			LogChanges(->[CM_ExtTimeFYAlloc:111]FYAmmount_R:3; ->[ExtendTime_Maintenance:98]EOT_ID:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; 2)
		End if 
		SAVE RECORD:C53([CM_ExtTimeFYAlloc:111])
	End if 
	
	//get the most recent extension date
	CM_RecalcContrExtendDate
	CANCEL:C270
End if 