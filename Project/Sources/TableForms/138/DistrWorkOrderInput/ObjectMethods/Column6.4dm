If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/13/10 09:53:40)
	Mods_2010_12
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		[DCM_Project:138]CurrCost:12:=[DCM_Project:138]CurrCost:12  //show record modified change
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 