
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/29/16, 10:30:53
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].ListBoxOutput.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug  //  ` Add delete button to inventory list box when designer is logged in and special queries done
	//Modified by: administrator (2/29/16 10:30:55)
	
End if 
CONFIRM:C162("Are you sure you wish to delete the "+String:C10(Records in set:C195("InventorySet"))+" records?"; "Delete"; "No")
If (OK=1)
	UNLOAD RECORD:C212([LSS_Inventory:165])
	READ WRITE:C146([LSS_Inventory:165])
	
	CREATE SET:C116([LSS_Inventory:165]; "InventorySet1")
	DIFFERENCE:C122("InventorySet1"; "InventorySet2"; "InventorySet1")
	USE SET:C118("InventorySet1")
	Repeat 
		DELETE SELECTION:C66([LSS_Inventory:165])
		If (Records in set:C195("LockedSet")=0)
		Else 
			DELAY PROCESS:C323(Current process:C322; 60)
			USE SET:C118("LockedSet")
			ALERT:C41("There are "+String:C10(Records in set:C195("LockedSet"))+" locked LSS_Inventory records")
			
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
	USE SET:C118("InventorySet1")
	CLEAR SET:C117("InventorySet1")
	READ ONLY:C145([LSS_Inventory:165])
	LSS_SortInventory
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
	REDRAW:C174(Inventory_LB)
	WIN_SetWindowTitle(->[LSS_Inventory:165])
End if 

//End Object Method: [LSS_Inventory].ListBoxOutput.bDelete

