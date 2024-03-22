If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Display Detail:K2:22))
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		If (InspRtgContrAccess_b)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 
