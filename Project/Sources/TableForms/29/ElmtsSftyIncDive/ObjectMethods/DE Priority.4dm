If (Form event code:C388=On Getting Focus:K2:7)
	If ([ElementsSafety:29]Deficiency:3="N")
		POST KEY:C465(Tab:K15:37)  //skip priority if deficiency is N
	End if 
End if 
If (Form event code:C388=On Data Change:K2:15)
	LogChanges(->[ElementsSafety:29]Priority:20; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
End if 