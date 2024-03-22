//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/01/07, 19:08:25
	// ----------------------------------------------------
	// Method: PRJ_ProjUpdPrepRow
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM10a
	Mods_2009_05  //r001  `05/08/09, 14:26:24  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//[PRJ_ProjectFile]DC_DesignContractID_l to [PRJ_ProjectDetails]DC_DesignContractID_l
	Mods_2009_06  //r002 `06/11/09, 13:46:43   `Merge PRJ Design Contract Changes
End if 

QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
PRJ_LoadPage_0
C_TEXT:C284(PRJ_ProjExpeditorShort_txt; XMLRowMod_txt)
PRJ_RoadwayOver_txt:=Replace string:C233(PRJ_RoadwayOver_txt; "  "; "")
PRJ_ProjExpeditorShort_txt:=Substring:C12([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; 1; (Position:C15(":"; [PRJ_ProjectFile:117]PF_ProjectExpediter_s:6)-1))
PRJ_ProjExpeditorShort_txt:=PRJ_ProjExpeditorShort_txt+Substring:C12([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; (Length:C16([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6)-3))
If ([PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43#"")
	PRJ_PrintEWO_txt:=[PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43
Else 
	PRJ_PrintEWO_txt:=[PRJ_ProjectFile:117]PF_EWO_s:4
End if 

XMLRowMod_txt:=Replace string:C233(XMLRowTxt_txt; "[Ad_date]"; FN_Date2DateTime([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5))
XMLRowMod_txt:=Replace string:C233(XMLRowTxt_txt; "[Ad_date]"; FN_Date2DateTime)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[ProjRow]"; ("Project Page "+String:C10([PRJ_ProjectDetails:115]PRJ_MeetingPageNo_l:45)+" of Page "+PRJ_ProjisTotalPgs_s))
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[Town]"; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[StrPrjMgr]"; PRJ_StructPrjMgr_txt)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[Roadway]"; PRJ_RoadwayOver_txt)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[BridgeNo]"; PRJ_DEBridgeNo_s)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[Designer]"; PRJ_ConsultantName_txt)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[PRJ_ProjExpeditorShort_txt]"; PRJ_ProjExpeditorShort_txt)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[PFileNo]"; String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3))
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[EWO]"; PRJ_PrintEWO_txt)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[PRJ_StructurallyDeficient_s]"; PRJ_StructurallyDeficient_s)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[Cost]"; String:C10([PRJ_ProjectFile:117]PF_EstTotalCost_r:10))
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[Onsystem]"; PRJ_OnSystemBridge_s)
XMLRowMod_txt:=Replace string:C233(XMLRowMod_txt; "[LastAction]"; [PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9)
