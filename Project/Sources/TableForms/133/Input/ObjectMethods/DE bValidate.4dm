If (Is new record:C668([ScourPOA_DetourBridge:133]))
	Inc_Sequence("ScourPOA_DetourBridge"; ->[ScourPOA_DetourBridge:133]DetourBridgeID_L:1)
	[ScourPOA_DetourBridge:133]ScourPOAID:2:=[ScourPOA:132]ScourPOAID:1
	If (SCPOA_LogChanges_b)
		LogNewRecord(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_DetourBridge:133]ScourPOAID:2; ->[ScourPOA_DetourBridge:133]DetourBridgeID_L:1; 2; "ScourPOA_DetourBridge")
	End if 
End if 
If (SCPOA_LogChanges_b)
	LogChanges(->[ScourPOA_DetourBridge:133]DetourBIN:3; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_DetourBridge:133]ScourPOAID:2; ->[ScourPOA_DetourBridge:133]DetourBridgeID_L:1; 2)
End if 
SAVE RECORD:C53([ScourPOA_DetourBridge:133])
CANCEL:C270