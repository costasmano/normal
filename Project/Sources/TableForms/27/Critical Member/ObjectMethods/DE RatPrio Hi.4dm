//[Inspections];"Inspection Form"
//RatingPriority
//x1

If (x1=1)
	[Inspections:27]RatingPriority:85:="H"
	[Inspections:27]Rerating:75:=True:C214
	PushChange(1; ->[Inspections:27]RatingPriority:85)
	PushChange(1; ->[Inspections:27]Rerating:75)
End if 