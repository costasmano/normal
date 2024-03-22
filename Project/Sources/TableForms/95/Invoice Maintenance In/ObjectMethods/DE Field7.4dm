If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/21/07, 10:51:31
	// ----------------------------------------------------
	// Method: Object Method: DateProcessFoward
	// Description
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM10
	// Date and time: 08/31/07, 09:42:42
	Mods_2007_CM12_5301
End if 

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		CM_InvoicePrcDateChg_b:=True:C214
		
End case 