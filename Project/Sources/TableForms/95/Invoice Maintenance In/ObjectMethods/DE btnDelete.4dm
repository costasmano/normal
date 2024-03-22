If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		DELETE RECORD:C58([Invoice_Maintenance:95])
		If (False:C215)
			If (Not:C34(Is new record:C668([Invoice_Maintenance:95])))
				LogDeletion(->[Contract_Maintenance:97]ContractNo:1; ->[Invoice_Maintenance:95]ContractNo:3; ->[Invoice_Maintenance:95]InvoiceID:1; 1)
			End if 
		End if 
		CANCEL:C270
	End if 
End if 