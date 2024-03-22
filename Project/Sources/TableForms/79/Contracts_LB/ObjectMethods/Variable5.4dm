If (False:C215)
	//Script: bzAll
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 09:28:58)
	Mods_2021_10
	//  `added default sort ; unload record and reset headers
	
End if 

M_ShowAllRecs
ORDER BY:C49([Contracts:79]; [Contracts:79]ContractNo:1; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("Contract_LB")
//M_GetRegion 
//End of script