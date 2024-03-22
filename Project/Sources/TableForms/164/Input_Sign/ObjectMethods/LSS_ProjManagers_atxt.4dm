POPUPMENUC(->LSS_ProjManagers_atxt; ->LSS_ProjManagerIDs_aL; ->[LSS_Inspection:164]LSS_ProjectManagerId_L:9)
C_LONGINT:C283($indx_L)
$indx_L:=LSS_ProjManagers_atxt
If ($indx_L>0)
	LSS_ProjectManager_s:=LSS_ProjManagers_atxt{$indx_L}
End if 