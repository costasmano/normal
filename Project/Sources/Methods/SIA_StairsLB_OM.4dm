//%attributes = {"invisible":true}
//Method: SIA_StairsLB_OM
//Description
//object method for the Stairs LB object
// Parameters
// $0 : $Return
// $1 : $FormEvent
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-14T00:00:00, 18:18:35
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_LONGINT:C283(SIA_StairsLB_OM; $0)
	C_LONGINT:C283(SIA_StairsLB_OM; $1)
	
End if 
//
C_LONGINT:C283($0)
$0:=0  //default return value
C_LONGINT:C283($formevent_L)


If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$formevent_L:=$1
Else 
	$formevent_L:=Form event code:C388
End if 

C_POINTER:C301($codes_ptr; $descriptions_ptr; $stairIds_ptr; $colVar_ptr; $enterableflag_ptr)
C_OBJECT:C1216($LbArrays_o)
$LbArrays_o:=SIA_Stairs_GetLBArrays
$codes_ptr:=OB Get:C1224($LbArrays_o; "owners"; Is pointer:K8:14)
$descriptions_ptr:=OB Get:C1224($LbArrays_o; "descriptions"; Is pointer:K8:14)
$stairIds_ptr:=OB Get:C1224($LbArrays_o; "ids"; Is pointer:K8:14)
$enterableflag_ptr:=OB Get:C1224($LbArrays_o; "enterable"; Is pointer:K8:14)

C_LONGINT:C283($Row_L; $Col_L)
C_LONGINT:C283($mouseX_L; $mouseY_L; $mouseBtn_L)

Case of 
	: ($formevent_L=On Load:K2:1)
		//load data into arrays
		SELECTION TO ARRAY:C260([BridgeStairs:192]OwnerCode_s:4; $codes_ptr->; [BridgeStairs:192]Description_txt:6; $descriptions_ptr->; [BridgeStairs:192]BridgeStairsID:1; $stairIds_ptr->)
		
	: ($formevent_L=On Data Change:K2:15)
		LISTBOX GET CELL POSITION:C971(*; "Stairs_LB"; $Col_L; $Row_L; $colVar_ptr)
		If ($Row_L>0)
			If ($colVar_ptr=$descriptions_ptr)
				$descriptions_ptr->{$Row_L}:=f_TrimStr($descriptions_ptr->{$Row_L}; True:C214; True:C214)
			End if 
		End if 
		
	: ($formevent_L=On Double Clicked:K2:5)
		LISTBOX GET CELL POSITION:C971(*; "Stairs_LB"; $Col_L; $Row_L; $colVar_ptr)
		If ($Row_L>0)
			If ($colVar_ptr=$descriptions_ptr)
				EDIT ITEM:C870($descriptions_ptr->; $Row_L)
			End if 
		End if 
		
	: ($formevent_L=On Clicked:K2:4)
		If (Right click:C712 | Contextual click:C713 | Macintosh control down:C544)
			LISTBOX GET CELL POSITION:C971(*; "Stairs_LB"; $Col_L; $Row_L; $colVar_ptr)
			GET MOUSE:C468($mouseX_L; $mouseY_L; $mouseBtn_L)
			If ($Row_L>0)
				
				If ($colVar_ptr=$codes_ptr) & ($enterableflag_ptr->=1)
					//for the OwnerColumn and enterable reate a popup menu for owner
					C_TEXT:C284($menuRef_txt; $selected_txt)
					$menuRef_txt:=MENU_BuildMenuFromArrays(->AIT8OWNERDES_; ->AIT8OWNERCODE_; ";")
					$selected_txt:=Dynamic pop up menu:C1006($menuRef_txt; ""; $mouseX_L; $mouseY_L)
					If ($selected_txt#"")
						$colVar_ptr->{$Row_L}:=$selected_txt
						
					End if 
					
					RELEASE MENU:C978($menuRef_txt)
				End if 
			End if 
		End if 
	: ($formevent_L=On Selection Change:K2:29)
		
End case 

//End SIA_StairsLB_OM