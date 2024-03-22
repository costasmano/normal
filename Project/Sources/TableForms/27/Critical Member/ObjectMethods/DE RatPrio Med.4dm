//[Inspections];"Inspection Form"
//RatingPriority
//x2

If (x2=1)
	[Inspections:27]RatingPriority:85:="M"
	[Inspections:27]Rerating:75:=True:C214
	PushChange(1; ->[Inspections:27]RatingPriority:85)
	PushChange(1; ->[Inspections:27]Rerating:75)
End if 