//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/11, 09:43:55
	// ----------------------------------------------------
	// Method: SCPOA_InstrType_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
If (SCPOA_OthMonInstrPort_L+SCPOA_OthMonInstrGeo_L+SCPOA_OthMonInstrSon_L+SCPOA_OthMonInstrOth_L>0)
	SCPOA_OtherMonitinstr_L:=1
Else 
	SCPOA_OtherMonitinstr_L:=0
End if 