//Method: [BridgeStairs].StairsList.DelStair
//Description
// object method to delete a stair from the list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-15T00:00:00, 17:15:58
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
End if 
//

C_OBJECT:C1216($LbArrays_o)
$LbArrays_o:=SIA_Stairs_GetLBArrays
C_POINTER:C301($codes_ptr; $descriptions_ptr; $stairIds_ptr)
$codes_ptr:=OB Get:C1224($LbArrays_o; "owners"; Is pointer:K8:14)
$descriptions_ptr:=OB Get:C1224($LbArrays_o; "descriptions"; Is pointer:K8:14)
$stairIds_ptr:=OB Get:C1224($LbArrays_o; "ids"; Is pointer:K8:14)

C_LONGINT:C283($Col_L; $Row_L)
LISTBOX GET CELL POSITION:C971(*; "Stairs_LB"; $Col_L; $Row_L)
If ($Row_L>0)
	CONFIRM:C162("Delete Stairs record belonging to "+$codes_ptr->{$Row_L}+" : "+$descriptions_ptr->{$Row_L}; "Delete"; "Cancel")
	If (Ok=1)
		DELETE FROM ARRAY:C228($codes_ptr->; $Row_L)
		DELETE FROM ARRAY:C228($descriptions_ptr->; $Row_L)
		DELETE FROM ARRAY:C228($stairIds_ptr->; $Row_L)
	End if 
	
End if 

//End [BridgeStairs].StairsList.DelStair