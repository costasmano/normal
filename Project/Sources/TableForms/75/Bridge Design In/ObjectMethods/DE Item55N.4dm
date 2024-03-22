If (False:C215)
	//Script for Radio Button Item 55B
	//Use to designate neither highway or railroad beneath the structure 
	
	Mods_2005_CM19
End if 

Case of 
	: (tItem55n=1)
		
		[Bridge Design:75]MinLatUcCode:49:="N"
		PushChange(1; ->[Bridge Design:75]MinLatUcCode:49)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item55A:110:="N"
			PushChange(2; ->[Bridge MHD NBIS:1]Item55A:110)
			
		End if 
End case 