If (Form event code:C388=On Clicked:K2:4)
	If (False:C215)
		If (Is new record:C668([Contracts:79]))
			LogNewRecord(->[Contracts:79]ContractID:29; ->[Contracts:79]ContractID:29; ->[Contracts:79]ContractID:29; 1; "Contract")
		End if 
	End if 
	//SAVE RECORD([Contracts])
End if 