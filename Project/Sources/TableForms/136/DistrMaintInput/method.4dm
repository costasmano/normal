If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/01/10, 09:15:58
	// ----------------------------------------------------
	// Method: Form Method: [DCM_Contracts];"DistrMaintInput"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(6/14/10 12:40:25)
	Mods_2010_06
	//  `On a new record - Clear out related variables used in listboxes and related records;
	//  `Modifed the determination of DCM_ViewOnly_b variable ; only DistrictMaintenance users can edit
	// Modified by: costasmanousakis-(Designer)-(10/28/10 08:36:02)
	Mods_2010_10
	//  `Added a Short message to wait for the on load event
	// Modified by: costasmanousakis-(Designer)-(12/7/10 08:20:17)
	Mods_2010_12
	//use new method DCM_C_Input_FM
End if 
If (Form event code:C388=On Load:K2:1)
	utl_SetSpellandContextMenu
End if 
DCM_C_Input_FM