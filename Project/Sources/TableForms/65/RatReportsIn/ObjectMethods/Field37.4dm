//  `NOTE: Formating for this object is done in calls from method RtgMethod_OM
If ([RatingReports:65]Item64:29<100)
	[Bridge MHD NBIS:1]Item64:137:=[RatingReports:65]Item64:29
Else 
	[Bridge MHD NBIS:1]Item64:137:=99.9
End if 
PushChange(1; ->[Bridge MHD NBIS:1]Item64:137)
PushChange(2; Self:C308)