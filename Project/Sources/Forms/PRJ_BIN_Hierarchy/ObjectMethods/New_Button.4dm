//Method: PRJ_BIN_Hierarchy.New_Button
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
//
v_122_006_L:=v_122_006_L+1
C_LONGINT:C283($Loop_L; $Pos_L)

$Loop_L:=1
Repeat 
	$Pos_L:=Find in array:C230(Group_atxt; "Group "+String:C10($Loop_L))
	If ($Pos_L>0)
		$Loop_L:=$Loop_L+1
	End if 
Until ($Pos_L<1)
APPEND TO ARRAY:C911(Group_atxt; "Group "+String:C10($Loop_L))
APPEND TO ARRAY:C911(Type_atxt; "Proposed")
APPEND TO ARRAY:C911(Bin_atxt; "")
APPEND TO ARRAY:C911(Group_atxt; "Group "+String:C10($Loop_L))
APPEND TO ARRAY:C911(Type_atxt; "Existing")
APPEND TO ARRAY:C911(Bin_atxt; "")
MULTI SORT ARRAY:C718(Group_atxt; >; Type_atxt; >; Bin_atxt; >)
LISTBOX SELECT ROW:C912(*; "PRJ_BIN_Hierarchy"; 0; 2)
//End PRJ_BIN_Hierarchy.New_Button