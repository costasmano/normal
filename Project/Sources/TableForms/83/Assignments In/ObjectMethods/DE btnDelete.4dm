If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (OK=1)
		
		If (False:C215)
			If (Not:C34(Is new record:C668([Contract Assignments:83])))
				LogDeletion(->[Contracts:79]ContractNo:1; ->[Contract Assignments:83]ContractNo:1; ->[Contract Assignments:83]AssignID:3; 1)
			End if 
		End if 
		
		DELETE RECORD:C58([Contract Assignments:83])
		
		//update approx and actual spent in [Contracts]  
		CIR_RecalcAssgnFunds(True:C214)  //update/Save Contracts record
		CANCEL:C270
		
	End if 
End if 