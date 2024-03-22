If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (OK=1)
		
		DELETE RECORD:C58([AddFund_Maintenance:99])
		If (False:C215)
			If (Not:C34(Is new record:C668([AddFund_Maintenance:99])))
				LogDeletion(->[Contract_Maintenance:97]ContractNo:1; ->[AddFund_Maintenance:99]ContractNo:1; ->[AddFund_Maintenance:99]AddFund_ID:2; 1)
			End if 
		End if 
		CM_RecalcAddFunds
		CANCEL:C270
	End if 
End if 