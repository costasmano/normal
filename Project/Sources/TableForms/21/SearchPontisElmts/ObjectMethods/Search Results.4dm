CONFIRM:C162("Clear Current Search Results?"; "Clear"; "Cancel")
If (OK=1)
	vtSearchResultCnt:=""
	CLEAR SET:C117("Random Set")
	CLEAR SET:C117("TotalElmtsFound")
End if 