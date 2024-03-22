If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 5/28/10
	// ----------------------------------------------------
	// Method: Form Method:[DCM_WorkOrders];"DCM_4DWriteDlg"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
End if 

If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 

DCM_4DWriteDlg_FM