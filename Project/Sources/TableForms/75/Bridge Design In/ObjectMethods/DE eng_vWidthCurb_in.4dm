If ([Bridge Design:75]MetricUnit:38=False:C215)
	[Bridge Design:75]WidthCurbToCurb:44:=Round:C94(eng_vWidthCurb_ft+(eng_vWidthCurb_in/12); 5)
	PushChange(1; ->[Bridge Design:75]WidthCurbToCurb:44)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item51:96:=Round:C94([Bridge Design:75]WidthCurbToCurb:44*0.3048; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item51:96)
	End if 
End if 