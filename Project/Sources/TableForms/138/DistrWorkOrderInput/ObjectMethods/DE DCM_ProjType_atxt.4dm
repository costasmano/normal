//POPUPMENUC (Self;Self;->[DCM_Project]Project Type)
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->{0}:=[DCM_Project:138]Project Type:3
	: (Form event code:C388=On Data Change:K2:15)
		[DCM_Project:138]Project Type:3:=Self:C308->{0}
	: (Form event code:C388=On Clicked:K2:4)
		[DCM_Project:138]Project Type:3:=Self:C308->{0}
		
End case 


