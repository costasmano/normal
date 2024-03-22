G_PrintOptions
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 
If (OK=1)
	Print form:C5([Bridge MHD NBIS:1]; "TunnelSIA")
	PAGE BREAK:C6
End if 