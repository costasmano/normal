// Method: [LSS_Inventory].ListBoxOutput.LSS_Status

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): manousakisc
	// User name (4D): Designer
	// Date and time: 05/09/23, 14:43:29
	// ----------------------------------------------------
	// First Release
	Mods_2023_LSSNew
End if 
//
C_POINTER:C301($status_ptr)
$status_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
C_LONGINT:C283($status_L)
$status_L:=$status_ptr->

If ($status_L>0)
	If ($status_ptr->{$status_L}#$status_ptr->{0})  // apply filter only if we changed the selection
		$status_ptr->{0}:=$status_ptr->{$status_L}  // save selected option to 0 element
		
		LSS_ApplyFilters
		
	End if 
	
End if 


//End Object Method: [LSS_Inventory].ListBoxOutput.LSS_Categories_as