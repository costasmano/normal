
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/02/14, 13:34:23
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Input.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 13:34:24)
	
End if 

If (LSS_AllowInventoryEdit_B)
	
	If (Modified record:C314([LSS_Inventory:165]))
		CONFIRM:C162("Exit Inventory record without saving?"; "Stay in form"; "Exit without saving")
		
		If (OK=1)
			//FM_SaveInventoryInput 
			//ACCEPT
		Else 
			CANCEL TRANSACTION:C241
			CANCEL:C270
		End if 
	Else 
		CANCEL TRANSACTION:C241
		CANCEL:C270
		
	End if 
Else 
	CANCEL:C270
End if 
//End Object Method: [LSS_Inventory].Input.bCancel

