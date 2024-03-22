If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/30/08 09:30:37)
	Mods_2008_CM_5404  //filter the on double click event
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		FILTER EVENT:C321
		USE SET:C118("UserSet")
		CANCEL:C270
		
End case 