//Method: SelectResources.ResourceList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/06/19, 16:08:02
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
If (Form event code:C388=On Clicked:K2:4)
	C_LONGINT:C283($Column_l; $Row_l; $Loop_l)
	
	LISTBOX GET CELL POSITION:C971(*; "ResourceList"; $Column_l; $Row_l)
	//v_1_150_txt:=LBGeneric_atxt{$Row_l}
	ARRAY TEXT:C222($parts_atxt; 0)
	ut_NewTextToArray(LBGeneric_atxt{$Row_l}; ->$parts_atxt; Folder separator:K24:12)
	v_1_150_txt:=""
	For ($Loop_l; 1; Size of array:C274($parts_atxt)-1)
		If ($parts_atxt{$Loop_l}="")
		Else 
			v_1_150_txt:=v_1_150_txt+$parts_atxt{$Loop_L}+Folder separator:K24:12
		End if 
	End for 
	
End if 

//End SelectResources.ResourceList