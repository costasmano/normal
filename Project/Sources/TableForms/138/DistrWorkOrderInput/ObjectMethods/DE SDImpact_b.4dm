Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([DCM_Project:138]SDInfluence:15)
			DCM_SDImpact_b:=1
		Else 
			DCM_SDImpact_b:=0
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
	: (Form event code:C388=On Clicked:K2:4)
		[DCM_Project:138]SDInfluence:15:=(DCM_SDImpact_b=1)
		
End case 
