//Method: [LSS_Inspection].Input_ITS.Subform
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Bridge Section
	//User (4D) : Designer
	//Date and time: 10/24/18, 15:54:41
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		//CALL SUBFORM CONTAINER(On Load)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End [LSS_Inspection].Input_ITS.Subform