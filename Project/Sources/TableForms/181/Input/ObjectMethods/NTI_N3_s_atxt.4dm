
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/29/15, 11:28:46
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].Input.NTI_N3_s_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/29/15 11:28:48)
	
End if 
If (NTI_N3_s_atxt>0)
	[NTI_TunnelInfo:181]NTI_N3_s:47:=Substring:C12(NTI_N3_s_atxt{NTI_N3_s_atxt}; 1; 1)
End if 
//End Object Method: [NTI_TunnelInfo].Input.NTI_N3_s_atxt

