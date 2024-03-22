If (False:C215)
	//Object Method: ImportBtn 
	// Modified by: costasmanousakis-(Designer)-(12/6/2005 08:19:52)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(8/20/08 08:16:15)
	Mods_2008_CM_5404
	//  `Use method INSP_UpdateInspList
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(*; "ImportBtn"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "ImportBtn"; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		INSP_ImportInspection
		INSP_UpdateInspList
		
End case 

