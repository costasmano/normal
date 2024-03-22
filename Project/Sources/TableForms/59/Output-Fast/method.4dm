If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/19/06, 16:23:24
	// ----------------------------------------------------
	// Method: Form Method: Output-Fast
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
End if 

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(vArchData)
		vArchData:="Data : "+String:C10(BLOB size:C605([Activity Log:59]Data:10); "###,###,###,##0")+"b"
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
End case 