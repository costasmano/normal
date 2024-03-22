If ([Bridge Design:75]MetricUnit:38=False:C215)
	[Bridge Design:75]StructLength:43:=Round:C94(eng_vStructLength_ft+(eng_vStructLength_in/12); 5)
	PushChange(1; ->[Bridge Design:75]StructLength:43)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item49:93:=Round:C94([Bridge Design:75]StructLength:43*0.3048; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item49:93)
	End if 
	
	If (([Bridge Design:75]WideOutToOut:26*[Bridge Design:75]StructLength:43)#0)
		[Bridge Design:75]CostPerSQM:37:=[Bridge Design:75]TotalOfficeEstimate:6/([Bridge Design:75]WideOutToOut:26*[Bridge Design:75]StructLength:43)
		PushChange(1; ->[Bridge Design:75]CostPerSQM:37)
	End if 
	
End if 