
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 16:51:21
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].New_TIN.NTI_VentID_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30)
	
End if 
If (NTI_VentID_atxt>0)
	NTI_Vent_s:=Substring:C12(NTI_VentID_atxt{NTI_VentID_atxt}; 1; 3)
	NTI_SetTunnelNumber
	NTI_CheckForValidate
	GOTO OBJECT:C206(*; "NTI_Owner_atxt")
	
End if 

//End Object Method: [NTI_TunnelInfo].New_TIN.NTI_VentID_atxt

