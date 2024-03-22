If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		DELETE RECORD:C58([Contract ExtendTime:81])
		
		//reset the Extended Date to the latest extended date    
		QUERY:C277([Contract ExtendTime:81]; [Contract ExtendTime:81]ContractNo:1=[Contracts:79]ContractNo:1)
		ORDER BY:C49([Contract ExtendTime:81]; [Contract ExtendTime:81]ExtendedDate:7; <)
		
		FIRST RECORD:C50([Contract ExtendTime:81])
		[Contracts:79]ExtendedCompleteDate:6:=[Contract ExtendTime:81]ExtendedDate:7
		
		If (False:C215)
			If (Not:C34(Is new record:C668([Contract ExtendTime:81])))
				LogDeletion(->[Contracts:79]ContractNo:1; ->[Contract ExtendTime:81]ContractNo:1; ->[Contract ExtendTime:81]EOT_ID:2; 1)
			End if 
		End if 
		
		CANCEL:C270
	End if 
End if 