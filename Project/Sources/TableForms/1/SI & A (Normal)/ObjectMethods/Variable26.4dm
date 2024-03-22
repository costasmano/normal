If (False:C215)
	//[Bridge MHD NBIS];"SI & A (Normal)"
	//Description for Item 107
	
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 16:04:05)
	Mods_2007_CM12_5301
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	SIA_Item107Desc
End if 