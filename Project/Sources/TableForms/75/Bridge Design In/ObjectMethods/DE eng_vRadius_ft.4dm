If ([Bridge Design:75]MetricUnit:38=False:C215)
	[Bridge Design:75]RadiusCurvedGirder:29:=Round:C94(eng_vRadius_ft+(eng_vRadius_in/12); 5)
	PushChange(1; ->[Bridge Design:75]RadiusCurvedGirder:29)
End if 