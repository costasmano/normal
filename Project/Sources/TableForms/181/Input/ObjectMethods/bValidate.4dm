
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/03/15, 11:31:53
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (11/3/15 11:32:15)
	// Modified by: Costas Manousakis-(Designer)-(12/12/15 12:35:48)
	Mods_2015_12_bug
	//  `added [NTI_TunnelInfo]NTI_ModifiedTimeStamp_s and [NTI_TunnelInfo]NTI_ModifiedBy_s
End if 
NTI_MovingRecords_B:=False:C215
If (Modified record:C314([NTI_TunnelInfo:181]))
	[NTI_TunnelInfo:181]NTI_ModifiedBy_s:3:=Current user:C182
	[NTI_TunnelInfo:181]NTI_ModifiedTimeStamp_s:5:=ISODateTime(Current date:C33(*); Current time:C178(*))
	FM_SaveTunnelInfo
End if 
ACCEPT:C269
//End Object Method: [NTI_TunnelInfo].Input.bValidate

