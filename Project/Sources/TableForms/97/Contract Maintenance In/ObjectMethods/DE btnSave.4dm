If (Form event code:C388=On Clicked:K2:4)
	If (False:C215)
		If (Is new record:C668([Contract_Maintenance:97]))
			LogNewRecord(->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; 1; "ContractMaint")
		End if 
	End if 
	//SAVE RECORD([Contract_Maintenance])
End if 