
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 11:36:07
//----------------------------------------------------
//Method: NTI_i8_s_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (NTI_i8_s_atxt>0)
	[NTI_TunnelInfo:181]NTI_i8_s:13:=Substring:C12(NTI_i8_s_atxt{NTI_i8_s_atxt}; 1; 1)
	
	NTI_CheckForValidate
	
End if 
//End NTI_RouteDirection_atxt

