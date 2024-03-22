//Script for Radio Button Item 56
//Use to designate lateral underclearances greater than 30 M
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 

Case of 
	: (uItem56b=1)
		If ([Bridge Design:75]MetricUnit:38=True:C214)
			metric_vLatUnderclearLT:=99.8
		Else 
			eng_vLatUnderclearLT_ft:=99.8
			eng_vLatUnderclearLT_in:=0
			ut_SetEnterable("DE eng_vLatUnderclearLT_@"; False:C215)
		End if 
		[Bridge Design:75]MinLatUnderclearLT:47:=99.8
		PushChange(1; ->[Bridge Design:75]MinLatUnderclearLT:47)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			[Bridge MHD NBIS:1]Item56:112:=99.9
			PushChange(2; ->[Bridge MHD NBIS:1]Item56:112)
		End if 
End case 
