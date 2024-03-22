If (False:C215)
	//Script: bzPrint
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

//_O_PAGE SETUP([Conslt Address]; "Conslt Address Print")
FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 

If (Ok=1)  //check to see if canceled from Print Settings
	FORM SET OUTPUT:C54([Conslt Address:77]; "Conslt Address Print")
	PRINT SELECTION:C60([Conslt Address:77]; *)
	FORM SET OUTPUT:C54([Conslt Address:77]; "View Conslt Address")
End if 


