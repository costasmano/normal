If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/08/05, 19:46:57
	// ----------------------------------------------------
	// Method: Object Method: WKHR_Move_R
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

C_LONGINT:C283($SelectedItem_L)
$SelectedItem_L:=Selected list items:C379(AllCategories_HL)
If ($SelectedItem_L<1)
Else 
	WKHR_MoveToExcluded_HL
	
End if 
