[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
SCPOA_FldMonPgmChecks
If (SCPOA_OtherMonitinstr_L=1)
	//Enable the others
	OBJECT SET ENABLED:C1123(SCPOA_OthMonInstrPort_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(SCPOA_OthMonInstrGeo_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(SCPOA_OthMonInstrGeo_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(SCPOA_OthMonInstrOth_L; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	
Else 
	
End if 
