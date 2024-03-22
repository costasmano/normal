POPUPMENUC(->aDesign_Scour; ->aDesign_Scour; ->[Bridge Design:75]Scour:17)

If (Form event code:C388=On Clicked:K2:4)
	
	PushChange(1; ->[Bridge Design:75]Scour:17)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item113:151:=aTrans_Scour{aDesign_Scour}
		PushChange(2; ->[Bridge MHD NBIS:1]Item113:151)
	End if 
	
End if 