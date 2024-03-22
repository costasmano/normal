Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(Self:C308->; User in group:C338(Current user:C182; "Design Access Group"))
		
	: (Form event code:C388=On Clicked:K2:4)
		ALERT:C41("Current image ID = "+String:C10([TIN_Insp_Images:186]ImageID:2)+Char:C90(13)+"Current insp ID = "+String:C10([TIN_Insp_Images:186]InspectionID:1))
End case 
