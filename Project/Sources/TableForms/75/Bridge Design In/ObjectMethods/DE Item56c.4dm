//Script for Radio Button Item 56
//Use to designate not applicable
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 

Case of 
	: (uItem56c=1)
		If ([Bridge Design:75]MetricUnit:38=True:C214)
			metric_vLatUnderclearLT:=0
		Else 
			eng_vLatUnderclearLT_ft:=0
			eng_vLatUnderclearLT_in:=0
		End if 
		
		[Bridge Design:75]MinLatUnderclearLT:47:=0
		PushChange(1; ->[Bridge Design:75]MinLatUnderclearLT:47)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item56:112:=0
			PushChange(2; ->[Bridge MHD NBIS:1]Item56:112)
		End if 
		ut_SetEnterable("DE eng_vLatUnderclearLT_@"; False:C215)
End case 
