//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 11:57:32
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Prefix_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_02  //Allow for change of tunnel number to allow for T or B as first character of second position
	//Modified by: Chuck Miller (2/20/18 17:14:30)
	Mods_2018_05  //Set entry on new TIN input to Allow prefix of T or B
	//Modified by: Chuck Miller (5/10/18 15:48:15)
End if 
If (Form event code:C388=On After Edit:K2:43)
	ut_LimitLength(Self:C308; 1)
End if 
If (NTI_Prefix_txt#"")
	NTI_SetEnterableForB
	NTI_SetTunnelNumber
	NTI_CheckForValidate
	
End if 
//End Object Method: [NTI_TunnelInfo].New_TIN.NTI_Prefix_txt