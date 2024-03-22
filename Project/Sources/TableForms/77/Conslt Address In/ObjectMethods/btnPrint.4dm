//_O_PAGE SETUP([Conslt Address]; "Conslt Address Print")
FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 

If (Ok=1)  //check to see if canceled from Print Settings
	FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
	PRINT RECORD:C71([Conslt Address:77]; *)
	FORM SET OUTPUT:C54([Conslt Address:77]; "View Conslt Address")
End if 

