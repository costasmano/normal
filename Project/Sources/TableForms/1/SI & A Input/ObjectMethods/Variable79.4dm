//Script for Radio Button Item 55A
//Use to designate railroad beneath the structure 

Case of 
	: (tItem55r=1)
		[Bridge MHD NBIS:1]Item55A:110:="R"
		PushChange(1; ->[Bridge MHD NBIS:1]Item55A:110)
End case 