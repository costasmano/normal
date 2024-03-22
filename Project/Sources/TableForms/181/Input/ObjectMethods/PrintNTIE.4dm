//Method: [NTI_TunnelInfo].Input.PrintNTIE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/25/18, 13:15:54
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04  //Print new [NTI_TunnelInfo];"NTIED_Print"
	//Modified by: Chuck Miller (4/25/18 13:16:19)
End if 
//
If (Form event code:C388=On Clicked:K2:4)
	PRINT SETTINGS:C106
	Print form:C5([NTI_TunnelInfo:181]; "NTIED_Print")
End if 
//End [NTI_TunnelInfo].Input.PrintNTIE