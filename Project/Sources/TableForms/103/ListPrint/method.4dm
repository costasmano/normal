If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/30/05, 12:14:36
	// ----------------------------------------------------
	// Method: Form Method: ListPrint
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_TEXT:C284(S2_Assgn_Adden)  // Command Replaced was o_C_STRING length was 10
		If ([Work_Estimate:103]AddendumNo:29<=0)
			S2_Assgn_Adden:=String:C10([Work_Estimate:103]AssignNo:16)
		Else 
			S2_Assgn_Adden:=String:C10([Work_Estimate:103]AssignNo:16)+" / "+String:C10([Work_Estimate:103]AddendumNo:29)
		End if 
		WKHR_ApprStatus_p:=[Work_Estimate:103]WkHrEstApproved:18+1
		WKHR_RevStatus_p:=[Work_Estimate:103]WkHrEstReviewed:33+1
		
End case 