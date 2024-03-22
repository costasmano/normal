//Script for Radio Button Item 55A
//Use to designate railroad beneath the structure 

Case of 
	: (tItem55r=1)
		[Bridge Design:75]MinLatUcCode:49:="R"
		PushChange(1; ->[Bridge Design:75]MinLatUcCode:49)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item55A:110:="R"
			PushChange(2; ->[Bridge MHD NBIS:1]Item55A:110)
		End if 
End case 