If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(1/16/14 10:51:08)
	Mods_2014_02
	//  `RatingRequests
End if 

//Add button to RatingRequests

FORM SET INPUT:C55([RatingRequests:154]; "Input")
ADD RECORD:C56([RatingRequests:154])
READ ONLY:C145([RatingRequests:154])
READ ONLY:C145([RatingRequests:154])
QUERY:C277([RatingRequests:154]; [RatingRequests:154]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([RatingRequests:154]; [RatingRequests:154]DateOfRequest_d:3; <)