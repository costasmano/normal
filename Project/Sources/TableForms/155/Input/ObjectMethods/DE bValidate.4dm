//Method: Object Method: [AddtlRatingRequests].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/30/14, 15:19:46
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04_bug
	//  `log new record here
End if 
//

If (Is new record:C668([AddtlRatingRequests:155]))
	LogNewRecord(->[RatingRequests:154]RatingRequestID_L:2; ->[AddtlRatingRequests:155]RatingRequestID_L:1; ->[AddtlRatingRequests:155]AddtlRequestID_L:2; 2; "AddRatingRequest")
End if 

//End Object Method: [AddtlRatingRequests].Input.bValidate