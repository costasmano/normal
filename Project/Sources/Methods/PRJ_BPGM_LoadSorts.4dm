//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/05/07, 12:24:30
	// ----------------------------------------------------
	// Method: PRJ_BPGM_LoadSorts
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(6/14/2007 08:50:11)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(5/21/10 12:11:41)
	Mods_2010_05
	//  `Replaced [PRJ_ProjectFile]PF_Advertised_d with PRJ_BPGMAdDate_aD
End if 
C_LONGINT:C283(PRJ_BPGM_NumSort_L)
PRJ_BPGM_NumSort_L:=17
ARRAY POINTER:C280(PRJ_BPGM_Sorts_aptr; PRJ_BPGM_NumSort_L)
PRJ_BPGM_Sorts_aptr{1}:=->[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
PRJ_BPGM_Sorts_aptr{2}:=->[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8
PRJ_BPGM_Sorts_aptr{3}:=->PRJ_RWYOver_atxt
PRJ_BPGM_Sorts_aptr{4}:=->PRJ_RWYUnder_atxt
PRJ_BPGM_Sorts_aptr{5}:=->PRJ_ConsName_atxt
PRJ_BPGM_Sorts_aptr{6}:=->[PRJ_ProjectDetails:115]PRJ_Program_s:23
PRJ_BPGM_Sorts_aptr{7}:=->[PRJ_ProjectDetails:115]PRJ_NTP_d:24
//PRJ_BPGM_Sorts_aptr{8}:=->[PRJ_ProjectFile]PF_Advertised_d
PRJ_BPGM_Sorts_aptr{8}:=->PRJ_BPGMAdDate_aD
PRJ_BPGM_Sorts_aptr{9}:=->[PRJ_ProjectFile:117]PF_BidOpened_d:12
PRJ_BPGM_Sorts_aptr{10}:=->PRJ_UnderConstr_aS
PRJ_BPGM_Sorts_aptr{11}:=->PRJ_DistrNo_aS
PRJ_BPGM_Sorts_aptr{12}:=->[PRJ_Contractor:114]CTR_CompanyName_s:2
PRJ_BPGM_Sorts_aptr{13}:=->[PRJ_ConstructionProject:116]CP_Awarded_d:4
PRJ_BPGM_Sorts_aptr{14}:=->[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
PRJ_BPGM_Sorts_aptr{15}:=->[PRJ_ConstructionProject:116]CP_Completion_d:8
PRJ_BPGM_Sorts_aptr{16}:=->[PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22
PRJ_BPGM_Sorts_aptr{17}:=->PRJ_InitInsp_aD
