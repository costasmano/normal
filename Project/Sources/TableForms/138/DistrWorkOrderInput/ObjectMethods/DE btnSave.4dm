If (False:C215)
	//[DCM_Project];"DistrWorkOrderInput". btnSave
	// Modified by: costasmanousakis-(Designer)-(9/13/10 14:32:24)
	Mods_2010_09
	//  `Use new method DCM_P_Input_FM
	// Modified by: costasmanousakis-(Designer)-(11/29/10 16:55:00)
	Mods_2010_11
	//  `bugfix/enhancement - do the ACCEPT here instead off in the DCM_P_Input_FM
End if 

If (Form event code:C388=On Clicked:K2:4)
	DCM_P_Input_FM(On Clicked:K2:4; "SAVE")
	ACCEPT:C269
End if 