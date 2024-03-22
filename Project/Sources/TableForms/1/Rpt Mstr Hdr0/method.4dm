If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/3/10 16:45:43)
	Mods_2010_02
	//change font size for windows
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		//
		If (<>WindowsPL_b)
			OBJECT SET FONT SIZE:C165(*; "Text@"; 6)
		End if 
End case 
