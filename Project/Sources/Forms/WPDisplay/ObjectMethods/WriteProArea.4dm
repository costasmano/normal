
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Contextual click:C713)
			// Display my contextual menu defined in the "On load" form
			C_TEXT:C284($res)
			$res:=Dynamic pop up menu:C1006(WPDisplaymenuContext)
		End if 
		
End case 