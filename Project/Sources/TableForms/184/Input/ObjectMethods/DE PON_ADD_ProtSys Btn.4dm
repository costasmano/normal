Case of 
	: (Form event code:C388=On Load:K2:1)
		//_ o _DISABLE BUTTON(Self->)
		OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		//PON_AddChildElem (False)
		NTI_AddChildElem(->[NTI_ELEM_TIN_INSP:185]; True:C214)
		
End case 
