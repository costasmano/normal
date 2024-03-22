If (False:C215)
	//Object Method: [Conslt Rating].Cslt Rating In.cboAssignmentStatus 
	// Modified by: costasmanousakis-(Designer)-(9/19/2007 09:20:24)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/1/2007 09:57:21)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(9/27/16 13:25:51)
	Mods_2016_09
	//  `Use TOL_ListToArray to load the list CONSRTG_ASSIGNSTAT for this dropdown
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		TOL_ListToArray("CONSRTG_ASSIGNSTAT"; Self:C308)
		
		If ([Conslt Rating:63]AssignStatus:43="")
			Case of 
				: ([Conslt Rating:63]NBISLetter:26#!00-00-00!)
					[Conslt Rating:63]AssignStatus:43:="Completed"
				: ([Conslt Rating:63]ReqFeeProposal:30#!00-00-00!)
					[Conslt Rating:63]AssignStatus:43:="Active"
				Else 
					
			End case 
		End if 
		POPUPMENUC(Self:C308; Self:C308; ->[Conslt Rating:63]AssignStatus:43)
		
	: (Form event code:C388=On Clicked:K2:4)
		POPUPMENUC(Self:C308; Self:C308; ->[Conslt Rating:63]AssignStatus:43)
		PushChange(1; ->[Conslt Rating:63]AssignStatus:43)
		If ([Conslt Rating:63]AssignStatus:43="Completed")
			[Conslt Rating:63]PriorityColorFlag:3:="Green"
			PushChange(1; ->[Conslt Rating:63]PriorityColorFlag:3)
		End if 
		
End case 