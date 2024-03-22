If (Form event code:C388=On Getting Focus:K2:7)
	If (Position:C15([ElementDict:30]Category:3; ";APP;OVR;TRA;")>0)  //Hide Dive for App, Ovr, Tra
		POST KEY:C465(Tab:K15:37)
	End if 
End if 

If (Form event code:C388=On Data Change:K2:15)
	LogChanges(->[ElementsSafety:29]AltRating:21; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
End if 