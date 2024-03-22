//Method: [Conslt Rating].View Cslt Rating_LB.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/09/20, 13:43:36
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	//Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
End if 
//
Case of 
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
End case 
//End [Conslt Rating].View Cslt Rating_LB.List Box