
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 13:17:11
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:1
End if 

If (LSS_TownName_atxt>0)
	
	[LSS_Inventory:165]LSS_Town_s:4:=LSS_TownName_atxt{LSS_TownName_atxt}
	[LSS_Inventory:165]LSS_District_L:3:=Num:C11(LSS_TownDistrict_atxt{LSS_TownName_atxt})
	LSS_TownCode_s:=LSS_TownBDEPT_atxt{LSS_TownName_atxt}
	LSS_SIN_2_L:=0
	LSS_SetInventoryNumber
End if 
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt

