If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/16/2006 15:37:36)
	Mods_2006_CM03
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (OK=1)
		
		DELETE RECORD:C58([FundTransfer_Maintenance:96])
		
		If (False:C215)
			If (Not:C34(Is new record:C668([FundTransfer_Maintenance:96])))
				LogDeletion(->[Contract_Maintenance:97]ContractNo:1; ->[FundTransfer_Maintenance:96]ContractNo:1; ->[FundTransfer_Maintenance:96]TOF_ID:2; 1)
			End if 
		End if 
		CM_RecalcFundTransf
		CANCEL:C270
	End if 
End if 