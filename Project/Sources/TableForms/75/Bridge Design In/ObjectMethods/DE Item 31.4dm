POPUPMENUC(->aItem31Des; ->aItem31Des; ->[Bridge Design:75]DesignLoad:36)

If (Form event code:C388=On Clicked:K2:4)
	
	PushChange(1; ->[Bridge Design:75]DesignLoad:36)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item31:135:=aItem31{aItem31Des}
		PushChange(2; ->[Bridge MHD NBIS:1]Item31:135)
	End if 
	
End if 