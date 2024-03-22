//Script for Check Box Item 55B 

Case of 
	: (CBItem55=1)
		[Bridge MHD NBIS:1]Item55B:111:=99.9
End case 
PushChange(1; ->[Bridge MHD NBIS:1]Item55B:111)
