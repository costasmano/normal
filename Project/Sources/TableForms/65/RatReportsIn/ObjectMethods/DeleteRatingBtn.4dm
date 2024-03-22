If (False:C215)
	//[RatingReports];"RatReportsIn".DeleteRatingBtn
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
	
End if 

CONFIRM:C162("Delete this Rating Report?")
If (OK=1)
	LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[RatingReports:65]BIN:1; ->[RatingReports:65]RatingID:21; 1)
	//Need to remove the rating report from the list.
	CREATE SET:C116([RatingReports:65]; "OrigRatRpts")
	REMOVE FROM SET:C561([RatingReports:65]; "OrigRatRpts")
	DELETE RECORD:C58([RatingReports:65])
	CANCEL:C270
	USE SET:C118("OrigRatRpts")
	CLEAR SET:C117("OrigRatRpts")
	ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
	
End if 