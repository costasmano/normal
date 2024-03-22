//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/12, 14:25:48
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
FORM SET INPUT:C55([Contract_Project_Maintenance:100]; "PreservationInput")
ADD RECORD:C56([Contract_Project_Maintenance:100])
If (OK=1)
	PRV_Variables("RELATEBRIDGEINFO")
	PRV_CTRLSelections("BRIDGES")
End if 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.Button