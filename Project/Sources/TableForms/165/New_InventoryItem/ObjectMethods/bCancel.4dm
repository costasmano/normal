
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/15, 14:21:40
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].New_InventoryItem.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/26/15 14:24:47)
End if 

CONFIRM:C162("Exit Inventory without saving new record?"; "Cancel"; "Exit")
If (OK=1)
Else 
	CANCEL TRANSACTION:C241
	CANCEL:C270
End if 

//End Object Method: [LSS_Inventory].New_InventoryItem.bCancel