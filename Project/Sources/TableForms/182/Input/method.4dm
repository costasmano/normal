If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(8/25/17 17:51:21)
	Mods_2017_08
	//  `added code to log changes
	// Modified by: Costas Manousakis-(Designer)-(3/21/18 11:17:51)
	Mods_2018_03
	//  `added Protective system
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
FM_NTI_Input
