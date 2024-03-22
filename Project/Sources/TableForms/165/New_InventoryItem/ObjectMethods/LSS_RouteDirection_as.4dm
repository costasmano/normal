
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 13:17:11
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory]."New_InventoryItem".LSS_Cities_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:11)
End if 

If (LSS_RouteDirection_as>1)
	
	[LSS_Inventory:165]LSS_RouteDirection_s:14:=LSS_RouteDirection_as{LSS_RouteDirection_as}
	LSS_SetInventoryNumber(False:C215)
End if 
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt
