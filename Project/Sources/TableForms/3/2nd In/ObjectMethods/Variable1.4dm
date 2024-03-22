Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		PRINT SETTINGS:C106
		C_LONGINT:C283($points_L)
		$points_L:=Print form:C5([NBIS Secondary:3]; "print")
		PAGE BREAK:C6
		
End case 