Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		C_TEXT:C284($msg)
		If ([ScourPOA_DetourBridge:133]DetourBIN:3#"")
			$Msg:="Remove  BIN "+<>sQU+[ScourPOA_DetourBridge:133]DetourBIN:3+<>sQU+" from the list of Detours ?"
		Else 
			$Msg:="Delete this Detour Entry ?"
		End if 
		
		CONFIRM:C162($Msg; "Delete")
		If (OK=1)
			If (Not:C34(Is new record:C668([ScourPOA_DetourBridge:133])))
				If (SCPOA_LogChanges_b)
					LogDeletion(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_DetourBridge:133]ScourPOAID:2; ->[ScourPOA_DetourBridge:133]DetourBridgeID_L:1; 2)
				End if 
				
				DELETE RECORD:C58([ScourPOA_DetourBridge:133])
			End if 
			CANCEL:C270
		End if 
		
End case 
