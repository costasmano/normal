//Method: Object Method: [LSS_Inventory].ListBoxOutput.LSS_StructType_atxt 
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/16/14, 13:49:21
	// ----------------------------------------------------
	
	// Modified by: manousakisc (5/10/2023)
	Mods_2023_LSSNew
	
End if 
//
C_LONGINT:C283($structType_L)
$structType_L:=LSS_StructType_atxt

If ($structType_L>0)
	
	If (LSS_StructType_atxt{0}#LSS_StructType_atxt{$structType_L})
		LSS_StructType_atxt{0}:=LSS_StructType_atxt{$structType_L}
		
		LSS_ApplyFilters
		
	End if 
	
End if 
//End Object Method: [LSS_Inventory].ListBoxOutput.LSS_StructType_atxt 