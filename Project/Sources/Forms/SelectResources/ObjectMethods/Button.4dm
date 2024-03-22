//Method: SelectResources.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/27/18, 16:52:42
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
End if 
//
C_LONGINT:C283($Column_l; $Row_l)

LISTBOX GET CELL POSITION:C971(*; "ResourceList"; $Column_l; $Row_l)
If ($Row_l>0) & ($Row_l<=Size of array:C274(LBGeneric_atxt))
	
	v_1_004_ab{$Row_l}:=True:C214
	
	
	
End if 
//End SelectResources.Button