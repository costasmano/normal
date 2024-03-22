If ([RatingReports:65]ReportDate:4=!00-00-00!)
	ALERT:C41("Please enter a valid date or delete this record when you are done!")
Else 
	CANCEL:C270
End if 