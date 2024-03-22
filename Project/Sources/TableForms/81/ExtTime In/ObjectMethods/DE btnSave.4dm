If (Form event code:C388=On Clicked:K2:4)
	If (False:C215)
		If (Is new record:C668([Contract ExtendTime:81]))
			LogNewRecord(->[Contracts:79]ContractNo:1; ->[Contract ExtendTime:81]ContractNo:1; ->[Contract ExtendTime:81]EOT_ID:2; 1; "ExtTime")
		End if 
	End if 
	
	SAVE RECORD:C53([Contract ExtendTime:81])
	//get the most recent extension date
	ORDER BY:C49([Contract ExtendTime:81]; [Contract ExtendTime:81]InitialDate:6; <)
	FIRST RECORD:C50([Contract ExtendTime:81])
	[Contracts:79]ExtendedCompleteDate:6:=[Contract ExtendTime:81]ExtendedDate:7
	SAVE RECORD:C53([Contracts:79])
	CANCEL:C270
End if 