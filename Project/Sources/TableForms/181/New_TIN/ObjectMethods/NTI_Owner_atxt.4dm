
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 11:55:10
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_Owner_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30)
	
	
End if 
If (NTI_Owner_atxt>0)
	
	NTI_Owner_s:=Substring:C12(NTI_Owner_atxt{NTI_Owner_atxt}; 1; 3)
	NTI_SetTunnelNumber
	NTI_CheckForValidate
	GOTO OBJECT:C206(*; "NTI_TunnelID_atxt")
	
End if 
//End Object Method: [NTI_TunnelInfo].New_TIN.NTI_Owner_atxt

