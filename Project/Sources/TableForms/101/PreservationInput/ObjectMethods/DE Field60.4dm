//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.Actual_TotalLimitFee
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/13/12, 11:13:13
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		[Contract_Assignment_Maintenance:101]AgreedTotalCost_r:47:=[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.Actual_TotalLimitFee