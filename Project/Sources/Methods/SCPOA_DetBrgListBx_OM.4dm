//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/25/09, 00:22:51
	// ----------------------------------------------------
	// Method: SCPOADetBrgListBx_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
	
End if 
C_LONGINT:C283($FormEvent)

$FormEvent:=Form event code:C388
C_LONGINT:C283($FirstId; $LastID; $newRow_L)
Case of 
	: ($FormEvent=On Load:K2:1)
		LISTBOX SELECT ROW:C912($myListBox_ptr->; 0)
		InDoubleClick_B:=False:C215
	: ($FormEvent=On Data Change:K2:15)
	: ($FormEvent=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($currItem_L)
			$currItem_L:=SCPOADetBrgListBx
			C_POINTER:C301($myListBox_ptr)
			$myListBox_ptr:=->SCPOADetBrgListBx
			If ($currItem_L>0)
				GOTO SELECTED RECORD:C245([ScourPOA_DetourBridge:133]; $currItem_L)
				If (ut_LoadRecordInteractive(->[ScourPOA_DetourBridge:133]))
					FORM SET INPUT:C55([ScourPOA_DetourBridge:133]; "Input")
					$FirstId:=[ScourPOA_DetourBridge:133]DetourBridgeID_L:1
					MODIFY RECORD:C57([ScourPOA_DetourBridge:133])
					InDoubleClick_B:=False:C215
					$LastID:=[ScourPOA_DetourBridge:133]DetourBridgeID_L:1
					QUERY:C277([ScourPOA_DetourBridge:133]; [ScourPOA_DetourBridge:133]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
					SCPOA_Variables("DETOURBRIDGES")
					$newRow_L:=Find in array:C230(SCPOA_DetBInIDs_aL; $LastID)
					If ($newRow_L<=0)
						$newRow_L:=1
					End if 
					LISTBOX SELECT ROW:C912($myListBox_ptr->; $newRow_L)
					OBJECT SET SCROLL POSITION:C906($myListBox_ptr->)
				Else 
					
				End if 
				
			Else 
				If (SCPOA_EditRecord_b)
					//Add if editable
					FORM SET INPUT:C55([ScourPOA_DetourBridge:133]; "Input")
					ADD RECORD:C56([ScourPOA_DetourBridge:133])
					$LastID:=[ScourPOA_DetourBridge:133]DetourBridgeID_L:1
					QUERY:C277([ScourPOA_DetourBridge:133]; [ScourPOA_DetourBridge:133]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
					SCPOA_Variables("DETOURBRIDGES")
					$newRow_L:=Find in array:C230(SCPOA_DetBInIDs_aL; $LastID)
					If ($newRow_L<=0)
						$newRow_L:=1
						
					End if 
					LISTBOX SELECT ROW:C912($myListBox_ptr->; $newRow_L)
					OBJECT SET SCROLL POSITION:C906($myListBox_ptr->)
					
				Else 
					//Do nothnig
				End if 
				
			End if 
			InDoubleClick_B:=False:C215
			
		End if 
		
	: ($FormEvent=On Clicked:K2:4)
		
End case 
