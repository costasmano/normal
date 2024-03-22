If (False:C215)
	// Method: [Dialogs];"User_Group_List"
	
	
	// Modified by: costasmanousakis-(Designer)-(7/21/10 11:09:13)
	Mods_2010_07
	//  `Added "Load File" and "Export" and  "SaveOnServer" buttons 
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (USGRP_UserListActive_b)
			OBJECT SET TITLE:C194(*; "ChangeUNAmeBtn"; "Change User Name")
			OBJECT SET TITLE:C194(*; "AddUserBtn"; "Add User")
			OBJECT SET TITLE:C194(*; "OtherScreen"; "GROUPS")
			OBJECT SET ENABLED:C1123(*; "ChangePWDBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET TITLE:C194(*; "ChangeUNAmeBtn"; "Change Group Name")
			OBJECT SET TITLE:C194(*; "AddUserBtn"; "Add Group")
			OBJECT SET ENABLED:C1123(*; "ChangePWDBtn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET TITLE:C194(*; "OtherScreen"; "USERS")
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 