//Script for Radio Button Item 56
//Eliminate non values

Case of 
	: (uItem56d=1)
		If (([Bridge MHD NBIS:1]Item56:112=99.9) | ([Bridge MHD NBIS:1]Item56:112=99.8) | ([Bridge MHD NBIS:1]Item56:112<=0))
			ALERT:C41("Please edit Item 56!")
			[Bridge MHD NBIS:1]Item56:112:=1
		End if 
		PushChange(1; ->[Bridge MHD NBIS:1]Item56:112)
End case 