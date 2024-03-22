//Script for CheckBox Item 52 

Case of 
	: (CBItem52=1)
		[Bridge MHD NBIS:1]Item52:97:=0
		PushChange(1; ->[Bridge MHD NBIS:1]Item52:97)
End case 