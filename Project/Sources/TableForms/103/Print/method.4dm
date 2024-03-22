If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/30/05, 14:35:58
	// ----------------------------------------------------
	// Method: Form Method: Print
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		WKHR_ApprStatus_p:=[Work_Estimate:103]WkHrEstApproved:18+1
		WKHR_RevStatus_p:=[Work_Estimate:103]WkHrEstReviewed:33+1
End case 