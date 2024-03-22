//Script for Radio Button Item 56
//Use to designate not applicable

Case of 
	: (uItem56c=1)
		[Bridge MHD NBIS:1]Item56:112:=0
		PushChange(1; ->[Bridge MHD NBIS:1]Item56:112)
End case 