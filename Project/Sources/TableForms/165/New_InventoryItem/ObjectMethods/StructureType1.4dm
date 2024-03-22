
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 16:51:12
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].New_InventoryItem.v_171_003_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:11)
End if 

If (v_171_003_atxt>0)
	[LSS_Inventory:165]LSS_StructureTypeId_s:25:=v_171_001_atxt{v_171_003_atxt}
	LSS_SetInventoryNumber(False:C215)
End if 
//End Object Method: [LSS_Inventory].New_InventoryItem.v_171_003_txt

