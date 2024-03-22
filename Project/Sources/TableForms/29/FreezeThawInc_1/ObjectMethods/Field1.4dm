If (False:C215)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
End if 

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		InitChangeStack(2)
		PushChange(2; ->[ElementsSafety:29]Crack:9)
		If ([ElementsSafety:29]Crack:9)
			SET BLOB SIZE:C606([ElementsSafety:29]ElmComments:23; 0)
			PushChange(2; ->[ElementsSafety:29]ElmComments:23)
			[ElementsSafety:29]Comments:5:=""
			PushChange(2; ->[ElementsSafety:29]Comments:5)
			[ElementsSafety:29]Rating:2:="0"
			PushChange(2; ->[ElementsSafety:29]Rating:2)
			[ElementsSafety:29]Deficiency:3:="0"
			PushChange(2; ->[ElementsSafety:29]Deficiency:3)
		End if 
		If (Modified record:C314([ElementsSafety:29]))
			SAVE RECORD:C53([ElementsSafety:29])
			FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
		End if 
		
End case 