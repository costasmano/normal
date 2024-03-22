If (False:C215)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 09:28:58)
	Mods_2021_10
	//  `added default sort ; unload record and reset headers
	
End if 

M_SearchbyContractNo("Conslt Rating")
ORDER BY:C49([Conslt Rating:63]; [Bridge MHD NBIS:1]BDEPT:1; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("List box")
