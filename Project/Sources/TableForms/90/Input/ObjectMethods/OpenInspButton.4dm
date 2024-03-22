//bOpenInsp
//Open selected Inspection.

If (Record number:C243([Combined Inspections:90])<0)
	ALERT:C41("You Must select an inspection to Edit/Open")
Else 
	RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
	RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
	FORM SET INPUT:C55([Inspections:27]; "BlankStarter")
	vbInspRefresh:=True:C214  //mark this to refresh inspection list upon exit from form
	If ([Inspections:27]Insp Type:6="DV@")
		Case of 
			: ([Inspections:27]InspApproved:167=BMS Approved)
				MODIFY RECORD:C57([Inspections:27])
			: ([Inspections:27]Modified By:134=Current user:C182)
				MODIFY RECORD:C57([Inspections:27])
			: (Current user:C182="Designer")
				MODIFY RECORD:C57([Inspections:27])
			Else 
				C_TEXT:C284($msg)
				$msg:="You cannot view Underwater Inspection dated "+String:C10([Inspections:27]Insp Date:78; Internal date short special:K1:4)+"."+<>sCR
				$msg:=$msg+"Inspection has not been Approved yet!"
				ALERT:C41($msg)
		End case 
	Else 
		MODIFY RECORD:C57([Inspections:27])
	End if 
End if 