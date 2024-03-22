//[Inspections];"Critical Member"
//[Inspections]VCR Tape No
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	
	PushChange(1; Self:C308)
	[Inspections:27]VCR Tape No:71:=Replace string:C233([Inspections:27]VCR Tape No:71; "_"; "")
	If ([Inspections:27]VCR Tape No:71#"")
		[Inspections:27]VCR:70:=True:C214
		PushChange(1; ->[Inspections:27]VCR:70)
	Else 
		[Inspections:27]VCR:70:=False:C215
		PushChange(1; ->[Inspections:27]VCR:70)
	End if 
End if 