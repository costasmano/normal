//Method: Object Method: [Preservation_Reviews].PreservReviewInput.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/31/13, 19:11:52
	// ----------------------------------------------------
	//Created : 
	//Mods_2013_07
End if 
//
If (PRV_ReviewSCR_DateCheck_B)
	CONFIRM:C162("There were Date entry errors!  Do you want to review the dates or save the record?"; "Review"; "Save")
	If (OK=1)
		REJECT:C38
	End if 
	
End if 

//End Object Method: [Preservation_Reviews].PreservReviewInput.bValidate