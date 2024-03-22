If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/01/10, 09:20:40
	// ----------------------------------------------------
	// Method: Object Method:[DCM_WorkOrders];"DistrMaintInput".btnSave
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(9/13/10 14:39:26)
	Mods_2010_09
	//  `Use the on validate event on method DCM_WO_Input_FM
	//  `the On Validate event has been disabled in the form properties, so it should not fire twice
End if 

If (Form event code:C388=On Clicked:K2:4)
	DCM_WO_Input_FM(On Clicked:K2:4; "SAVE")
End if 