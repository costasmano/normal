//Method: Object Method: [AddtlRatingRequests].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/30/14, 15:18:59
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04_bug
	//  `Log deletion here - made Action of button - delete record
	
End if 
//

If (OK=1)
	LogDeletion(->[RatingRequests:154]RatingRequestID_L:2; ->[AddtlRatingRequests:155]RatingRequestID_L:1; ->[AddtlRatingRequests:155]AddtlRequestID_L:2; 2)
End if 

//End Object Method: [AddtlRatingRequests].Input.bDelete