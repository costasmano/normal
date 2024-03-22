//Script for CheckBox Item 98

Case of 
	: (CBItem98=1)
		BlankOut(->[Bridge MHD NBIS:1]Item98A:72)
		BlankOut(->[Bridge MHD NBIS:1]Item98B:73)
		BlankOut(->[Bridge MHD NBIS:1]Item99:74)
		PushChange(1; ->[Bridge MHD NBIS:1]Item98A:72)
		PushChange(1; ->[Bridge MHD NBIS:1]Item98B:73)
		PushChange(1; ->[Bridge MHD NBIS:1]Item99:74)
End case 