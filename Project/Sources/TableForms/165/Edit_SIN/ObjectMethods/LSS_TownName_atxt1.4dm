
If (False:C215)
	//Object Method: [LSS_Inventory].Edit_SIN.LSS_TownName_atxt 
	// Modified by: Costas Manousakis-(Designer)-(1/14/16 17:31:07)
	Mods_2016_01_bug
	//  `Addition of changing  the town/District
End if 

If (LSS_TownName_atxt>0)
	
	[LSS_Inventory:165]LSS_Town_s:4:=LSS_TownName_atxt{LSS_TownName_atxt}
	[LSS_Inventory:165]LSS_District_L:3:=Num:C11(LSS_TownDistrict_atxt{LSS_TownName_atxt})
	LSS_TownCode_s:=LSS_TownBDEPT_atxt{LSS_TownName_atxt}
	v_165_006_txt:=LSS_UpdateStructNumPart(v_165_006_txt; LSS_TownCode_s; 1)
End if 
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt

