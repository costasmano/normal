If ([Bridge Design:75]MetricUnit:38=False:C215)
	[Bridge Design:75]SidewalkRight:24:=Round:C94(eng_vRight_ft+(eng_vRight_in/12); 5)
	PushChange(1; ->[Bridge Design:75]SidewalkLeft:23)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item50B:95:=Round:C94([Bridge Design:75]SidewalkRight:24*0.3048; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item50B:95)
	End if 
End if 