//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJUpgradeProjectDetail
// User name (OS): charlesmiller
// Date and time: 04/29/09, 16:36:23
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/29/09, 16:36:26 `PRJ Design Contract Changes
	Mods_2009_06  //r002 `06/11/09, 13:45:30   `Merge PRJ Design Contract Changes
End if 
//TRACE
READ ONLY:C145(*)
READ WRITE:C146([PRJ_ProjectDetails:115])
READ WRITE:C146([PRJ_ProjectFile:117])
QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3>0)
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
	If (Not:C34(ut_LoadRecord(->[PRJ_ProjectDetails:115])))
		Repeat 
			IDLE:C311
			uT_DelayUserProcess
		Until (ut_LoadRecord(->[PRJ_ProjectDetails:115]))
		
	End if 
	QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectDetails:115]PF_FileID_l:3)
	QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
	If (Not:C34(ut_LoadRecord(->[PRJ_ProjectFile:117])))
		Repeat 
			IDLE:C311
			uT_DelayUserProcess
		Until (ut_LoadRecord(->[PRJ_ProjectFile:117]))
	End if 
	If (Records in selection:C76([PRJ_DCPFJoin:135])>0)
		[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2
		
	Else 
		If (Records in selection:C76([PRJ_ProjectFile:117])>0)
			[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=[PRJ_ProjectFile:117]DC_OLDDesignContractID_l:2
		End if 
		
	End if 
	If ([PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15#0)
		If (Not:C34([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52))
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
			If ([PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15#[PRJ_DesignContracts:123]ConsultantNameID_l:2)
				[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15
			End if 
		Else 
			[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15
		End if 
	End if 
	If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
		[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=0
		If ([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3<0)
			If (Not:C34(ut_LoadRecord(->[PRJ_DesignContracts:123])))
				Repeat 
					IDLE:C311
					uT_DelayUserProcess
				Until (ut_LoadRecord(->[PRJ_DesignContracts:123]))
				DELETE RECORD:C58([PRJ_DesignContracts:123])
			End if 
			
			If ([PRJ_ProjectFile:117]PF_FileNumber_l:3<0)
				DELETE RECORD:C58([PRJ_ProjectFile:117])
			End if 
			
			
		Else 
			[PRJ_ProjectFile:117]DC_OLDDesignContractID_l:2:=0
			[PRJ_ProjectFile:117]PF_OLDConsultantOverideID_l:15:=0
			SAVE RECORD:C53([PRJ_ProjectFile:117])
			UNLOAD RECORD:C212([PRJ_ProjectFile:117])
		End if 
	End if 
	SAVE RECORD:C53([PRJ_ProjectDetails:115])
	NEXT RECORD:C51([PRJ_ProjectDetails:115])
	
	
End for 
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
//End ut_PRJUpgradeProjectDetail