//Method: [PERS_Groups].Output_LB.PersonalGroup_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck
	//User (4D) : Designer
	//Date and time: 06/25/20, 14:14:38
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
End if 
//
Case of 
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
		
End case 
//End [PERS_Groups].Output_LB.PersonalGroup_LB