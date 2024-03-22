//Script for Check Box Item 54 

Case of 
	: (CBItem54=1)
		[Bridge MHD NBIS:1]Item54B:108:=99.99
End case 
PushChange(1; ->[Bridge MHD NBIS:1]Item54B:108)
