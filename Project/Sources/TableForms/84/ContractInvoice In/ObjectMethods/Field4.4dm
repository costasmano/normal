If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/06/07, 09:14:57
	// ----------------------------------------------------
	// Method: Object Method: DateProcessFoward
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		CM_InvoicePrcDateChg_b:=True:C214
		
End case 