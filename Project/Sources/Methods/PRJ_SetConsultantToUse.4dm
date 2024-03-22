//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetConsultantToUse
// User name (OS): charlesmiller
// Date and time: 04/29/09, 17:21:18
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/29/09, 17:21:19 `PRJ Design Contract Changes
	Mods_2009_06  //r002 `06/11/09, 14:57:11   `Merge PRJ Design Contract Changes
End if 
C_POINTER:C301($1; $ConsultantToUse_ptr)
C_LONGINT:C283($ConsultantIDToUse_l)
$ConsultantToUse_ptr:=$1
If (Records in selection:C76([PRJ_DesignContracts:123])=1)
	Case of 
		: ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
			$ConsultantIDToUse_l:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
		: ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#[PRJ_DesignContracts:123]ConsultantNameID_l:2) & ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#0)
			$ConsultantIDToUse_l:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
		: ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#0)
			$ConsultantIDToUse_l:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
		: ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54#0)
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
			$ConsultantIDToUse_l:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
		Else 
			$ConsultantIDToUse_l:=[PRJ_DesignContracts:123]ConsultantNameID_l:2
	End case 
Else 
	Case of 
		: ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
			$ConsultantIDToUse_l:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
		: ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#0)
			$ConsultantIDToUse_l:=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53
			
		Else 
			$ConsultantIDToUse_l:=-99999
	End case 
End if 
$ConsultantToUse_ptr->:=$ConsultantIDToUse_l
//End PRJ_SetConsultantToUse
