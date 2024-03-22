//Method: Object Method: [RatingRequests].Input.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/15/14, 14:27:00
	// ----------------------------------------------------
	//Created : 
	Mods_2014_01
End if 
//
FORM SET INPUT:C55([AddtlRatingRequests:155]; "Input")
ADD RECORD:C56([AddtlRatingRequests:155])
QUERY:C277([AddtlRatingRequests:155]; [AddtlRatingRequests:155]RatingRequestID_L:1=[RatingRequests:154]RatingRequestID_L:2)
ORDER BY:C49([AddtlRatingRequests:155]; [AddtlRatingRequests:155]NewRequestDate_d:3; <)
//End Object Method: [RatingRequests].Input.Button