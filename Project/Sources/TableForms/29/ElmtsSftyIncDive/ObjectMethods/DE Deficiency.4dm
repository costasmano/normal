If (Form event code:C388=On Data Change:K2:15)
	LogChanges(->[ElementsSafety:29]Deficiency:3; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
	If ([ElementsSafety:29]Deficiency:3="N")
		[ElementsSafety:29]Priority:20:=""
		LogChanges(->[ElementsSafety:29]Priority:20; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
	End if 
End if 