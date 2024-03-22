//Script for Check Box Item 47
Case of 
	: (CBItem47=1)
		[NBIS Secondary:3]Item47:25:=99.9
End case 
PushChange(1; ->[NBIS Secondary:3]Item47:25)