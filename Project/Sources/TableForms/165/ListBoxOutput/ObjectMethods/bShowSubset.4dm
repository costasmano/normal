If (Records in set:C195("InventorySet")>0)
	C_BOOLEAN:C305($SpecialQuery_B)
	C_LONGINT:C283($Count_L)
	USE SET:C118("InventorySet")
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	ARRAY TEXT:C222($InventoryKeys_atxt; 0)
	SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_InventoryId_s:1; $InventoryKeys_atxt)
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryKeys_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$SpecialQuery_B:=($Count_L=0)
	// allow the delete button on the list only if there are no inspections for any of the inventory records
	OBJECT SET VISIBLE:C603(*; "bDelete@"; (Current user:C182="Designer") & ($SpecialQuery_B))
	LSS_SortInventory
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
	WIN_SetWindowTitle(->[LSS_Inventory:165])
	
Else 
	ALERT:C41("You Have Not Selected Any Records!")
End if 
