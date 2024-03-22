If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 5/28/10
	// ----------------------------------------------------
	// Method: Form Method: [DCM_WorkOrders];"DistrMaintInput"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(9/13/10 04:24:22)
	Mods_2010_09
	//  `Form and form method additions / Adjustments / fixes
	//  `Added 2nd page for Bid Item summary, Replaced Bridge include form with ListBox
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
DCM_WO_Input_FM(Form event code:C388)