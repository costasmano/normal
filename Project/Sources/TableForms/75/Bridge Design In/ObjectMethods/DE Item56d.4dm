//Script for Radio Button Item 56
//Eliminate non values
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 

Case of 
	: (uItem56d=1)
		If (([Bridge Design:75]MinLatUnderclearLT:47=99.9) | ([Bridge Design:75]MinLatUnderclearLT:47=99.8) | ([Bridge Design:75]MinLatUnderclearLT:47<=0))
			ALERT:C41("Please edit Item 56!")
			[Bridge Design:75]MinLatUnderclearLT:47:=1
		End if 
		PushChange(1; ->[Bridge Design:75]MinLatUnderclearLT:47)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item56:112:=1
			PushChange(2; ->[Bridge MHD NBIS:1]Item56:112)
		End if 
		ut_SetEnterable("DE eng_vLatUnderclearLT_@"; True:C214)
End case 
