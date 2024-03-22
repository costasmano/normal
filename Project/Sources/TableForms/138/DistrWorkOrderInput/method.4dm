If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	//
	// ----------------------------------------------------
	// Method: Form Method: [DCM_Project];"DistrWorkOrderInput"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(9/13/10 06:50:45)
	Mods_2010_09
	//  `Additions / Modifications - use new DCM_P_Input_FM
	//  `Added 2nd page with bid items
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
DCM_P_Input_FM(Form event code:C388)