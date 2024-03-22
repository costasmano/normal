//Script for Radio Button Item 54A
//Use to designate railroad beneath the structure 

Case of 
	: (sItem54r=1)
		[Bridge MHD NBIS:1]Item54A:107:="R"
		PushChange(1; ->[Bridge MHD NBIS:1]Item54A:107)
End case 