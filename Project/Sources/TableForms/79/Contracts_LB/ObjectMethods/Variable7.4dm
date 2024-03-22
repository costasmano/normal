If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 09:28:58)
	Mods_2021_10
	//  `unload record and reset headers
	
End if 

M_OmitSubset
ORDER BY:C49([Contracts:79]; [Contracts:79]ContractNo:1; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("Contract_LB")
//End of script