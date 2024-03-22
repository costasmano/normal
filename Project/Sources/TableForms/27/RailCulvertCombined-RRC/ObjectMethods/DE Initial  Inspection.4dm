Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([Inspections:27]InitialInsp:9)
			Self:C308->:=1
		Else 
			Self:C308->:=0
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->=1)
			[Inspections:27]InitialInsp:9:=True:C214
			BridgeDesignToSIA
		Else 
			[Inspections:27]InitialInsp:9:=False:C215
		End if 
		vInspTitle:=G_Insp_SetTitle
		PushChange(1; ->[Inspections:27]InitialInsp:9)
End case 