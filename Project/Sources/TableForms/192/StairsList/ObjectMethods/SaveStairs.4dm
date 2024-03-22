//Method: [BridgeStairs].StairsList.SaveStairs
//Description
// object mehtod to save changes in stairs
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-15T00:00:00, 16:33:58
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
End if 
//

CONFIRM:C162("Save any changes made?"; "Save"; "Close without saving")
If (OK=1)
	C_POINTER:C301($codes_ptr; $descriptions_ptr; $stairIds_ptr; $colVar_ptr; $enterableflag_ptr)
	C_OBJECT:C1216($LbArrays_o)
	$LbArrays_o:=SIA_Stairs_GetLBArrays
	$codes_ptr:=OB Get:C1224($LbArrays_o; "owners"; Is pointer:K8:14)
	$descriptions_ptr:=OB Get:C1224($LbArrays_o; "descriptions"; Is pointer:K8:14)
	$stairIds_ptr:=OB Get:C1224($LbArrays_o; "ids"; Is pointer:K8:14)
	
	//get list of current stair records
	QUERY:C277([BridgeStairs:192]; [BridgeStairs:192]BIN:2=[Bridge MHD NBIS:1]BIN:3)
	//find if there are any deleted
	C_LONGINT:C283($stairs_L; $stair_L)
	$stairs_L:=Records in selection:C76([BridgeStairs:192])
	If ($stairs_L>0)
		For ($stair_L; $stairs_L; 1; -1)
			GOTO SELECTED RECORD:C245([BridgeStairs:192]; $stair_L)
			If (Find in array:C230($stairIds_ptr->; [BridgeStairs:192]BridgeStairsID:1)<1)
				//has been removed
				LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[BridgeStairs:192]BIN:2; ->[BridgeStairs:192]BridgeStairsID:1; 1)
				DELETE RECORD:C58([BridgeStairs:192])
			End if 
		End for 
	End if 
	
	//update the stair selection
	QUERY:C277([BridgeStairs:192]; [BridgeStairs:192]BIN:2=[Bridge MHD NBIS:1]BIN:3)
	ARRAY LONGINT:C221($stairIDS_aL; 0)
	SELECTION TO ARRAY:C260([BridgeStairs:192]BridgeStairsID:1; $stairIDS_aL)
	//do we need to add or update records
	$stairs_L:=Size of array:C274($stairIds_ptr->)
	C_LONGINT:C283($foundStair_L)
	If ($stairs_L>0)
		For ($stair_L; 1; $stairs_L)
			$foundStair_L:=Find in array:C230($stairIDS_aL; $stairIds_ptr->{$stair_L})
			If ($foundStair_L<1)
				//new record
				CREATE RECORD:C68([BridgeStairs:192])
				[BridgeStairs:192]BIN:2:=[Bridge MHD NBIS:1]BIN:3
				[BridgeStairs:192]BridgeStairsID:1:=$stairIds_ptr->{$stair_L}
				[BridgeStairs:192]OwnerCode_s:4:=$codes_ptr->{$stair_L}
				[BridgeStairs:192]Description_txt:6:=$descriptions_ptr->{$stair_L}
				[BridgeStairs:192]BridgeStairs_UUIDKey_s:11:=Generate UUID:C1066
				[BridgeStairs:192]CreatedBy:7:=<>CURRENTUSER_NAME
				[BridgeStairs:192]CreatedStamp:8:=String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))
				LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[BridgeStairs:192]BIN:2; ->[BridgeStairs:192]BridgeStairsID:1; 1; "BridgeStairs")
				InitChangeStack(3)
				PushChange(3; ->[BridgeStairs:192]OwnerCode_s:4)
				PushChange(3; ->[BridgeStairs:192]Description_txt:6)
				FlushGrpChgs(3; ->[Bridge MHD NBIS:1]BIN:3; ->[BridgeStairs:192]BIN:2; ->[BridgeStairs:192]BridgeStairsID:1; 1)
				SAVE RECORD:C53([BridgeStairs:192])
				
			Else 
				//existing - do we need to update?
				GOTO SELECTED RECORD:C245([BridgeStairs:192]; $foundStair_L)
				C_BOOLEAN:C305($changed_b)
				$changed_b:=False:C215
				InitChangeStack(3)
				If ([BridgeStairs:192]OwnerCode_s:4#$codes_ptr->{$stair_L})
					[BridgeStairs:192]OwnerCode_s:4:=$codes_ptr->{$stair_L}
					PushChange(3; ->[BridgeStairs:192]OwnerCode_s:4)
					$changed_b:=True:C214
				End if 
				
				If ([BridgeStairs:192]Description_txt:6#$descriptions_ptr->{$stair_L})
					[BridgeStairs:192]Description_txt:6:=$descriptions_ptr->{$stair_L}
					PushChange(3; ->[BridgeStairs:192]Description_txt:6)
					$changed_b:=True:C214
				End if 
				If ($changed_b)
					[BridgeStairs:192]ModifiedBy:9:=<>CURRENTUSER_NAME
					[BridgeStairs:192]ModifiedStamp:10:=String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))
					PushChange(3; ->[BridgeStairs:192]ModifiedBy:9)
					PushChange(3; ->[BridgeStairs:192]ModifiedStamp:10)
				End if 
				
				FlushGrpChgs(3; ->[Bridge MHD NBIS:1]BIN:3; ->[BridgeStairs:192]BIN:2; ->[BridgeStairs:192]BridgeStairsID:1; 1)
				SAVE RECORD:C53([BridgeStairs:192])
				
			End if 
		End for 
		
	End if 
	
End if   //IF OK to Save

CANCEL:C270

//End [BridgeStairs].StairsList.SaveStairs