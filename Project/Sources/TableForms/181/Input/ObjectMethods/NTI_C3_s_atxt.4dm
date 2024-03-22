
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 11:36:07
//----------------------------------------------------
//Method: NTI_C3_s_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (NTI_C3_s_atxt>0)
	[NTI_TunnelInfo:181]NTI_C3_s:34:=Substring:C12(NTI_C3_s_atxt{NTI_C3_s_atxt}; 1; 2)
	
End if 
//End NTI_C3_s_atxt

