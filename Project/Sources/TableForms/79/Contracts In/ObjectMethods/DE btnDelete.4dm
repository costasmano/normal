If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		DELETE RECORD:C58([Contracts:79])
		
		If (False:C215)
			If (Not:C34(Is new record:C668([Contracts:79])))
				LogDeletion(->[Contracts:79]ContractID:29; ->[Contracts:79]ContractID:29; ->[Contracts:79]ContractID:29; 1)
			End if 
		End if 
		
		CANCEL:C270
	End if 
End if 