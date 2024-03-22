If (False:C215)
	//[DCM_Project];"DistrWorkOrderInput"". btnDelete
	// Modified by: costasmanousakis-(Designer)-(9/13/10 14:58:28)
	Mods_2010_09
	//  `Use new method DCM_P_Input_FM
End if 

If (Form event code:C388=On Clicked:K2:4)
	DCM_P_Input_FM(On Clicked:K2:4; "DELETE")
End if 