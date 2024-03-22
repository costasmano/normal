If ([Bridge Design:75]MetricUnit:38=True:C214)
	If (([Bridge Design:75]WideOutToOut:26*[Bridge Design:75]StructLength:43)#0)
		C_REAL:C285($area)
		$area:=([Bridge Design:75]WideOutToOut:26*0.3048*[Bridge Design:75]StructLength:43*0.3048)
		[Bridge Design:75]CostPerSQM:37:=[Bridge Design:75]TotalOfficeEstimate:6/$area
		PushChange(1; ->[Bridge Design:75]CostPerSQM:37)
	End if 
	
Else 
	
	If (([Bridge Design:75]WideOutToOut:26*[Bridge Design:75]StructLength:43)#0)
		[Bridge Design:75]CostPerSQM:37:=[Bridge Design:75]TotalOfficeEstimate:6/([Bridge Design:75]WideOutToOut:26*[Bridge Design:75]StructLength:43)
		PushChange(1; ->[Bridge Design:75]CostPerSQM:37)
	End if 
End if 

PushChange(1; Self:C308)