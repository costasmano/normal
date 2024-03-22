If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 12:39:05)
	Mods_2006_CM03
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (False:C215)
		If (Is new record:C668([Contract FundTransfer:80]))
			LogNewRecord(->[Contracts:79]ContractNo:1; ->[Contract FundTransfer:80]ContractNo:1; ->[Contract FundTransfer:80]TOF_ID:2; 1; "FundTransfer")
		End if 
	End if 
	SAVE RECORD:C53([Contract FundTransfer:80])
	CIR_RecalcFundTransf
	CANCEL:C270
	
End if 