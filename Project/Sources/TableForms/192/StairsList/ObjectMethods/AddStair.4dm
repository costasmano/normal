//Method: [BridgeStairs].StairsList.AddStair
//Description
// add a stairs record
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-15T00:00:00, 10:04:24
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

CONFIRM:C162("Add a new Stair On/Adjacent to this BIN?"; "Add"; "Cancel")
If (OK=1)
	C_LONGINT:C283($newID_L)
	Inc_Sequence("BridgeStairs"; ->$newID_L)
	APPEND TO ARRAY:C911($codes_ptr->; "???")
	APPEND TO ARRAY:C911($descriptions_ptr->; "")
	APPEND TO ARRAY:C911($stairIds_ptr->; $newID_L)
End if 
//End [BridgeStairs].StairsList.AddStair