//Script for CheckBox Item 10 

Case of 
	: (CBItem10=1)
		[Bridge MHD NBIS:1]Item10:102:=99.99
	: (CBItem10=0)
		[Bridge MHD NBIS:1]Item10:102:=0
End case 
PushChange(1; ->[Bridge MHD NBIS:1]Item10:102)
