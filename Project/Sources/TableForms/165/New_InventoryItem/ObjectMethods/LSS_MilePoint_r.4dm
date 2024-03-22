
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 14:46:25
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_MilePoint_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:11)
End if 
If ([LSS_Inventory:165]LSS_MilePoint_r:8#0)
	[LSS_Inventory:165]LSS_KiloPoint_r:7:=Round:C94([LSS_Inventory:165]LSS_MilePoint_r:8/0.621371; 2)
Else 
	
	If ([LSS_Inventory:165]LSS_KiloPoint_r:7#0)
		[LSS_Inventory:165]LSS_MilePoint_r:8:=Round:C94([LSS_Inventory:165]LSS_KiloPoint_r:7*0.621371; 2)
	End if 
	
End if 

LSS_SetInventoryNumber(False:C215)
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_MilePoint_r

