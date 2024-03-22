If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at end - reset LB headers
	
End if 

M_GetRegion
ORDER BY:C49([Town Address:78]; [Town Address:78]TownName:2; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("TownAddressLB")
aDistrictSelect:=0