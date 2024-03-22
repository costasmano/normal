//Script for Radio Button Item 55h
//Use to designate highway beneath the structure 

Case of 
	: (tItem55h=1)
		[Bridge MHD NBIS:1]Item55A:110:="H"
		PushChange(1; ->[Bridge MHD NBIS:1]Item55A:110)
End case 