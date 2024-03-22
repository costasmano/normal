//Method: PRJ_BIN_Hierarchy.Move_Button
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

If ($Col_L=3) & (Bin_atxt{$Row_L}#"")
	$CurrentGroup_L:=Num:C11(Replace string:C233(Group_atxt{$Row_L}; "Group "; ""))
	ARRAY LONGINT:C221($groups_al; 0)
	$QueryBy_txt:="Skip "+Char:C90(1)
	APPEND TO ARRAY:C911($groups_al; 0)
	
	For ($loop_L; 1; v_122_006_L)
		$Pos_L:=Find in array:C230(Group_atxt; "Group "+String:C10($Loop_L))
		Case of 
			: ($loop_L=$CurrentGroup_L)
			: ($Pos_L<1)
			Else 
				$QueryBy_txt:=$QueryBy_txt+"Move to Group "+String:C10($loop_L)+Char:C90(1)
				APPEND TO ARRAY:C911($groups_al; $loop_L)
		End case 
	End for 
	C_TEXT:C284($GroupToFind_txt)
	$Selection_L:=Pop up menu:C542($QueryBy_txt)
	If ($groups_al{$Selection_L}#0)
		Group_atxt{$Row_L}:="Group "+String:C10($groups_al{$Selection_L})
		$GroupToFind_txt:=Group_atxt{$Row_L}
	End if 
	
	
	$start_L:=0
	C_BOOLEAN:C305($Complete_B)
	Repeat 
		$pos_l:=Find in array:C230(Group_atxt; $GroupToFind_txt; $start_L)
		$Complete_B:=($pos_l<1)
		If (Not:C34($Complete_B))
			
			If (Bin_atxt{$pos_l}="") & (Type_atxt{$pos_l}=Type_atxt{$Row_L})
				LISTBOX DELETE ROWS:C914(*; "PRJ_BIN_Hierarchy"; $pos_l)
				$start_L:=$pos_l
			Else 
				$start_L:=$pos_l+1
			End if 
			
		End if 
		
	Until ($Complete_B)
	
	MULTI SORT ARRAY:C718(Group_atxt; >; Type_atxt; >; Bin_atxt; >)
	LISTBOX SELECT ROW:C912(*; "PRJ_BIN_Hierarchy"; 0; 2)
	
End if 

//End Hierarchy_test.Button