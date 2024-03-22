Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		If ([Element Cat:32]Code:1#"")
			OBJECT SET ENTERABLE:C238(*; "Field@"; True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*; "Field@"; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 
