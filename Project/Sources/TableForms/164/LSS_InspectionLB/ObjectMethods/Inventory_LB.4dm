If (Form event code:C388=On Display Detail:K2:22)
	If (Find in array:C230(v_165_001_atxt; [LSS_Inspection:164]LSS_InventoryId_s:2)<0)
		LB_Detail1_txt:="No remote Inventory ID"
	Else 
		
		QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=[LSS_Inspection:164]LSS_InventoryId_s:2)
		If (Records in selection:C76([LSS_Inventory:165])=1)
			If ([LSS_Inventory:165]LSS_StructureNumber_s:6="")
				LB_Detail1_txt:="Blank Structure Number"
			Else 
				LB_Detail1_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
			End if 
		Else 
			LB_Detail1_txt:="No Inventory Match"
		End if 
	End if 
End if 