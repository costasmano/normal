//Script for Check Box Item 47
Case of 
	: (CBItem47=1)
		[Bridge MHD NBIS:1]Item47:104:=99.9
End case 
PushChange(1; ->[Bridge MHD NBIS:1]Item47:104)