//Method: [Town Address].Town Address In.Field Bdept
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/13/20, 11:38:18
	// ----------------------------------------------------
	//Created : 
	Mods_2020_05
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		POPUPMENUC(->v_2_001_atxt; ->v_2_002_atxt; ->[Town Address:78]TownBDEPTPrefix:17)
		PushChange(1; ->[Town Address:78]TownBDEPTPrefix:17)
		
End case 

//End [Town Address].Town Address In.Field Bdept