//Script for CheckBox Item 51 

Case of 
	: (CBItem51=1)
		[Bridge MHD NBIS:1]Item51:96:=0
		PushChange(1; ->[Bridge MHD NBIS:1]Item51:96)
End case 