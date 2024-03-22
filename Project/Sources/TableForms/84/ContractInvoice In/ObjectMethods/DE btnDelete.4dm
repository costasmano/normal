If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		DELETE RECORD:C58([Contract Invoice:84])
		If (False:C215)
			If (Not:C34(Is new record:C668([Contract Invoice:84])))
				LogDeletion(->[Contracts:79]ContractNo:1; ->[Contract Invoice:84]ContractNo:3; ->[Contract Invoice:84]InvoiceID:1; 1)
			End if 
			CANCEL:C270
		End if 
	End if 
End if 