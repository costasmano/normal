//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetFormVariableToEmpty
// User name (OS): cjmiller
// Date and time: 05/03/06, 14:32:42
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //12/14/06, 16:44:37`Add proj mgr drop down
	Mods_2007_CJM_v5310  //Add display of new retrieved dates
	Mods_2007_CJM_v5310  //06/28/07 `Make sure amounts display blank
	// Modified by: costasmanousakis-(Designer)-(9/26/2007 12:30:58)
	Mods_2007_CM12_5301  //added constr compl date
	Mods_2007_CJM_v54  //r003 `11/27/07, 15:36:12`Add NBI Non NBI variable to sumary page
End if 
PRJ_RoadwayOver_txt:=""
PRJ_DEBin_s:=""
PRJ_DEBridgeNo_s:=""
PRJ_Posting_s:=""
PRJ_InspectionDate_s:=""
PRJ_OnSystemBridge_s:=""
PRJ_Item37_s:=""
PRJ_ADT_l:=0
PRJ_AASHTO_r:=0
PRJ_StructurallyDeficient_s:=""
PRJ_Owner_s:=""
PRJ_FWHASelect_s:=""
DC_ConsultantName_txt:=""
PRJ_RoadwayOver_txt:=""
PRJ_LastAction_txt:=""
PRJ_OnSystemBridge_s:=""
PRJ_Item37_s:=""
PRJ_Owner_s:=""
PRJ_ActualAdvertisedDate_s:=""
PRJ_ContractNumber_s:=""
PRJ_EstimatedBid_txt:=""
PRJ_RatingReceivedDate_s:=""
PRJ_Material_s:=""
PRJ_DeckArea_s:=""
PRJ_BidOpeningDate_s:=""
PRJ_LowBid_txt:=""
PRJ_InspectionDate_s:=""
PRJ_RatingApprovedDate_s:=""
PRJ_RetrievedConstructionEWO_S:=""
PRJ_ProjectReviewLast_txt:=""
PRJ_SketchPlanLast_txt:=""
PRJ_TypeStudyLast_txt:=""
PRJ_ReportLast_txt:=""
PRJ_DeckAreaUnits_s:=""
PRJ_BeamUnitCost_s:=""
PRJ_PrjMgrHistory_txt:=""
PRJ_AwardDate_s:=""
PRJ_NTPDate_s:=""
PRJ_CPComplDate_s:=""
PRJ_SpecsToPrintDate_s:=""
PRJ_SpecsFromPrintDate_s:=""
PRJ_PlansToPrintDate_s:=""
PRJ_PlansFromPrintDate_s:=""
PRJ_ToCashierDate_s:=""
PRJ_NBINonNBI_s:=""

//End PRJ_SetFormVariableToEmpty