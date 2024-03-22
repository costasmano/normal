//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.OrigSub_DirectCost_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/13/12, 11:18:10
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		PRV_OrigCostTotal_r:=[Contract_Assignment_Maintenance:101]OrigSub_TotalLimFee_r:69+[Contract_Assignment_Maintenance:101]OrigSub_DirectCost_r:70
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.OrigSub_DirectCost_r