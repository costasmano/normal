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

C_POINTER:C301($prjnum_ptr)
C_LONGINT:C283($projnum_L)
$prjnum_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
$projnum_L:=$prjnum_ptr->

If ($projnum_L>0)
	If ($prjnum_ptr->{$projnum_L}#$prjnum_ptr->{0})  // apply filter only if we changed the selection
		$prjnum_ptr->{0}:=$prjnum_ptr->{$projnum_L}  // save selected option to 0 element
		
		LSS_ApplyFilters
	End if 
	
End if 


//End Object Method: [LSS_Inventory].ListBoxOutput.LSS_Categories_as