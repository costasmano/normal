//Script for Radio Button Item 54A
//Use to designate railroad beneath the structure 

Case of 
	: (sItem54r=1)
		[Bridge Design:75]MinVertUcCode:48:="R"
		PushChange(1; ->[Bridge Design:75]MinVertUcCode:48)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item54A:107:="R"
			PushChange(2; ->[Bridge MHD NBIS:1]Item54A:107)
			
		End if 
		
End case 