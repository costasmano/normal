If ([Bridge Design:75]MetricUnit:38=False:C215)
	[Bridge Design:75]MinLatUnderclearRT:46:=Round:C94(eng_vLatUnderclearRT_ft+(eng_vLatUnderclearRT_in/12); 5)
	PushChange(1; ->[Bridge Design:75]MinLatUnderclearRT:46)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item55B:111:=Round:C94([Bridge Design:75]MinLatUnderclearRT:46*0.3048; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item55B:111)
	End if 
End if 