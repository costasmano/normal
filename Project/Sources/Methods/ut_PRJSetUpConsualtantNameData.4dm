//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): MillerC
// Date and time: 05/25/07, 11:19:39
// ----------------------------------------------------
// Method: ut_PRJSetUpConsualtantNameData
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r001  `05/08/09, 14:14:26  `Continue changes PRJ Design Contract Changes 
	//NO CHnage as this was a one time use
	Mods_2009_06  //r002 `06/11/09, 13:38:04   `Merge PRJ Design Contract Changes
End if 
If (False:C215)
	ALL RECORDS:C47([Conslt_Name:127])
	
	
	C_LONGINT:C283($Loop_l)
	FIRST RECORD:C50([Conslt_Name:127])
	For ($Loop_l; 1; Records in selection:C76([Conslt_Name:127]))
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]ConsultantNameID_l:2=[Conslt_Name:127]ConsultantNameID_l:1)
		If (Records in selection:C76([PRJ_DesignContracts:123])>0)
			FIRST RECORD:C50([PRJ_DesignContracts:123])
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]DC_OLDDesignContractID_l:2=[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
			If (Records in selection:C76([PRJ_ProjectFile:117])>0)
				FIRST RECORD:C50([PRJ_ProjectFile:117])
				
				QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
				
				If (Records in selection:C76([PRJ_ProjectDetails:115])>0)
					FIRST RECORD:C50([PRJ_ProjectDetails:115])
					[Conslt_Name:127]CurrentStructureProjectMgr_l:4:=[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39
					SAVE RECORD:C53([Conslt_Name:127])
				End if 
			End if 
		End if 
		UNLOAD RECORD:C212([Conslt_Name:127])
		NEXT RECORD:C51([Conslt_Name:127])
	End for 
Else 
	ALERT:C41("An upgrade must be done before this can be run")
	
End if 