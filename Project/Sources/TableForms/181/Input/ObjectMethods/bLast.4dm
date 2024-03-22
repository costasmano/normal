
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/29/15, 16:55:05
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].Input.bLast
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/29/15 16:55:07)
	
End if 

NTI_TunnelRow_L:=Records in selection:C76([NTI_TunnelInfo:181])
NTI_ControlNextPrevMovement
//End Object Method: [NTI_TunnelInfo].Input.bLast

