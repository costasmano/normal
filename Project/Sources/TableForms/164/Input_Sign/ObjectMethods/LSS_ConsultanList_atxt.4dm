If (LSS_ConsultanList_atxt>0)
	POPUPMENUC(->LSS_ConsultanList_atxt; ->LSS_ConsultanList_atxt; ->[LSS_Inspection:164]LSS_ConsultantName_txt:10)
	LSS_SetPersonnel
	If (Find in array:C230(LSS_TeamLeaderIDs_aL; [LSS_Inspection:164]LSS_TeamLeaderId_L:8)>0)
		LSS_TeamLeaders_atxt:=Find in array:C230(LSS_TeamLeaderIDs_aL; [LSS_Inspection:164]LSS_TeamLeaderId_L:8)
	Else 
		LSS_TeamLeaders_atxt:=0
	End if 
	If (Find in array:C230(LSS_ProjManagerIDs_aL; [LSS_Inspection:164]LSS_ProjectManagerId_L:9)>0)
		LSS_ProjManagers_atxt:=Find in array:C230(LSS_ProjManagerIDs_aL; [LSS_Inspection:164]LSS_ProjectManagerId_L:9)
	Else 
		LSS_ProjManagers_atxt:=0
	End if 
End if 
