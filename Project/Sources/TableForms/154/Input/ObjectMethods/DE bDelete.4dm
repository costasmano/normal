//Method: Object Method: [RatingRequests].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/30/14, 13:35:17
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04_bug
	//  `missing code to log the deletion of a rating request
End if 
//
If (OK=1)
	LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[RatingRequests:154]BIN:1; ->[RatingRequests:154]RatingRequestID_L:2; 1)
End if 

//End Object Method: [RatingRequests].Input.bDelete