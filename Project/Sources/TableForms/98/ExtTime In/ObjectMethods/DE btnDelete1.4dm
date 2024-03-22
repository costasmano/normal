If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/11/2006 08:55:33)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(5/15/2006 14:16:45)
	Mods_2006_CMz1
	// Modified by: costasmanousakis-(Designer)-(12/17/07 09:06:58)
	Mods_2007_CM_5401
	//  `Fix in FlushGrpDeletions code
	Mods_2011_06  // CJ Miller`06/20/11, 11:34:43      ` Type all local variables for v11
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (OK=1)
		QUERY:C277([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2=[ExtendTime_Maintenance:98]EOT_ID:2)
		If (Records in selection:C76([CM_ExtTimeFYAlloc:111])>0)
			If (<>CM_LogChanges_b)
				C_LONGINT:C283($i)
				For ($i; 1; Records in selection:C76([CM_ExtTimeFYAlloc:111]))
					GOTO SELECTED RECORD:C245([CM_ExtTimeFYAlloc:111]; $i)
					PushGrpDelete(->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1)
				End for 
				FlushGrpDeletions(->[ExtendTime_Maintenance:98]EOT_ID:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; 2)
			End if 
			DELETE SELECTION:C66([CM_ExtTimeFYAlloc:111])
		End if 
		
		If (<>CM_LogChanges_b)
			If (Not:C34(Is new record:C668([ExtendTime_Maintenance:98])))
				LogDeletion(->[Contract_Maintenance:97]ContractNo:1; ->[ExtendTime_Maintenance:98]ContractNo:1; ->[ExtendTime_Maintenance:98]EOT_ID:2; 1)
			End if 
		End if 
		
		DELETE RECORD:C58([ExtendTime_Maintenance:98])
		CM_RecalcContrExtendDate
		CANCEL:C270
	End if 
End if 