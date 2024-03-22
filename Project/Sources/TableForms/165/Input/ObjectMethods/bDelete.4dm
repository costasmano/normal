
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 16:36:27
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 16:36:28)
	Mods_2018_03_bug  //Fix issue where if you delete an [LSS_Inventory] record a blank row was displayed and LSS_InventoryRow_L could be greater than records in selection
	Mods_2018_03_bug  //Make LSS_InventoryRow_L = 1 after a delete so we always scroll to top of list
End if 
If (Records in selection:C76([LSS_Inspection:164])>0)
	ALERT:C41("You can not delete inventory records as there is at least one inspection associated with it.")
Else 
	CONFIRM:C162("Are you sure you wish to delete this inventory record?"; "DELETE"; "Skip")
	If (OK=1)
		C_TEXT:C284($Confirm_txt)
		
		C_LONGINT:C283($passwordErr_L)
		$Confirm_txt:="! ! ! WARNING : To Delete the inventory record, your password is required ! ! !"+<>sCR+"Enter your password to Delete the entire inspection or Cancel to abort the deleti"+"on!!"
		$Confirm_txt:=Uppercase:C13($Confirm_txt)
		$passwordErr_L:=OP_GetPassword($Confirm_txt)
		
		
		If ($passwordErr_L=0)
			
			LogDeletion(->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; 0)
			$Confirm_txt:=[LSS_Inventory:165]LSS_InventoryId_s:1
			DELETE RECORD:C58([LSS_Inventory:165])
			
			VALIDATE TRANSACTION:C240
			
			QUERY SELECTION:C341([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1#$Confirm_txt)
			COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
			
			LSS_InventoryRow_L:=1
			ACCEPT:C269
			
		End if 
		
	End if 
End if 
//End Object Method: [LSS_Inventory].Input.bDelete

