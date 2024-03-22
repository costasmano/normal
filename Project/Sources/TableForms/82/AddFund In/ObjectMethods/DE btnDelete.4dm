If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 12:45:17)
	Mods_2006_CM03
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (OK=1)
		
		DELETE RECORD:C58([Contract AddFund:82])
		If (False:C215)
			If (Not:C34(Is new record:C668([Contract AddFund:82])))
				LogDeletion(->[Contracts:79]ContractNo:1; ->[Contract AddFund:82]ContractNo:1; ->[Contract AddFund:82]AddFund_ID:2; 1)
			End if 
		End if 
		
		CIR_RecalcAddFunds
		CANCEL:C270
		
	End if 
End if 