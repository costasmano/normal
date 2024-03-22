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
	Mods_2020_07  //continue replace of old output forms with list boxes
	//Modified by: CJ (7/6/20 15:20:34)
	
End if 
//
Case of 
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("Create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("RESET"; Current method name:C684)
		
End case 
//End [Conslt Rating].View Cslt Rating_LB.List Box