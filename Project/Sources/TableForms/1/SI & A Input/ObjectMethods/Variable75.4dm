//Script for Radio Button Item 54A
//Use to designate highway beneath the structure 

Case of 
	: (sItem54h=1)
		[Bridge MHD NBIS:1]Item54A:107:="H"
		PushChange(1; ->[Bridge MHD NBIS:1]Item54A:107)
End case 