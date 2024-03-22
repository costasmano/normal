If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		
		If (False:C215)
			If (Not:C34(Is new record:C668([Addendum_Maintenance:102])))
				LogDeletion(->[Contract_Maintenance:97]ContractNo:1; ->[Addendum_Maintenance:102]ContractNo:5; ->[Addendum_Maintenance:102]AddendumID:1; 1)
			End if 
		End if 
		
		DELETE RECORD:C58([Addendum_Maintenance:102])
		
		CM_CalculateNegotiatedCosts
		SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
		CANCEL:C270
		
	End if 
End if 