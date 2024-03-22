//Script for Check Box Item 53 

Case of 
	: (CBItem53=1)
		[Bridge MHD NBIS:1]Item53:105:=99.99
End case 
PushChange(1; ->[Bridge MHD NBIS:1]Item53:105)
