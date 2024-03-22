Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(SC_ScourReportRW_b)
		If (Not:C34(SC_ScourReportRW_b))
			OBJECT SET ENABLED:C1123(bzAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bzDelete; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 
