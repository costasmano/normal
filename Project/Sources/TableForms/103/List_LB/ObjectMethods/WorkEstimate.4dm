//Method: [Work_Estimate].List_LB.WorkEstimate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 07/07/20, 16:16:22
	// ----------------------------------------------------
	//Created : 
	Mods_2020_07
End if 
//
Case of 
	: (Form event code:C388=On Open Detail:K2:23)
		
		ut_SetWindowSize("Create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("RESET"; Current method name:C684)
		
End case 
//End [Work_Estimate].List_LB.WorkEstimate