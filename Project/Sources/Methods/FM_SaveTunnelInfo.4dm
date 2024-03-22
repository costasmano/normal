//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/29/15, 16:44:02
//----------------------------------------------------
//Method: FM_SaveTunnelInfo
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/29/15 16:44:03)
	
End if 
ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "NTI_i1_s")
If (ACT_PushGroupChanges(Table:C252(->[NTI_TunnelInfo:181]); 1; ->$FieldsToSkip_atxt))
	FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; 0)
	SAVE RECORD:C53([NTI_TunnelInfo:181])
End if 
VALIDATE TRANSACTION:C240
//End FM_SaveTunnelInfo

