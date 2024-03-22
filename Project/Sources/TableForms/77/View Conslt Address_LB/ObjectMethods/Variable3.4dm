If (False:C215)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at end - reset LB headers
	
End if 

M_SearchConsltAddress
ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ConsltName:2; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("SelectListBox")


