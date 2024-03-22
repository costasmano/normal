Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283(DCM_ContractNoTemp_L)
		POPUP_HL_MENUC(Self:C308->; ->DCM_ContractNoTemp_L)
		If (DCM_ContractNoTemp_L>0)
			[DCM_Contracts:136]ContractNo:1:=String:C10(DCM_ContractNoTemp_L)
			DCM_ContractNo_OM(On Data Change:K2:15)
		End if 
		
End case 
