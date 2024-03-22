If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/12/10 14:22:25)
	Mods_2010_05
	//Added this to save attachments
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		SCPOA_FieldNoteCtrl("SAVEALLTODISK")
End case 

