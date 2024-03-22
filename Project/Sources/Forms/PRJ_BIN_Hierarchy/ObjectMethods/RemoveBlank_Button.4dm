//Method: PRJ_BIN_Hierarchy.RemoveBlank_Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/05/19, 16:19:55
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12  //add code to modify how bin groups are created and maintained for a project
	//by Chuck Miller
End if 
C_LONGINT:C283($Col_L; $Row_L; $Selection_L; $loop_L; $CurrentGroup_L)
C_TEXT:C284($QueryBy_txt)
C_LONGINT:C283($pos_l; $start_L)

LISTBOX GET CELL POSITION:C971(*; "PRJ_BIN_Hierarchy"; $Col_L; $Row_L)

If (Bin_atxt{$Row_L}="")
	LISTBOX DELETE ROWS:C914(*; "PRJ_BIN_Hierarchy"; $Row_L)
	MULTI SORT ARRAY:C718(Group_atxt; >; Type_atxt; >; Bin_atxt; >)
	LISTBOX SELECT ROW:C912(*; "PRJ_BIN_Hierarchy"; 0; 2)
	
End if 

//End PRJ_BIN_Hierarchy.RemoveBlank_Button