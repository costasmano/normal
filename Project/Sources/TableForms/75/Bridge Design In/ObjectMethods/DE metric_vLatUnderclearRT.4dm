If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/30/2007 08:49:47)
	Mods_2007_CM08
End if 
If ([Bridge Design:75]MetricUnit:38=True:C214)
	[Bridge Design:75]MinLatUnderclearRT:46:=Round:C94(metric_vLatUnderclearRT*3.280839850131; 5)
	PushChange(1; ->[Bridge Design:75]MinLatUnderclearRT:46)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item55B:111:=Round:C94(metric_vLatUnderclearRT; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item55B:111)
	End if 
End if 