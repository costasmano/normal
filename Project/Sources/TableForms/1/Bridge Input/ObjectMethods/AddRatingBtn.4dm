//Add button to Ratings
// Method: [Bridge MHD NBIS].Bridge Input.AddRatingBtn
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
End if 

FORM SET INPUT:C55([RatingReports:65]; "RatReportsIn")
ADD RECORD:C56([RatingReports:65])
QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
