Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		INSP_ExportInspection
End case 
