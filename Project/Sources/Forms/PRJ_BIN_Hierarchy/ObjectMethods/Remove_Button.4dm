//Method: PRJ_BIN_Hierarchy.Remove_Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/10/19, 14:14:30
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12  //add code to modify how bin groups are created and maintained for a project
	//by Chuck Miller 
End if 
//
C_LONGINT:C283($Col_L; $Row_L; $Selection_L; $loop_L; $CurrentGroup_L)
C_TEXT:C284($QueryBy_txt)

LISTBOX GET CELL POSITION:C971(*; "PRJ_BIN_Hierarchy"; $Col_L; $Row_L)

If ($Row_L>0) & ($Col_L=3)
	C_TEXT:C284($group_txt; $Type_txt)
	$group_txt:=Group_atxt{$Row_L}
	$Type_txt:=Type_atxt{$Row_L}
	
	
	LISTBOX DELETE ROWS:C914(*; "PRJ_BIN_Hierarchy"; $Row_L)
	
	C_BOOLEAN:C305($AddEmptyRow_B)
	$AddEmptyRow_B:=True:C214
	C_LONGINT:C283($loop_L; $Pos_l; $start_L)
	$start_L:=0
	Repeat 
		$Pos_l:=Find in array:C230(Group_atxt; $group_txt; $start_L)
		If ($Pos_l>0)
			$AddEmptyRow_B:=Not:C34(Type_atxt{$Pos_l}=$Type_txt)
			$start_L:=$Pos_l+1
			
		End if 
		
		
	Until ($Pos_l<1) | (Not:C34($AddEmptyRow_B))
	If ($AddEmptyRow_B)
		APPEND TO ARRAY:C911(Bin_atxt; "")
		APPEND TO ARRAY:C911(Group_atxt; $group_txt)
		APPEND TO ARRAY:C911(Type_atxt; $Type_txt)
		
		MULTI SORT ARRAY:C718(Group_atxt; >; Type_atxt; >; Bin_atxt; >)
		
	End if 
	
	OBJECT SET ENABLED:C1123(*; "Add_Button"; True:C214)
	
	LISTBOX SELECT ROW:C912(*; "PRJ_BIN_Hierarchy"; 0; 2)
	
End if 
//End PRJ_BIN_Hierarchy.Remove_Button