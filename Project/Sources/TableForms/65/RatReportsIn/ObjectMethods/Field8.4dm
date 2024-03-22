If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(6/23/16 17:19:49)
	Mods_2016_06
	//  `removed setting the date in [bridge mhd nbis] table - it is done on the Save action
End if 

//[Bridge MHD NBIS]DateRatReport:=[RatingReports]ReportDate
//PushChange (1;->[Bridge MHD NBIS]DateRatReport)
PushChange(2; Self:C308)