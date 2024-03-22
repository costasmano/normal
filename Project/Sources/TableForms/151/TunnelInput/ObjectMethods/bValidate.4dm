//Method: Object Method: [TunnelInfo].TunnelInput.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/23/13, 14:00:12
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		TNL_SIAInpForm_FM(On Validate:K2:3)
		
End case 

//End Object Method: [TunnelInfo].TunnelInput.bValidate