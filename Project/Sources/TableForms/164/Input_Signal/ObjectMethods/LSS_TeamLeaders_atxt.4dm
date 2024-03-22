POPUPMENUC(->LSS_TeamLeaders_atxt; ->LSS_TeamLeaderIDs_aL; ->[LSS_Inspection:164]LSS_TeamLeaderId_L:8)
C_LONGINT:C283($indx_L)
$indx_L:=LSS_TeamLeaders_atxt
If ($indx_L>0)
	LSS_TeamLeader_s:=LSS_TeamLeaders_atxt{$indx_L}
End if 