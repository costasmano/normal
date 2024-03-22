If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/6/11 10:33:31)
	Mods_2011_04
	//  `Replaced Self with Variable name ; moved on load event to form method on - avoid problems in v11
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283(HL_Selected_item)
		POPUP_HL_MENUC(ConsNames_HL; ->HL_Selected_item)
		[Conslt Address:77]ConsultantNameID_l:22:=a_CnameID_aL{HL_Selected_item}
		
End case 
