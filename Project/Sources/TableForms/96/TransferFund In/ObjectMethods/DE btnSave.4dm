If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/16/2006 15:37:36)
	Mods_2006_CM03
End if 
If (Form event code:C388=On Clicked:K2:4)
	If (False:C215)
		If (Is new record:C668([FundTransfer_Maintenance:96]))
			LogNewRecord(->[Contract_Maintenance:97]ContractNo:1; ->[FundTransfer_Maintenance:96]ContractNo:1; ->[FundTransfer_Maintenance:96]TOF_ID:2; 1; "FundTransMaint")
		End if 
	End if 
	
	SAVE RECORD:C53([FundTransfer_Maintenance:96])
	CM_RecalcFundTransf
	CANCEL:C270
End if 