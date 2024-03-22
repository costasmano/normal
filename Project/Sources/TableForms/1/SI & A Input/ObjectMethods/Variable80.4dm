//Script for Radio Button Item 55B
//Use to designate neither highway or railroad beneath the structure 

Case of 
	: (tItem55n=1)
		[Bridge MHD NBIS:1]Item55A:110:="N"
		[Bridge MHD NBIS:1]Item55B:111:=0
		PushChange(1; ->[Bridge MHD NBIS:1]Item55A:110)
		PushChange(1; ->[Bridge MHD NBIS:1]Item55B:111)
End case 