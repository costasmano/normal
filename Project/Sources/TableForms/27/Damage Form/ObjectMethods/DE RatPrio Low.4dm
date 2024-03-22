//[Inspections];"Inspection Form"
//RatingPriority
//x3

If (x3=1)
	[Inspections:27]RatingPriority:85:="L"
	[Inspections:27]Rerating:75:=True:C214
	PushChange(1; ->[Inspections:27]RatingPriority:85)
	PushChange(1; ->[Inspections:27]Rerating:75)
End if 