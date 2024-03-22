
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 11:57:32
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Number_s
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30)
	
End if 
ut_LimitLength(Self:C308; 2)
If (Form event code:C388=On Data Change:K2:15)
	
	If (NTI_Number_s#"")
		
		NTI_Number_s:=String:C10(Num:C11(NTI_Number_s); "00")
		NTI_SetTunnelNumber
		NTI_CheckForValidate
		
	End if 
End if 
//End Object Method: [NTI_TunnelInfo].New_TIN.NTI_Number_s

