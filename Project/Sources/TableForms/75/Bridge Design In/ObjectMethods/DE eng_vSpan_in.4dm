If ([Bridge Design:75]MetricUnit:38=False:C215)
	[Bridge Design:75]TotalSpanLength:25:=Round:C94(eng_vSpan_ft+(eng_vSpan_in/12); 5)
	PushChange(1; ->[Bridge Design:75]TotalSpanLength:25)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item48:92:=Round:C94([Bridge Design:75]TotalSpanLength:25*0.3048; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item48:92)
	End if 
End if 
