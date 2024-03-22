//Script for Radio Button Item 19
//Use to designate highway beneath the structure 

Case of 
	: (wItem19b=1)
		[NBIS Secondary:3]Item19:16:=1
		PushChange(1; ->[NBIS Secondary:3]Item19:16)
End case 