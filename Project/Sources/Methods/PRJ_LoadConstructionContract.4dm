//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadConstructionContract
// User name (OS): cjmiller
// Date and time: 04/28/06, 16:22:44
// ----------------------------------------------------
// Description
//This method loads [ConstructionProject] record for a project detail record
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //11/16/06, 16:04:37`add contractor to summary page
	// Modified by: ManousakisC (6/15/2007)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v5310  //Add display of new retrieved dates
	Mods_2007_CJM_v5310  //06/28/07 `Make sure amounts display blank
	// Modified by: costasmanousakis-(Designer)-(9/26/2007 12:32:08)
	Mods_2007_CM12_5301  //added completion date
End if 

RELATE ONE:C42([PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2; [PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)
If (Records in selection:C76([PRJ_ConstructionProject:116])=1)
	PRJ_ContractNumber_s:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
	If ([PRJ_ConstructionProject:116]CP_LowBid_r:7#0)
		PRJ_LowBid_txt:=String:C10(Round:C94([PRJ_ConstructionProject:116]CP_LowBid_r:7; 2); "$###,###,###,##0.00")
	End if 
	PRJ_BidOpeningDate_s:=String:C10([PRJ_ConstructionProject:116]CP_BidOpening_d:3; 7)
	PRJ_AwardDate_s:=String:C10([PRJ_ConstructionProject:116]CP_Awarded_d:4; 7)
	PRJ_NTPDate_s:=String:C10([PRJ_ConstructionProject:116]CP_NTP_d:12; 7)
	PRJ_CPComplDate_s:=String:C10([PRJ_ConstructionProject:116]CP_Completion_d:8; 7)
	If ([PRJ_ConstructionProject:116]CP_BidEstimate_r:6#0)
		PRJ_EstimatedBid_txt:=String:C10(Round:C94([PRJ_ConstructionProject:116]CP_BidEstimate_r:6; 2); "$###,###,###,##0.00")
	End if 
	If ([PRJ_ConstructionProject:116]CP_SpecsToPrint_d:14#!00-00-00!)
		PRJ_SpecsToPrintDate_s:=String:C10([PRJ_ConstructionProject:116]CP_SpecsToPrint_d:14; 7)
	End if 
	If ([PRJ_ConstructionProject:116]CP_SpecsFromPrint_d:15#!00-00-00!)
		PRJ_SpecsFromPrintDate_s:=String:C10([PRJ_ConstructionProject:116]CP_SpecsFromPrint_d:15; 7)
	End if 
	If ([PRJ_ConstructionProject:116]CP_PlansToPrint_d:16#!00-00-00!)
		PRJ_PlansToPrintDate_s:=String:C10([PRJ_ConstructionProject:116]CP_PlansToPrint_d:16; 7)
	End if 
	If ([PRJ_ConstructionProject:116]CP_PlansFromPrint_d:17#!00-00-00!)
		PRJ_PlansFromPrintDate_s:=String:C10([PRJ_ConstructionProject:116]CP_PlansFromPrint_d:17; 7)
	End if 
	If ([PRJ_ConstructionProject:116]CP_ToCashier_d:18#!00-00-00!)
		PRJ_ToCashierDate_s:=String:C10([PRJ_ConstructionProject:116]CP_ToCashier_d:18; 7)
	End if 
	
	If ([PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31="")
		[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31:=PRJ_RetrievedConstructionEWO_S
	End if 
	RELATE ONE:C42([PRJ_ConstructionProject:116]CTR_ContractorID_l:2; [PRJ_Contractor:114]CTR_ContractorID_l:1)
End if 
//End PRJ_LoadConstructionContract