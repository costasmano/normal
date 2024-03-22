//Script for Radio Button Item 56
//Use to designate lateral underclearances greater than 30 M

Case of 
	: (uItem56b=1)
		[Bridge MHD NBIS:1]Item56:112:=99.8
		PushChange(1; ->[Bridge MHD NBIS:1]Item56:112)
End case 