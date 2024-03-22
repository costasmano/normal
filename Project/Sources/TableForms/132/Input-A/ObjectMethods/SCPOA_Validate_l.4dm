If (Modified record:C314([ScourPOA:132]))
	CONFIRM:C162("Do you want to save the changes that have been made?"; "Save"; "Cancel")
	If (OK=1)
		ACCEPT:C269
	End if 
Else 
	ACCEPT:C269
End if 
