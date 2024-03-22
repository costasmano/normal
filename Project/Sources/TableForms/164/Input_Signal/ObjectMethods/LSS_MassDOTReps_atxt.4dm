
Case of 
	: (Form event code:C388=On Load:K2:1)
		POPUPMENUC(->LSS_MassDOTReps_atxt; ->LSS_MassDOTRepIDs_aL; ->[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		POPUPMENUC(->LSS_MassDOTReps_atxt; ->LSS_MassDOTRepIDs_aL; ->[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5)
		C_LONGINT:C283($indx_L)
		$indx_L:=LSS_MassDOTReps_atxt
		If ($indx_L>0)
			LSS_MassDOTRep_s:=LSS_MassDOTReps_atxt{$indx_L}
		End if 
End case 