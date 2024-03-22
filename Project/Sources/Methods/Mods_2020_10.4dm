//%attributes = {"invisible":true}
//Method: Mods_2020_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 10/01/20, 13:13:39
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10
End if 
//
//Replace [PRJ_ProjectDetails];"BridgeProgram" with Listbox [PRJ_ProjectDetails];"BridgeProgram_LB"
//PRJ_DisplayBridgePgm
// [PRJ_ProjectDetails];"BridgeProgram_LB"
//PRJ_SetupListBoxDisplayEvent
//PRJ_SetUpArraysForList
//Method: [PRJ_ProjectDetails].BridgeProgram_LB.InspectorsOut_LB
//PRJ_BPGM_ShowAll 
//PRJ_BPGM_ShowSubset 
//Method: [PRJ_ProjectDetails].BridgeProgram_LB.bOmitSubset
//PRJ_BPGM_Search
//PRJ_BPGM_OrderBy
//PRJ_BPGM_CustomSearch
//LB_BridgeProgramSort

Mods_2020_10  // //Fix sort direction issue where pointer was not set correctly
//Modified by: CJ (10/8/20 14:28:27)  
//LSS_SortStructureType
//LB_ProcessINSPQuery2 
//LB_ProcessCondUnitsQuery 
//LB_ListContracts 
//LB_DCMContractMaintenance 
//LB_CSLT_Rating 
//LB_CSLT_Inspection 
//LB_ContractMaintenance 
//LB_ConsAddressMatch 


//End Mods_2020_10