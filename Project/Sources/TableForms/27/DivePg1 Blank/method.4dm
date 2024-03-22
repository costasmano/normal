If (False:C215)
	Mods_2005_CM05
	Mods_2005_CM15
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		G_SIA_BuildTownLine
		//Add Variable for Town name and Insp date _must be uppercase
		sTOWN:=Uppercase:C13([Bridge MHD NBIS:1]Town Name:175)
		G_Insp_FmtSTOWN
		
		sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
		
End case 