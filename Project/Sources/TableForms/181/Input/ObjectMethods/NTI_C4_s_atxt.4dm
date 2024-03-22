
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 11:36:07
//----------------------------------------------------
//Method: NTI_C4_s_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (NTI_C4_s_atxt>0)
	[NTI_TunnelInfo:181]NTI_C4_s:35:=Substring:C12(NTI_C4_s_atxt{NTI_C4_s_atxt}; 1; 1)
End if 
//End NTI_C4_s_atxt

