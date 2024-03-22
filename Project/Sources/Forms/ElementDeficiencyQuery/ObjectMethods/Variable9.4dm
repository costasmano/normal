//Method: ElementDeficiencyQuery.Variable9
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/26/19, 14:41:03
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02
End if 
//
If (cbAddTo=1)
	Case of 
		: (Records in set:C195("LSS_InventorySet")=0)
			USE SET:C118("InventoryStartSet")
		: (Records in set:C195("InventoryStartSet")=0)
			
		Else 
			UNION:C120("LSS_InventorySet"; "InventoryStartSet"; "LSS_InventorySet")
			USE SET:C118("LSS_InventorySet")
	End case 
	
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
	
End if 
//End ElementDeficiencyQuery.Variable9