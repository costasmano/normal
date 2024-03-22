//Script for Radio Button Item 19
//Use to designate highway beneath the structure 

Case of 
	: (wItem19c=1)
		[Bridge MHD NBIS:1]Item19:91:=199
		PushChange(1; ->[Bridge MHD NBIS:1]Item19:91)
End case 