If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 
If ([Bridge Design:75]MetricUnit:38=False:C215)
	[Bridge Design:75]MinVertUnderclear:45:=Round:C94(eng_vVertUnderclear_ft+(eng_vVertUnderclear_in/12); 5)
	PushChange(1; ->[Bridge Design:75]MinVertUnderclear:45)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item54B:108:=Round:C94([Bridge Design:75]MinVertUnderclear:45*0.3048; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item54B:108)
	End if 
End if 