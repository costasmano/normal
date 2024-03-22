If (False:C215)
	//[LSS_Photos].Input 
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 16:13:41)
	Mods_2016_11
	//  `added shortcuts to navigation buttons; added events mouse enter/mouse leave ; changed to generic help message; changed object method code.
	
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_PhotoInput
