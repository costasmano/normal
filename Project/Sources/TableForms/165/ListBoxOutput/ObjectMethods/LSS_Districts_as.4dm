//Method: Object Method: [LSS_Inventory].ListBoxOutput.LSS_Categories_as
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/16/14, 13:49:21
	// ----------------------------------------------------
	//Created : 
	
	// Modified by: manousakisc (5/9/2023)
	Mods_2023_LSSNew
	// re-arranged logic ; added status filter
End if 
//
C_LONGINT:C283($click_L)
$click_L:=LSS_Districts_as
If ($click_L>0)
	If (LSS_Districts_as{$click_L}#LSS_Districts_as{0})
		LSS_Districts_as{0}:=LSS_Districts_as{$click_L}
		
		LSS_ApplyFilters
		
	End if 
	
End if 

//End Object Method: [LSS_Inventory].ListBoxOutput.LSS_Categories_as