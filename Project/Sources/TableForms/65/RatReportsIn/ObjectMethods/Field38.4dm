//  `NOTE: Formating for this object is done in calls from method RtgMethod_OM
If ([RatingReports:65]Item66:31<100)
	[Bridge MHD NBIS:1]Item66:139:=[RatingReports:65]Item66:31
Else 
	[Bridge MHD NBIS:1]Item66:139:=99.9
End if 
PushChange(1; ->[Bridge MHD NBIS:1]Item66:139)
PushChange(2; Self:C308)