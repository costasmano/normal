//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_FillDCForDisplay
// User name (OS): charlesmiller
// Date and time: 04/29/09, 11:52:10
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/29/09, 11:52:11 `PRJ Design Contract Changes
End if 
PRJ_DCDescription_txt:=[PRJ_DesignContracts:123]DC_Description_txt:4
PRJ_DCContrFederalAidNos_s:=[PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15
PRJ_DCActualAmount_s:=String:C10([PRJ_DesignContracts:123]DC_ActualAmount_r:6; "###,###,###.00")
PRJ_DCCompletion_d:=[PRJ_DesignContracts:123]DC_Completion_d:8
PRJ_DCEstComplete_d:=[PRJ_DesignContracts:123]DC_EstComplete_d:11
PRJ_DCProjectInfoAmount_r:=String:C10([PRJ_DesignContracts:123]DC_ProjectInfoAmount_r:5; "###,###,###.00")
PRJ_DCRemainingAmount_r:=String:C10([PRJ_DesignContracts:123]DC_RemainingAmount_r:7; "###,###,###.00")
C_LONGINT:C283($ConsultantIDToUse_l)
PRJ_SetConsultantToUse(->$ConsultantIDToUse_l)
$0:=$ConsultantIDToUse_l

//End PRJ_FillDCForDisplay
