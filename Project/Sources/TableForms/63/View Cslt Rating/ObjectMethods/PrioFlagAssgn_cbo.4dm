If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/17/2007 10:40:50)
	Mods_2007_CM10
	
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->>1)
			C_LONGINT:C283($selected_L)
			$selected_L:=Self:C308->
			If (Records in set:C195("UserSet")>0)
				COPY NAMED SELECTION:C331([Conslt Rating:63]; "CONSRTGSPREEDIT")
				COPY SET:C600("UserSet"; "PREHILITCONSRTG")
				USE SET:C118("UserSet")
				While (Not:C34(End selection:C36([Conslt Rating:63])))
					If (ut_LoadRecordInteractive(->[Conslt Rating:63]))
						[Conslt Rating:63]PriorityColorFlag:3:=Self:C308->{$selected_L}
						LogChanges(->[Conslt Rating:63]PriorityColorFlag:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Conslt Rating:63]BIN:1; ->[Conslt Rating:63]ConsltRatingID:42; 1)
						SAVE RECORD:C53([Conslt Rating:63])
					End if 
					NEXT RECORD:C51([Conslt Rating:63])
				End while 
				
				USE NAMED SELECTION:C332("CONSRTGSPREEDIT")
				CLEAR NAMED SELECTION:C333("CONSRTGSPREEDIT")
				HIGHLIGHT RECORDS:C656("PREHILITCONSRTG")
				CLEAR SET:C117("PREHILITCONSRTG")
				REDRAW WINDOW:C456
			Else 
				ALERT:C41("No Records Selected!!")
			End if 
			Self:C308->:=1
			
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		If ((User in group:C338(Current user:C182; "Bridge Insp Engineer")) | (Current user:C182="Designer"))
			OBJECT SET VISIBLE:C603(*; "PrioFlagAssgn_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "PrioFlagAssgn_@"; False:C215)
		End if 
		
End case 
