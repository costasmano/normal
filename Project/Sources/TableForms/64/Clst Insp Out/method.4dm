C_TEXT:C284(vInspMonth)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284(vAssignStatus)  // Command Replaced was o_C_STRING length was 20

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		
		If ((Month of:C24([Cons Inspection:64]InspMonth:34)=0) | (Year of:C25([Cons Inspection:64]InspMonth:34)=0))
			vInspMonth:=""
		Else 
			vInspMonth:=String:C10(Month of:C24([Cons Inspection:64]InspMonth:34))+"/"+String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
		End if 
		
		If ([Cons Inspection:64]AssignStatus:24="Insp. Notification Received")
			vAssignStatus:="Notifctn Recvd"
		Else 
			vAssignStatus:=[Cons Inspection:64]AssignStatus:24
		End if 
End case 