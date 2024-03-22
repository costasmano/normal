If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-27T00:00:00 17:12:04)
	Mods_2021_10_bug
	//  `arranged the HL lists - added list to pick a user from inactives instead of creating a new one.
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
ADDUSER_Utils("FORMMETHOD")