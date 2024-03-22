//Script for Radio Button Item 56
//Use to designate no obstruction at median

Case of 
	: (uItem56a=1)
		[Bridge MHD NBIS:1]Item56:112:=99.9
		PushChange(1; ->[Bridge MHD NBIS:1]Item56:112)
End case 