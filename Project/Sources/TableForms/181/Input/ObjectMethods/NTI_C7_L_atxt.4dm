
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 11:36:07
//----------------------------------------------------
//Method: NTI_C7_L_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
If (NTI_C7_L_atxt>0)
	[NTI_TunnelInfo:181]NTI_C7_L:38:=Num:C11(Substring:C12(NTI_C7_L_atxt{NTI_C7_L_atxt}; 1; 1))
End if 
//End NTI_C6_s_atxt

