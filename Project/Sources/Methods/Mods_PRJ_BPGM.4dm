//%attributes = {"invisible":true}
If (False:C215)
	
	//PRJ_BPGM_AdjustSortArrays 
	//PRJ_BPGM_CleanSearchVars 
	//PRJ_BPGM_ClearOtherSrch 
	//PRJ_BPGM_CreateSearchSet 
	//PRJ_BPGM_CustomSearch 
	//PRJ_BPGM_DoSort 
	//PRJ_BPGM_InitDispArrays 
	//PRJ_BPGM_ListDetailData 
	//PRJ_BPGM_LoadArrays 
	//PRJ_BPGM_LoadSorts 
	//PRJ_BPGM_OrderBy 
	//PRJ_BPGM_PrintSelection 
	//PRJ_BPGM_QuickRpt 
	//PRJ_BPGM_Search 
	//PRJ_BPGM_SearchVar_OM 
	//PRJ_BPGM_ShowAll 
	//PRJ_BPGM_ShowSubset 
	//PRJ_BPGM_WinTitle 
	//
	//PRJ_BPGM_ListFromBINs 
	//PRJ_BPGM_RelateToBINs 
	//
	//  ` Modified Forms : 
	//DIALOG([Bridge MHD NBIS];"NBIS Stack Info")
	//  `added hidden button AltCtrl-P to get the list of projects related to current bins
	//
	//  ` Modified Field(s) : 
	//[PRJ_ProjectDetailsIncludedBINS]PDB_BIN_s
	//  `indexed field 
	//
	//  `Picture lib
	//  `Added icon  XP Query
	//
	//DIALOG([PRJ_ProjectDetails];"BridgeProgram")
	//
	//DIALOG([Dialogs];"PRJ_BPGM_Search")
	//
	//PRJ_DC_OpenProjectDetail 
	//
	//M_ListBridgeProgram 
	//PRJ_DisplayBridgePgm 
	//
	//PRJ_BPGM_RelateToBINs 
	//MENU BAR("BridgeListMenu")  `Reports menu - Bridge Program
	
	//G_SortTable_new
End if 
