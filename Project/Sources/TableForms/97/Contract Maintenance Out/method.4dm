If (False:C215)
	// ----------------------------------------------------
	// Method: Form Method: Contract Maintenance Out
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(10/7/08 16:34:16)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "ReadOnly"))
			OBJECT SET VISIBLE:C603(bzAddCMContract; False:C215)
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		WindowTitle
End case 