//Method: [NTI_TunnelInfo].New_TIN.NoEntry4_B
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/10/18, 15:08:49
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05  //Set entry on new TIN input to Allow prefix of T or B
	//Modified by: Chuck Miller (5/10/18 15:48:15)
	
End if 
//
If (Form event code:C388=On After Edit:K2:43)
	ut_LimitLength(Self:C308; 3)
End if 
NTI_SetTunnelNumber
NTI_CheckForValidate
//End [NTI_TunnelInfo].New_TIN.NoEntry4_B