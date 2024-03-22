Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET ENABLED:C1123(Self:C308->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		PON_AddChildElem(False:C215)
		
End case 
