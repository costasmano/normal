If (False:C215)
	
	//Form Method: [DCM_Contracts];"CompRateTable" 
	// Modified by: costasmanousakis-(Designer)-(12/10/10 21:04:16)
	Mods_2010_12
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		InDoubleClick_B:=False:C215
		utl_SetSpellandContextMenu
		DCM_COMPADDDATE_2:=0
		DCM_CompRates("LOADLISTBOX")
		If (DCM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
	: (Form event code:C388=On Data Change:K2:15)
		DCM_COMPTBLCHANGES_b:=True:C214
	: (Form event code:C388=On Validate:K2:3)
		
End case 