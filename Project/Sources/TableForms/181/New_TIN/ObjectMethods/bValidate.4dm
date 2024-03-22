
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 13:12:23
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].New_TIN.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/22/15 13:34:40)
	// Modified by: Costas Manousakis-(Designer)-(12/12/15 12:33:38)
	Mods_2015_12_bug
	//  `Added [NTI_TunnelInfo]NTI_CreatedBy_s and [NTI_TunnelInfo]NTI_CreatedTimeStamp_s
End if 
C_BOOLEAN:C305($Proceed_B)

NTI_CheckForValidate

ARRAY TEXT:C222($FieldsToSkip_atxt; 0)

APPEND TO ARRAY:C911($FieldsToSkip_atxt; "NTI_i1_s")
If (Is new record:C668([NTI_TunnelInfo:181]))
	LogNewRecord(->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; 0; "NTI_TunnelInfo")
	[NTI_TunnelInfo:181]NTI_CreatedBy_s:2:=Current user:C182
	[NTI_TunnelInfo:181]NTI_CreatedTimeStamp_s:4:=ISODateTime(Current date:C33(*); Current time:C178(*))
End if 
If (ACT_PushGroupChanges(Table:C252(->[NTI_TunnelInfo:181]); 1; ->$FieldsToSkip_atxt))
	FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; 0)
	SAVE RECORD:C53([NTI_TunnelInfo:181])
End if 
APPEND TO ARRAY:C911(NTI_SelectedRN_aL; Record number:C243([NTI_TunnelInfo:181]))

VALIDATE TRANSACTION:C240
ACCEPT:C269


//End Object Method: [NTI_TunnelInfo].New_TIN.bValidate

