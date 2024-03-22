If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/8/08 09:53:37)
	Mods_2008_CM_5404  // ("ACCESS")
End if 
Case of 
	: ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Display Detail:K2:22))
		utl_SetSpellandContextMenu
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 
