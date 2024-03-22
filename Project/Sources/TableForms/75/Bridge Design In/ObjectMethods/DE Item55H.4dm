//Script for Radio Button Item 55h
//Use to designate highway beneath the structure 
Case of 
	: (tItem55h=1)
		[Bridge Design:75]MinLatUcCode:49:="H"
		PushChange(1; ->[Bridge Design:75]MinLatUcCode:49)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item55A:110:="H"
			PushChange(2; ->[Bridge MHD NBIS:1]Item55A:110)
		End if 
End case 