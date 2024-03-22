
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 11:36:07
//----------------------------------------------------
//Method: NTI_C1_s_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
Case of 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (NTI_C1_s_atxt>0)
			[NTI_TunnelInfo:181]NTI_C1_s:32:=Substring:C12(NTI_C1_s_atxt{NTI_C1_s_atxt}; 1; 2)
			
		End if 
End case 
//End [NTI_TunnelInfo]NTI_C1_s

