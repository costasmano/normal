//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/15/13, 11:26:29
//----------------------------------------------------
//Method: ut_ResetIndexes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_08  //r001 ` 
	//Modified by: Charles Miller (8/15/13 11:26:31)
	
End if 
If (False:C215)
	SET INDEX:C344([Personnel:42]First Name:3; True:C214)
	SET INDEX:C344([Personnel:42]Middle Name:4; True:C214)
	SET INDEX:C344([Personnel:42]Last Name:5; True:C214)
	SET INDEX:C344([Personnel:42]Division No:7; True:C214)
	SET INDEX:C344([Personnel:42]Job Code:8; True:C214)
	SET INDEX:C344([Personnel:42]Employer:9; True:C214)
	SET INDEX:C344([Personnel:42]DiveTeam:10; True:C214)
	SET INDEX:C344([Personnel:42]Active:11; True:C214)
	SET INDEX:C344([Personnel:42]UserID_4D:12; True:C214)
	
	SET INDEX:C344([BMS Inspections:44]BIN:2; True:C214)
	SET INDEX:C344([BMS Inspections:44]Insp Date:4; True:C214)
	SET INDEX:C344([BMS Inspections:44]DBrInspEngr:5; True:C214)
	SET INDEX:C344([BMS Inspections:44]TeamLeader:6; True:C214)
	
	
	SET INDEX:C344([Cond Units:45]Inspection ID:2; True:C214)
	SET INDEX:C344([Cond Units:45]Element ID:3; True:C214)
	SET INDEX:C344([Cond Units:45]Environment:4; True:C214)
	SET INDEX:C344([Cond State Insp:46]Cond Unit ID:2; True:C214)
	
	
	SET INDEX:C344([Element Costs:50]Element ID:1; True:C214)
	SET INDEX:C344([Element Costs:50]Action No:3; True:C214)
	SET INDEX:C344([Element Costs:50]Environment:5; True:C214)
	
	SET INDEX:C344([Cond States:51]Category ID:2; True:C214)
	SET INDEX:C344([CS Actions:52]Cond State ID:1; True:C214)
	
	
	SET INDEX:C344([Cat CS Notes:55]Category ID:1; True:C214)
	SET INDEX:C344([Cat CS Notes:55]CS Note ID:2; True:C214)
	SET INDEX:C344([BMS Field Trip:56]Inspection ID:1; True:C214)
	SET INDEX:C344([BMS Field Trip:56]Person ID:2; True:C214)
	SET INDEX:C344([Activity Log:59]Destination:1; True:C214)
	SET INDEX:C344([Activity Log:59]Activity Type:3; True:C214)
	SET INDEX:C344([Activity Log:59]Status:9; True:C214)
	SET INDEX:C344([Activity Log:59]Parent ID:14; True:C214)
	SET INDEX:C344([Activity Log:59]Local ID:15; True:C214)
	SET INDEX:C344([Activity Log:59]FileID Parent:22; True:C214)
	SET INDEX:C344([Activity Log:59]FieldID Parent:23; True:C214)
	SET INDEX:C344([Activity Log:59]FileID Local:24; True:C214)
	
	SET INDEX:C344([FileIDRes Table:60]File Number:1; True:C214)
	SET INDEX:C344([FileIDRes Table:60]Local ID:2; True:C214)
	SET INDEX:C344([FileIDRes Table:60]Destination ID:3; True:C214)
	SET INDEX:C344([FileIDRes Table:60]Destination:4; True:C214)
	SET INDEX:C344([Owners of Data:62]RefID:1; True:C214)
	SET INDEX:C344([Owners of Data:62]Owner Name:2; True:C214)
	SET INDEX:C344([Conslt Rating:63]BIN:1; True:C214)
	
	SET INDEX:C344([Cons Inspection:64]BIN:1; True:C214)
	
	
	SET INDEX:C344([Field Trip:43]InspID:1; True:C214)
	SET INDEX:C344([Field Trip:43]Person ID:2; True:C214)
	SET INDEX:C344([Conslt Rating Cost:74]ConsltRatingID:1; True:C214)
	SET INDEX:C344([Cons Inspection Cost:76]ConsInspectionID:1; True:C214)
	SET INDEX:C344([Conslt Address:77]ConsltName:2; True:C214)
	SET INDEX:C344([Conslt Address:77]ConsultantNameID_l:22; True:C214)
	
	SET INDEX:C344([Town Address:78]TownName:2; True:C214)
	SET INDEX:C344([Contract FundTransfer:80]ContractNo:1; True:C214)
	
	SET INDEX:C344([Contract ExtendTime:81]ContractNo:1; True:C214)
	SET INDEX:C344([Contract AddFund:82]ContractNo:1; True:C214)
	SET INDEX:C344([Contract Invoice:84]ContractNo:3; True:C214)
	SET INDEX:C344([Contract Invoice AssignNo:85]InvoiceID:1; True:C214)
	
	SET INDEX:C344([Templates:86]TemplateName:2; True:C214)
	SET INDEX:C344([ClientAccess:88]CA_MessageStart_s:2; True:C214)
	SET INDEX:C344([ClientAccess:88]CA_LimitAccess_s:3; True:C214)
	SET INDEX:C344([SD_History:89]Bin:1; True:C214)
	SET INDEX:C344([SD_History:89]SD_Year:2; True:C214)
	SET INDEX:C344([SD_History:89]SD_Month:3; True:C214)
	SET INDEX:C344([SD_History:89]SD_DefectAddRemoveStatus_s:16; True:C214)
	SET INDEX:C344([SD_History:89]SD_Owner_s:17; True:C214)
	SET INDEX:C344([SD_History:89]SD_PostedAddRemoveStatus_s:18; True:C214)
	SET INDEX:C344([SD_History:89]SD_PreviousOwner_s:19; True:C214)
	
	
	SET INDEX:C344([Contract Assignments:83]ContractNo:1; True:C214)
	SET INDEX:C344([Combined Inspections:90]NBISInspID:2; True:C214)
	SET INDEX:C344([Combined Inspections:90]BMSInspID:3; True:C214)
	SET INDEX:C344([Combined Inspections:90]InspDate:4; True:C214)
	SET INDEX:C344([Combined Inspections:90]InspType:5; True:C214)
	
	SET INDEX:C344([ACTMODLS:91]MOKEY:1; True:C214)
	SET INDEX:C344([ACTMODLS:91]ELEMKEY:2; True:C214)
	SET INDEX:C344([ACTMODLS:91]SKEY:3; True:C214)
	SET INDEX:C344([ACTMODLS:91]ENVKEY:5; True:C214)
	SET INDEX:C344([ELEMDEFS:92]ELEMKEY:1; True:C214)
	SET INDEX:C344([ELEMDEFS:92]ETYPKEY:3; True:C214)
	SET INDEX:C344([ELEMDEFS:92]MATLKEY:4; True:C214)
	SET INDEX:C344([CONDUMDL:93]MOKEY:1; True:C214)
	SET INDEX:C344([CONDUMDL:93]ELEMKEY:2; True:C214)
	SET INDEX:C344([CONDUMDL:93]ENVKEY:3; True:C214)
	SET INDEX:C344([Invoice_AssignNo_Maintenance:94]InvoiceID:1; True:C214)
	
	SET INDEX:C344([Invoice_Maintenance:95]ContractNo:3; True:C214)
	SET INDEX:C344([FundTransfer_Maintenance:96]ContractNo:1; True:C214)
	SET INDEX:C344([ExtendTime_Maintenance:98]ContractNo:1; True:C214)
	
	
	SET INDEX:C344([AddFund_Maintenance:99]ContractNo:1; True:C214)
	SET INDEX:C344([Contract_Project_Maintenance:100]ContractNo:2; True:C214)
	SET INDEX:C344([Contract_Project_Maintenance:100]BIN:5; True:C214)
	SET INDEX:C344([Contract_Project_Maintenance:100]AssignNo:9; True:C214)
	SET INDEX:C344([Contract_Project_Maintenance:100]AssignID:13; True:C214)
	SET INDEX:C344([Contract_Assignment_Maintenance:101]ContractNo:1; True:C214)
	SET INDEX:C344([Contract_Assignment_Maintenance:101]AssignNo:2; True:C214)
	SET INDEX:C344([Addendum_Maintenance:102]AddendumNo:2; True:C214)
	SET INDEX:C344([Addendum_Maintenance:102]AssignID:3; True:C214)
	SET INDEX:C344([Addendum_Maintenance:102]AssignNo:4; True:C214)
	
	SET INDEX:C344([Work_Estimate:103]AssignID:2; True:C214)
	SET INDEX:C344([WorkHour_Config:104]AssignType:2; True:C214)
	SET INDEX:C344([WorkHour_Summary:105]ProjType:1; True:C214)
	SET INDEX:C344([WorkHour_Summary:105]ItemID:2; True:C214)
	SET INDEX:C344([zSpecialReports:106]Purpose:1; True:C214)
	SET INDEX:C344([zSpecialReports:106]Record_ID:7; True:C214)
	
	SET INDEX:C344([ScourPriorityRank:108]BIN:1; True:C214)
	SET INDEX:C344([ScourPriorityRank:108]LifeTimeRisk:4; True:C214)
	SET INDEX:C344([ScourPriorityRank:108]Category:5; True:C214)
	
	SET INDEX:C344([PERS_GroupMembers:110]GroupID_I:1; True:C214)
	SET INDEX:C344([PERS_GroupMembers:110]PersonID_I:2; True:C214)
	SET INDEX:C344([CM_ExtTimeFYAlloc:111]EOT_ID_L:2; True:C214)
	
	
	SET INDEX:C344([PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2; True:C214)
	SET INDEX:C344([PRJ_ProjectDetails:115]PF_FileID_l:3; True:C214)
	SET INDEX:C344([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; True:C214)
	SET INDEX:C344([PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; True:C214)
	SET INDEX:C344([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; True:C214)
	SET INDEX:C344([PRJ_ProjectDetails:115]DC_DesignContractID_l:54; True:C214)
	
	SET INDEX:C344([PRJ_ConstructionProject:116]CTR_ContractorID_l:2; True:C214)
	SET INDEX:C344([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; True:C214)
	SET INDEX:C344([PRJ_ConstructionProject:116]PF_FileID_l:11; True:C214)
	
	SET INDEX:C344([PRJ_ReportData:118]PRJ_ProjectID_l:1; True:C214)
	SET INDEX:C344([PRJ_StructuralReview:119]PRJ_ProjectID_l:1; True:C214)
	SET INDEX:C344([PRJ_StructuralReview:119]RV_ReviewID_l:2; True:C214)
	SET INDEX:C344([PRJ_SketchPlans:120]PRJ_ProjectID_l:1; True:C214)
	SET INDEX:C344([PRJ_SketchPlans:120]RV_ReviewID_l:2; True:C214)
	SET INDEX:C344([PRJ_TypeStudy:121]PRJ_ProjectID_l:1; True:C214)
	SET INDEX:C344([PRJ_TypeStudy:121]RV_ReviewID_l:2; True:C214)
	SET INDEX:C344([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; True:C214)
	SET INDEX:C344([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; True:C214)
	
	
	SET INDEX:C344([PRJ_DesignContracts:123]ConsultantNameID_l:2; True:C214)
	SET INDEX:C344([PRJ_DesignContracts:123]DC_SQLContractID_l:17; True:C214)
	
	SET INDEX:C344([PRJ_ProjectTimeTracking:124]PRJ_ProjectID_l:2; True:C214)
	SET INDEX:C344([TableOfLists:125]ListName_s:1; True:C214)
	SET INDEX:C344([TableOfLists:125]ListValue_s:2; True:C214)
	SET INDEX:C344([TableOfLists:125]ListKeyID_L:4; True:C214)
	
	SET INDEX:C344([Conslt_Name:127]SQL_VendorID_l:3; True:C214)
	SET INDEX:C344([PRJ_StrPrjManagerHistory:128]PRJ_ProjectID_l:1; True:C214)
	SET INDEX:C344([Scour Report:129]ReportDate:1; True:C214)
	
	SET INDEX:C344([PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; True:C214)
	SET INDEX:C344([PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2; True:C214)
	SET INDEX:C344([ScourPOA:132]BIN:2; True:C214)
	
End if 

SET INDEX:C344([ScourPOA_DetourBridge:133]ScourPOAID:2; True:C214)

SET INDEX:C344([ScourPOA_Images:134]ScourPOAID:2; True:C214)
SET INDEX:C344([PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1; True:C214)
SET INDEX:C344([PRJ_DCPFJoin:135]DC_DesignProjectID_l:2; True:C214)
SET INDEX:C344([PRJ_DCPFJoin:135]PF_FileID_l:3; True:C214)

SET INDEX:C344([DCM_WorkOrders:137]ContractNo:1; True:C214)
SET INDEX:C344([DCM_WorkOrders:137]AssignNo:2; True:C214)

SET INDEX:C344([DCM_WorkOrders:137]ProjectIS:4; True:C214)

SET INDEX:C344([DCM_Project:138]ContractNo:2; True:C214)
SET INDEX:C344([DCM_Project:138]BIN:5; True:C214)
SET INDEX:C344([DCM_Project:138]AssignNo:9; True:C214)
SET INDEX:C344([DCM_Project:138]AssignID:13; True:C214)
SET INDEX:C344([BridgeMHDNBISArchive:139]BIN:3; True:C214)
SET INDEX:C344([BridgeMHDNBISArchive:139]FHWARecord:173; True:C214)
SET INDEX:C344([BridgeMHDNBISArchive:139]ArchiveReason_s:223; True:C214)
SET INDEX:C344([BridgeMHDNBISArchive:139]ArchiveDate_d:224; True:C214)
SET INDEX:C344([NBISSecondaryArchive:140]BIN:1; True:C214)
SET INDEX:C344([NBISSecondaryArchive:140]ArchiveReason_s:39; True:C214)
SET INDEX:C344([NBISSecondaryArchive:140]ArchiveDate_d:40; True:C214)
SET INDEX:C344([NBISSecondaryArchive:140]NBISSecondaryKey_l:41; True:C214)
SET INDEX:C344([PRJ_ProjectTypes:141]PRTP_TypeCode_s:1; True:C214)
SET INDEX:C344([DCM_ProjDailyHrs:142]DailyIItemD_L:1; True:C214)
SET INDEX:C344([DCM_ProjDailys:143]ProjectID:1; True:C214)
SET INDEX:C344([DCM_ProjDailyItems:144]DailyID_L:1; True:C214)

SET INDEX:C344([DCM_ProjDailyItems:144]ItemNo_s:3; True:C214)

SET INDEX:C344([LB_QueryTable:147]QueryName_s:1; True:C214)
SET INDEX:C344([LB_QueryTable:147]UniqueKey_l:6; True:C214)

SET INDEX:C344([BridgeInfoLink:149]BIN:1; True:C214)
SET INDEX:C344([BridgeInfoLink:149]ScourPriorityRankInfoLink_s:2; True:C214)
SET INDEX:C344([BridgeInfoLink:149]RailInfoLink_s:3; True:C214)
SET INDEX:C344([BridgeInfoLink:149]ScourCriticalInfoLink_s:5; True:C214)
SET INDEX:C344([ScourCriticalInfo:150]BIN:1; True:C214)

//End ut_ResetInices


