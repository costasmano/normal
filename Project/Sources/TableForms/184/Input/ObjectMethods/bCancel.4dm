
If (Not:C34(Read only state:C362([TIN_Inspections:184])))
	CONFIRM:C162("Exit Inspection without saving?"; "Exit without Saving"; "Stay in Form")
	If (OK=1)
		If (In transaction:C397)
			CANCEL TRANSACTION:C241
		End if 
		CANCEL:C270
	End if 
Else 
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	CANCEL:C270
End if 