//Script for Radio Button Item 54A
//Use to designate neither highway or railroad beneath the structure 

Case of 
	: (sItem54n=1)
		[Bridge MHD NBIS:1]Item54A:107:="N"
		[Bridge MHD NBIS:1]Item54B:108:=0
		PushChange(1; ->[Bridge MHD NBIS:1]Item54A:107)
		PushChange(1; ->[Bridge MHD NBIS:1]Item54B:108)
End case 