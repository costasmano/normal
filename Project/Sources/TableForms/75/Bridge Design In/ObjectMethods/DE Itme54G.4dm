//Script for Check Box Item 54 
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 

Case of 
	: (CBItem54=1)
		If ([Bridge Design:75]MetricUnit:38=True:C214)
			metric_vVertUnderclear:=99.99
		Else 
			eng_vVertUnderclear_ft:=99.99
			eng_vVertUnderclear_in:=0
			ut_SetEnterable("DE eng_vVertUnderclear_@"; False:C215)
		End if 
		[Bridge Design:75]MinVertUnderclear:45:=99.99
		
	: (CBItem54=0)
		ut_SetEnterable("DE eng_vVertUnderclear_@"; True:C214)
		If ([Bridge Design:75]MetricUnit:38=True:C214)
			metric_vVertUnderclear:=0
		Else 
			eng_vVertUnderclear_ft:=0
			eng_vVertUnderclear_in:=0
		End if 
		[Bridge Design:75]MinVertUnderclear:45:=0
End case 

PushChange(1; ->[Bridge Design:75]MinVertUnderclear:45)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	[Bridge MHD NBIS:1]Item54B:108:=[Bridge Design:75]MinVertUnderclear:45
	PushChange(2; ->[Bridge MHD NBIS:1]Item54B:108)
End if 
