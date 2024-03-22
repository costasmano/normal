//%attributes = {"invisible":true}
//Method: USR_AddGroupMemberships
//Description
// add to a groupmembership array groups that a group belongs to 
// Parameters
// $1 : $grpsArray_ptr
// $2 : $groupNum_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Oct 21, 2022, 18:07:37
	Mods_2022_10
	// ----------------------------------------------------
	
	C_POINTER:C301(USR_AddGroupMemberships; $1)
	C_LONGINT:C283(USR_AddGroupMemberships; $2)
End if 

C_POINTER:C301($1)
C_LONGINT:C283($2)

ARRAY LONGINT:C221($groups_; 0)
ARRAY TEXT:C222($grounames; 0)
GET GROUP LIST:C610($grounames; $groups_)
C_LONGINT:C283($loop_L; $owner)
C_TEXT:C284($grname)
For ($loop_L; 1; Size of array:C274($groups_))
	ARRAY LONGINT:C221($members; 0)
	GET GROUP PROPERTIES:C613($groups_{$loop_L}; $grname; $owner; $members)
	If (Find in array:C230($members; $2)>0)
		//check if already have it
		If (Find in array:C230($1->; $groups_{$loop_L})>0)
		Else 
			APPEND TO ARRAY:C911($1->; $groups_{$loop_L})
			USR_AddGroupMemberships($1; $groups_{$loop_L})
		End if 
	End if 
End for 

//End USR_AddGroupMemberships   