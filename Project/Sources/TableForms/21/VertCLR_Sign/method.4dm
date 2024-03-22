If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/23/07, 14:07:44
	// ----------------------------------------------------
	// Method: Form Method: VertCLR_Sign
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(9/2/15 13:49:12)
	Mods_2015_09
	//  `allow only one char in the at bridge , at advance boxes
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(VERTCL_Use54_rb; "Use Item 54 ("+String:C10(VERTCL_Itm54_r)+"m)")
		OBJECT SET TITLE:C194(VERTCL_Use53_rb; "Use Item 53 ("+String:C10(VERTCL_Itm53_r)+"m)")
		If (VERTCL_Use54_b)
			VERTCL_Use54_rb:=1
			VERTCL_Use53_rb:=0
		Else 
			VERTCL_Use54_rb:=0
			VERTCL_Use53_rb:=1
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 