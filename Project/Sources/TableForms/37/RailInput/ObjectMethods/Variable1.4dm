If (False:C215)
	Mods_2010_12
	//`RR
End if 

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		G_PrintOptions
		If (<>ShowPrint)
			PRINT SETTINGS:C106
		End if 
		Print form:C5([Bridge MHD NBIS:1]; "RailTransitSIA")
		PAGE BREAK:C6
		
End case 