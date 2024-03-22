//Script for Check Box Item 55B 
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 

Case of 
	: (CBItem55=1)
		If ([Bridge Design:75]MetricUnit:38=True:C214)
			metric_vLatUnderclearRT:=99.9
		Else 
			eng_vLatUnderclearRT_ft:=99.9
			eng_vLatUnderclearRT_in:=0
			ut_SetEnterable("DE eng_vLatUnderclearRT_@"; False:C215)
		End if 
		[Bridge Design:75]MinLatUnderclearRT:46:=99.9
		
	: (CBItem55=0)
		ut_SetEnterable("DE eng_vLatUnderclearRT_@"; True:C214)
		If ([Bridge Design:75]MetricUnit:38=True:C214)
			metric_vLatUnderclearRT:=0
		Else 
			eng_vLatUnderclearRT_ft:=0
			eng_vLatUnderclearRT_in:=0
		End if 
		[Bridge Design:75]MinLatUnderclearRT:46:=0
End case 

PushChange(1; ->[Bridge Design:75]MinLatUnderclearRT:46)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	[Bridge MHD NBIS:1]Item55B:111:=[Bridge Design:75]MinLatUnderclearRT:46
	PushChange(2; ->[Bridge MHD NBIS:1]Item55B:111)
End if 
