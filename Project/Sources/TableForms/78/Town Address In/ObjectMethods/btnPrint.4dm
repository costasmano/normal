//_O_PAGE SETUP([Town Address]; "Town Address Print")
FORM SET OUTPUT:C54([Town Address:78]; "Town Address Print")
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 

If (Ok=1)  //check to see if canceled from Print Settings
	FORM SET OUTPUT:C54([Town Address:78]; "Town Address Print")
	PRINT RECORD:C71([Town Address:78]; *)
	FORM SET OUTPUT:C54([Town Address:78]; "View Town Address")
End if 
