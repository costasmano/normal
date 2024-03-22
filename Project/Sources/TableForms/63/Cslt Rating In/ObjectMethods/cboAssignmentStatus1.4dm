If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/19/2007 09:20:24)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/1/2007 09:57:21)
	Mods_2007_CM12_5301
End if 

POPUPMENUC(Self:C308; Self:C308; ->[Conslt Rating:63]AssignStatus:43)
Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([Conslt Rating:63]AssignStatus:43="")
			Case of 
				: ([Conslt Rating:63]NBISLetter:26#!00-00-00!)
					Self:C308->:=4
					[Conslt Rating:63]AssignStatus:43:="Completed"
				: ([Conslt Rating:63]ReqFeeProposal:30#!00-00-00!)
					Self:C308->:=2
					[Conslt Rating:63]AssignStatus:43:="Active"
				Else 
					Self:C308->:=1
			End case 
			POPUPMENUC(Self:C308; Self:C308; ->[Conslt Rating:63]AssignStatus:43)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		PushChange(1; ->[Conslt Rating:63]AssignStatus:43)
		If ([Conslt Rating:63]AssignStatus:43="Completed")
			[Conslt Rating:63]PriorityColorFlag:3:="Green"
			PushChange(1; ->[Conslt Rating:63]PriorityColorFlag:3)
		End if 
		
End case 