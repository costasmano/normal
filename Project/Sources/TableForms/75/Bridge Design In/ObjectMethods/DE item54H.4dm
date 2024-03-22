//Script for Radio Button Item 54A
//Use to designate highway beneath the structure 

Case of 
	: (sItem54h=1)
		[Bridge Design:75]MinVertUcCode:48:="H"
		PushChange(1; ->[Bridge Design:75]MinVertUcCode:48)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item54A:107:="H"
			PushChange(2; ->[Bridge MHD NBIS:1]Item54A:107)
		End if 
End case 