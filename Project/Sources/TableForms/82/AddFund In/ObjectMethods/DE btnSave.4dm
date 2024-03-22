If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 12:45:17)
	Mods_2006_CM03
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (False:C215)
		If (Is new record:C668([Contract AddFund:82]))
			LogNewRecord(->[Contracts:79]ContractNo:1; ->[Contract AddFund:82]ContractNo:1; ->[Contract AddFund:82]AddFund_ID:2; 1; "AddFund")
		End if 
	End if 
	SAVE RECORD:C53([Contract AddFund:82])
	
	CIR_RecalcAddFunds
	CANCEL:C270
End if 