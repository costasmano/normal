//Method: Object Method: [RatingRequests].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/30/14, 12:16:56
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04_bug
	//  `LogNewRecord must be here because after the ACCEPT action of the button is complete, the record is not new anymore
End if 
//
If (Is new record:C668([RatingRequests:154]))
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[RatingRequests:154]BIN:1; ->[RatingRequests:154]RatingRequestID_L:2; 1; "RatingRequest")
End if 

//End Object Method: [RatingRequests].Input.bValidate