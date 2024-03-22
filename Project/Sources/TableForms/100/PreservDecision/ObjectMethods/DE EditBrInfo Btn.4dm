//Method: Object Method: [Contract_Project_Maintenance].PreservDecision.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/23/12, 22:15:07
	// ----------------------------------------------------
	//Created : 
	Mods_2012_08
End if 
//
//SET ENTERABLE([Contract_Project_Maintenance]ADT_L;True)
//SET ENTERABLE([Contract_Project_Maintenance]Detour_L;True)
//SET ENTERABLE([Contract_Project_Maintenance]Classification_s;True)
OBJECT SET ENTERABLE:C238(PRV_DEC_ADT_L; True:C214)
OBJECT SET ENTERABLE:C238(PRV_DEC_Detour_L; True:C214)
OBJECT SET ENTERABLE:C238(PRV_DEC_Classification_s; True:C214)
//End Object Method: [Contract_Project_Maintenance].PreservDecision.Button1