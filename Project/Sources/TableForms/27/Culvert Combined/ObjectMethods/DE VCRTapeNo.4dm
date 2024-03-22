//[Inspections];"Culvert Form"
//[Inspections]VCR Tape No

PushChange(1; Self:C308)
[Inspections:27]VCR Tape No:71:=Replace string:C233([Inspections:27]VCR Tape No:71; "_"; "")
If ([Inspections:27]VCR Tape No:71#"")
	[Inspections:27]VCR:70:=True:C214
	PushChange(1; ->[Inspections:27]VCR:70)  //DBD Added push change method
Else 
	[Inspections:27]VCR:70:=False:C215
	PushChange(1; ->[Inspections:27]VCR:70)  //DBD Added push change method
End if 