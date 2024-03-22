If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/08/05, 19:47:11
	// ----------------------------------------------------
	// Method: Object Method: WKHR_Move_l
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
C_LONGINT:C283($SelectedItem_L)
$SelectedItem_L:=Selected list items:C379(CurrCategories_HL)
If ($SelectedItem_L<1)
Else 
	WKHR_MoveToAvailable_HL
	
End if 
