//%attributes = {"invisible":true}
// Method: ut_ScanSequences
// Description
// Scan all sequences...
//  `Use method ut_CheckMissingSeqScans - to check for sequences not in here
//  `First copy this method to clipboard, then run ut_CheckMissingSeqScans,
//  `When ignoring sequences in here , include the "" - see ex below : "Element Dictionary"
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/21/07, 12:15:28
	// ----------------------------------------------------
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(3/12/10 15:32:24)
	Mods_2010_03
	//  `Added messages on what is happening...
	// Modified by: Costas Manousakis-(Designer)-(9/26/13 12:30:18)
	Mods_2013_09
	//  `Added new sequences from preservation module
	// Modified by: Costas Manousakis-(Designer)-(5/23/14 16:43:13)
	Mods_2014_05
	//  `Added missing sequences using ut_CheckMissingSeqScans
	// Modified by: Costas Manousakis-(Designer)-(1/6/17 17:03:26)
	Mods_2017_01
	//  `verified and ammended using ut_CheckMissingSeqScans
	// Modified by: Costas Manousakis-(Designer)-(9/5/18 10:18:44)
	Mods_2018_09_bug
	//  `added TIN inspection tables
	// Modified by: Costas Manousakis-(Designer)-(9/11/18 12:30:39)
	Mods_2018_09_bug
	//  `code copied from result of DEV_FindSequences inserted and corrected as needed
	
	// Modified by: Costas Manousakis-(Designer)-(2021-12-13T00:00:00 18:18:54)
	Mods_2021_12_bug
	//  `added two missing tables Ratingreportvehicles and Bridgestairs
	// Modified by: Costas Manousakis-(Designer)-(2022-03-16T00:00:00 14:56:37)
	Mods_2022_03
	//  `added ut_FixBINSequence
End if 

SHORT_MESSAGE("Scanning Sequence Table ...")

MESSAGE:C88(Char:C90(13)+"[NBIS Secondary] ...")
ut_FixSequence("[NBIS Secondary]"; ->[NBIS Secondary:3]NBISSecondaryKey_l:39)
MESSAGE:C88(Char:C90(13)+"Activity Log ...")
ut_FixSequence("Activity Log"; ->[Activity Log:59]RefID:28)
MESSAGE:C88(Char:C90(13)+"AddendumMaint ...")
ut_FixSequence("AddendumMaint"; ->[Addendum_Maintenance:102]AddendumID:1)
MESSAGE:C88(Char:C90(13)+"AddFund ...")
ut_FixSequence("AddFund"; ->[Contract AddFund:82]AddFund_ID:2)
MESSAGE:C88(Char:C90(13)+"AddFundMaint ...")
ut_FixSequence("AddFundMaint"; ->[AddFund_Maintenance:99]AddFund_ID:2)
MESSAGE:C88(Char:C90(13)+"AssignMaint ...")
ut_FixSequence("AssignMaint"; ->[Contract_Assignment_Maintenance:101]AssignID:3)
MESSAGE:C88(Char:C90(13)+"BrDesign ...")
ut_FixSequence("BrDesign"; ->[Bridge Design:75]BridgeDesignID:35)
MESSAGE:C88(Char:C90(13)+"CombinedInspections ...")
ut_FixSequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
MESSAGE:C88(Char:C90(13)+"ConAssignments ...")
ut_FixSequence("ConAssignments"; ->[Contract Assignments:83]AssignID:3)
MESSAGE:C88(Char:C90(13)+"Cond Unit ID ...")
ut_FixSequence("Cond Unit ID"; ->[Cond Units:45]Cond Unit ID:1)
MESSAGE:C88(Char:C90(13)+"ConInvoice ...")
ut_FixSequence("ConInvoice"; ->[Contract Invoice:84]InvoiceID:1)
MESSAGE:C88(Char:C90(13)+"ConsAddress ...")
ut_FixSequence("ConsAddress"; ->[Conslt Address:77]ConsltAddressID:1)
MESSAGE:C88(Char:C90(13)+"ConsInsp ...")
ut_FixSequence("ConsInsp"; ->[Cons Inspection:64]ConsInspectionID:32)
MESSAGE:C88(Char:C90(13)+"ConsRtg ...")
ut_FixSequence("ConsRtg"; ->[Conslt Rating:63]ConsltRatingID:42)
MESSAGE:C88(Char:C90(13)+"ConsultantNameID_l ...")
ut_FixSequence("ConsultantNameID_l"; ->[Conslt_Name:127]ConsultantNameID_l:1)
MESSAGE:C88(Char:C90(13)+"Contract ...")
ut_FixSequence("Contract"; ->[Contracts:79]ContractID:29)
MESSAGE:C88(Char:C90(13)+"ContractMaint ...")
ut_FixSequence("ContractMaint"; ->[Contract_Maintenance:97]ContractID:2)
MESSAGE:C88(Char:C90(13)+"CP_ConstructionProj ...")
ut_FixSequence("CP_ConstructionProj"; ->[PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)
MESSAGE:C88(Char:C90(13)+"DC_DesignProjectID_l ...")
ut_FixSequence("DC_DesignProjectID_l"; ->[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
MESSAGE:C88(Char:C90(13)+"DCMAssignMaint ...")  // new
ut_FixSequence("DCMAssignMaint"; ->[DCM_WorkOrders:137]AssignID:3)
MESSAGE:C88(Char:C90(13)+"DCMContractMaint ...")  // new
ut_FixSequence("DCMContractMaint"; ->[DCM_Contracts:136]ContractID:2)
MESSAGE:C88(Char:C90(13)+"DCMProjMaint ...")  // new
ut_FixSequence("DCMProjMaint"; ->[DCM_Project:138]ProjectID:1)
//"Element Dictionary" not used any place ?
MESSAGE:C88(Char:C90(13)+"ElementsSafety ...")
ut_FixSequence("ElementsSafety"; ->[ElementsSafety:29]ElmSafetyID:7)
//"ExtraElements" not used any place ?
MESSAGE:C88(Char:C90(13)+"ExtTime ...")
ut_FixSequence("ExtTime"; ->[Contract ExtendTime:81]EOT_ID:2)
MESSAGE:C88(Char:C90(13)+"ExtTimeMaint ...")
ut_FixSequence("ExtTimeMaint"; ->[ExtendTime_Maintenance:98]EOT_ID:2)
MESSAGE:C88(Char:C90(13)+"ExtTimeMntFYAlloc ...")
ut_FixSequence("ExtTimeMntFYAlloc"; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1)
MESSAGE:C88(Char:C90(13)+"FundTransfer ...")
ut_FixSequence("FundTransfer"; ->[Contract FundTransfer:80]TOF_ID:2)
MESSAGE:C88(Char:C90(13)+"FundTransMaint ...")
ut_FixSequence("FundTransMaint"; ->[FundTransfer_Maintenance:96]TOF_ID:2)
//IDLargeSignStructures not used any place ?
MESSAGE:C88(Char:C90(13)+"Inspections ...")
ut_FixSequence("Inspections"; ->[Inspections:27]InspID:2)
MESSAGE:C88(Char:C90(13)+"InventoryPhoto ...")
ut_FixSequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)
MESSAGE:C88(Char:C90(13)+"InventoryPhotoInsp ...")
ut_FixSequence("InventoryPhotoInsp"; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
MESSAGE:C88(Char:C90(13)+"InvoiceMaint ...")
ut_FixSequence("InvoiceMaint"; ->[Invoice_Maintenance:95]InvoiceID:1)
MESSAGE:C88(Char:C90(13)+"LB_QueryTable ...")  //new
ut_FixSequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
MESSAGE:C88(Char:C90(13)+"MaintInvoiceAssign ...")
ut_FixSequence("MaintInvoiceAssign"; ->[Invoice_AssignNo_Maintenance:94]ID:6)
//"OH_InspectionID" not used any place ?
MESSAGE:C88(Char:C90(13)+"Personnel ...")
ut_FixSequence("Personnel"; ->[Personnel:42]Person ID:1)
MESSAGE:C88(Char:C90(13)+"PersUserGroups ...")
ut_FixSequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
MESSAGE:C88(Char:C90(13)+"PF_FileID_l ...")
ut_FixSequence("PF_FileID_l"; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
MESSAGE:C88(Char:C90(13)+"PM_RunKey_l ...")  //new
ut_FixSequence("PM_RunKey_l"; ->[Pontis_Metrics:41]PM_RunKey_l:1)
MESSAGE:C88(Char:C90(13)+"Pontis Insp ID ...")
ut_FixSequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
MESSAGE:C88(Char:C90(13)+"PRJ_ProjectID_l ...")
ut_FixSequence("PRJ_ProjectID_l"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
MESSAGE:C88(Char:C90(13)+"PRJ_TimeSheetEntry ...")
ut_FixSequence("PRJ_TimeSheetEntry"; ->[PRJ_ProjectTimeTracking:124]PT_TimeTrackingID_l:1)
MESSAGE:C88(Char:C90(13)+"ProjMaint ...")
ut_FixSequence("ProjMaint"; ->[Contract_Project_Maintenance:100]ProjectID:1)
MESSAGE:C88(Char:C90(13)+"RatingReports ...")
ut_FixSequence("RatingReports"; ->[RatingReports:65]RatingID:21)
MESSAGE:C88(Char:C90(13)+"ScourPOA ...")  // new
ut_FixSequence("ScourPOA"; ->[ScourPOA:132]ScourPOAID:1)
MESSAGE:C88(Char:C90(13)+"ScourPOA_DetourBridge ...")  // new
ut_FixSequence("ScourPOA_DetourBridge"; ->[ScourPOA_DetourBridge:133]DetourBridgeID_L:1)
MESSAGE:C88(Char:C90(13)+"ScourPOA_Images ...")  // new
ut_FixSequence("ScourPOA_Images"; ->[ScourPOA_Images:134]ScourPOAImgID:1)
MESSAGE:C88(Char:C90(13)+"SpecialRptsTbl ...")
ut_FixSequence("SpecialRptsTbl"; ->[zSpecialReports:106]Record_ID:7)
MESSAGE:C88(Char:C90(13)+"StandardPhotos ...")
ut_FixSequence("StandardPhotos"; ->[Standard Photos:36]StdPhotoID:7)
MESSAGE:C88(Char:C90(13)+"TableOfLists ...")  // new
ut_FixSequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
MESSAGE:C88(Char:C90(13)+"TemplateInc ...")
ut_FixSequence("TemplateInc"; ->[Templates:86]TemplateID:1)
MESSAGE:C88(Char:C90(13)+"TownAddress ...")
ut_FixSequence("TownAddress"; ->[Town Address:78]TownAddressID:1)
MESSAGE:C88(Char:C90(13)+"TownLine ...")
ut_FixSequence("TownLine"; ->[TownLineInfo:73]RefID:3)
MESSAGE:C88(Char:C90(13)+"TunnelInspection ...")  //new
ut_FixSequence("TunnelInspection"; ->[TunnelInspection:152]TunnelInspID_L:15)
MESSAGE:C88(Char:C90(13)+"WorkHrEstimate ...")
ut_FixSequence("WorkHrEstimate"; ->[Work_Estimate:103]WKID:1)
MESSAGE:C88(Char:C90(13)+"PreservReview ...")
ut_FixSequence("PreservReview"; ->[Preservation_Reviews:145]Review_ID:1)
MESSAGE:C88(Char:C90(13)+"ProjMaint ...")
ut_FixSequence("ProjMaint"; ->[Contract_Project_Maintenance:100]ProjectID:1)
MESSAGE:C88(Char:C90(13)+"PreservMtgs ...")
ut_FixSequence("PreservMtgs"; ->[Preservation_Meetings:148]MeetingID_L:1)
MESSAGE:C88(Char:C90(13)+"InvoiceMaint ...")
ut_FixSequence("InvoiceMaint"; ->[Invoice_Maintenance:95]InvoiceID:1)
MESSAGE:C88(Char:C90(13)+"LB_QueryTable ...")
ut_FixSequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
MESSAGE:C88(Char:C90(13)+"AssignMaint ...")
ut_FixSequence("AssignMaint"; ->[Contract_Assignment_Maintenance:101]AssignID:3)
MESSAGE:C88(Char:C90(13)+"AddendumMaint ...")
ut_FixSequence("AddendumMaint"; ->[Addendum_Maintenance:102]AddendumID:1)

MESSAGE:C88(Char:C90(13)+"RatingRequest ...")
ut_FixSequence("RatingRequest"; ->[RatingRequests:154]RatingRequestID_L:2)
MESSAGE:C88(Char:C90(13)+"AddRatingRequest ...")
ut_FixSequence("AddRatingRequest"; ->[AddtlRatingRequests:155]AddtlRequestID_L:2)
MESSAGE:C88(Char:C90(13)+"BridgeRankCalc ...")
ut_FixSequence("BridgeRankCalc"; ->[BridgeRankCalc:156]RunID_L:1)
MESSAGE:C88(Char:C90(13)+"ElmtRatingLoads ...")
ut_FixSequence("ElmtRatingLoads"; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)
// "TunnelInspections" is a bad sequence - coding error has been fixed
MESSAGE:C88(Char:C90(13)+"PON_ELEM_INSP ...")
ut_FixSequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)

MESSAGE:C88(Char:C90(13)+"NTI_ELEM_BIN_INSP ...")
ut_FixSequence("NTI_ELEM_BIN_INSP"; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2)
MESSAGE:C88(Char:C90(13)+"NTI_ELEM_TIN_INSP ...")
ut_FixSequence("NTI_ELEM_TIN_INSP"; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2)

MESSAGE:C88(Char:C90(13)+"[TIN_Inspections] ...")
ut_FixSequence("TIN_Inspections"; ->[TIN_Inspections:184]InspectionID:2)

MESSAGE:C88(Char:C90(13)+"TIN_Insp_Comments...")
ut_FixSequence("TIN_Insp_Comments"; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3)

MESSAGE:C88(Char:C90(13)+"TIN_Insp_Images...")
ut_FixSequence("TIN_Insp_Images"; ->[TIN_Insp_Images:186]ImageID:2)

// "LSS_RouteDirectionId_s" -all LSS_@ ignored for now
// "LSS_StructureCoatingId_s" -all LSS_@ ignored for now
// "lss_structure" -all LSS_@ ignored for now
// "LSS_InventoryId_s" -all LSS_@ ignored for now
// "LSS_Inventory" -all LSS_@ ignored for now
// "LSS_Inspection" -all LSS_@ ignored for now
// "LSS_Accessibility" -all LSS_@ ignored for now
// "[LSS_UT]LSS_UTId_s" -all LSS_@ ignored for now and this one is a bad seq name
// "LSS_Photo" -all LSS_@ ignored for now
// "LSS_PhotoId_s" -all LSS_@ ignored for now
// "LSS_DMeterId_s" -all LSS_@ ignored for now
// "LSS_ElementInspection" -all LSS_@ ignored for now
// "LSS_UTResultId_s" -all LSS_@ ignored for now
// "LSS_SignPanelId_s" -all LSS_@ ignored for now
// "LSS_VerticalClearanceId_s" -all LSS_@ ignored for now
// "LSS_TowerDistanceId_s" -all LSS_@ ignored for now
// "LSS_ElementInspectionId_s" -all LSS_@ ignored for now
// "LSS_InspectionId_s" -all LSS_@ ignored for now
// "1NTI_ELEM_BIN_INSP" -bad sequence name
// "LSS_UTId_s" -all LSS_@ ignored for now
// 
MESSAGE:C88(Char:C90(13)+"[NBIS Secondary] ...")  // ut_SetNBISSecondaryIndex
ut_FixSequence("[NBIS Secondary]"; ->[NBIS Secondary:3]NBISSecondaryKey_l:39)

MESSAGE:C88(Char:C90(13)+"Activity Log ...")  // LogChanges
ut_FixSequence("Activity Log"; ->[Activity Log:59]RefID:28)

MESSAGE:C88(Char:C90(13)+"AddendumMaint ...")  // PRV_Addendum_FM
ut_FixSequence("AddendumMaint"; ->[Addendum_Maintenance:102]AddendumID:1)

MESSAGE:C88(Char:C90(13)+"AddFund ...")  // [tableForm]/Contract AddFund/AddFund In/{formMethod}
ut_FixSequence("AddFund"; ->[Contract AddFund:82]AddFund_ID:2)

MESSAGE:C88(Char:C90(13)+"AddFundMaint ...")  // [tableForm]/AddFund_Maintenance/AddFun In/{formMethod}
ut_FixSequence("AddFundMaint"; ->[AddFund_Maintenance:99]AddFund_ID:2)

MESSAGE:C88(Char:C90(13)+"AddRatingRequest ...")  // RtgReq_AdtlInp_FM
ut_FixSequence("AddRatingRequest"; ->[AddtlRatingRequests:155]AddtlRequestID_L:2)

MESSAGE:C88(Char:C90(13)+"AssignMaint ...")  // PRV_AddNewAssignment
ut_FixSequence("AssignMaint"; ->[Contract_Assignment_Maintenance:101]AssignID:3)

MESSAGE:C88(Char:C90(13)+"BIN ...")  // [tableForm]/Bridge MHD NBIS/BDEPT Input/{formMethod}
// ut_FixSequence ( "BIN";->vBIN_Dec) ` ****  Investigate this one!
ut_FixBINSequence

MESSAGE:C88(Char:C90(13)+"BrDesign ...")  // PRJ_BD_BrgDSht_OM
ut_FixSequence("BrDesign"; ->[Bridge Design:75]BridgeDesignID:35)

MESSAGE:C88(Char:C90(13)+"BridgeRankCalc ...")  // BrgRank_DoRankCalc
ut_FixSequence("BridgeRankCalc"; ->[BridgeRankCalc:156]RunID_L:1)  // ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"CombinedInspections ...")  // Duplicate_Inspection
ut_FixSequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)

MESSAGE:C88(Char:C90(13)+"ConAssignments ...")  // [tableForm]/Contract Assignments/Assignments In/{formMethod}
ut_FixSequence("ConAssignments"; ->[Contract Assignments:83]AssignID:3)

MESSAGE:C88(Char:C90(13)+"Cond Unit ID ...")  // DUPLIC_INSP
ut_FixSequence("Cond Unit ID"; ->[Cond Units:45]Cond Unit ID:1)

MESSAGE:C88(Char:C90(13)+"ConInvoice ...")  // [tableForm]/Contract Invoice/ContractInvoice In/{formMethod}
ut_FixSequence("ConInvoice"; ->[Contract Invoice:84]InvoiceID:1)

MESSAGE:C88(Char:C90(13)+"ConsAddress ...")  // ut_importAddress
ut_FixSequence("ConsAddress"; ->[Conslt Address:77]ConsltAddressID:1)

MESSAGE:C88(Char:C90(13)+"ConsInsp ...")  // [tableForm]/Cons Inspection/Cslt Insp In/{formMethod}
ut_FixSequence("ConsInsp"; ->[Cons Inspection:64]ConsInspectionID:32)

MESSAGE:C88(Char:C90(13)+"ConsRtg ...")  // [tableForm]/Conslt Rating/Cslt Rating In/{formMethod}
ut_FixSequence("ConsRtg"; ->[Conslt Rating:63]ConsltRatingID:42)

MESSAGE:C88(Char:C90(13)+"ConsultantNameID_l ...")  // ut_PRJMoveConsultants
ut_FixSequence("ConsultantNameID_l"; ->[Conslt_Name:127]ConsultantNameID_l:1)

MESSAGE:C88(Char:C90(13)+"Contract ...")  // [tableForm]/Contracts/Contracts In/{formMethod}
ut_FixSequence("Contract"; ->[Contracts:79]ContractID:29)

MESSAGE:C88(Char:C90(13)+"ContractMaint ...")  // [tableForm]/Contract_Maintenance/Contract Maintenance In/{formMethod}
ut_FixSequence("ContractMaint"; ->[Contract_Maintenance:97]ContractID:2)

MESSAGE:C88(Char:C90(13)+"CP_ConstructionProj ...")  // ut_PRJRetrieveConstructionCont
ut_FixSequence("CP_ConstructionProj"; ->[PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)

MESSAGE:C88(Char:C90(13)+"DC_DesignProjectID_l ...")  // ut_PRJRetrieveDesignContracts
ut_FixSequence("DC_DesignProjectID_l"; ->[PRJ_DesignContracts:123]DC_DesignContractID_l:1)

MESSAGE:C88(Char:C90(13)+"DCM_ProjDailyItems ...")  // DCM_DailyControl_OM
// ****  Sequence DCM_ProjDailyItems Not found in table ! ****
ut_FixSequence("DCM_ProjDailyItems"; ->[DCM_ProjDailyItems:144]DailyItemID_L:2)

MESSAGE:C88(Char:C90(13)+"DCMAssignMaint ...")  // DCM_WO_Input_FM
ut_FixSequence("DCMAssignMaint"; ->[DCM_WorkOrders:137]AssignID:3)

MESSAGE:C88(Char:C90(13)+"DCMContractMaint ...")  // DCM_C_Input_FM
ut_FixSequence("DCMContractMaint"; ->[DCM_Contracts:136]ContractID:2)

MESSAGE:C88(Char:C90(13)+"DCMProjDailys ...")  // DCM_ProjDailyControl_OM
// ****  Sequence DCMProjDailys Not found in table ! ****
ut_FixSequence("DCMProjDailys"; ->[DCM_ProjDailys:143]DailyID_L:2)

MESSAGE:C88(Char:C90(13)+"DCMProjMaint ...")  // DCM_P_Input_FM
ut_FixSequence("DCMProjMaint"; ->[DCM_Project:138]ProjectID:1)

MESSAGE:C88(Char:C90(13)+"ElementsSafety ...")  // MakeInspection
ut_FixSequence("ElementsSafety"; ->[ElementsSafety:29]ElmSafetyID:7)

MESSAGE:C88(Char:C90(13)+"ElmtRatingLoads ...")  // Duplicate_Inspection
ut_FixSequence("ElmtRatingLoads"; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)

MESSAGE:C88(Char:C90(13)+"ExtTime ...")  // [tableForm]/Contract ExtendTime/ExtTime In/{formMethod}
ut_FixSequence("ExtTime"; ->[Contract ExtendTime:81]EOT_ID:2)

MESSAGE:C88(Char:C90(13)+"ExtTimeMaint ...")  // [tableForm]/ExtendTime_Maintenance/ExtTime In/{formMethod}
ut_FixSequence("ExtTimeMaint"; ->[ExtendTime_Maintenance:98]EOT_ID:2)

MESSAGE:C88(Char:C90(13)+"ExtTimeMntFYAlloc ...")  // CM_AddExtTimeFYAlloc
ut_FixSequence("ExtTimeMntFYAlloc"; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1)

MESSAGE:C88(Char:C90(13)+"FundTransfer ...")  // [tableForm]/Contract FundTransfer/TransferFund In/{formMethod}
ut_FixSequence("FundTransfer"; ->[Contract FundTransfer:80]TOF_ID:2)

MESSAGE:C88(Char:C90(13)+"FundTransMaint ...")  // [tableForm]/FundTransfer_Maintenance/TransferFund In/{formMethod}
ut_FixSequence("FundTransMaint"; ->[FundTransfer_Maintenance:96]TOF_ID:2)

MESSAGE:C88(Char:C90(13)+"Inspections ...")  // ADD_INSPECT
ut_FixSequence("Inspections"; ->[Inspections:27]InspID:2)

MESSAGE:C88(Char:C90(13)+"InventoryPhoto ...")  // INSP_DuplicateInventoryPhotos
ut_FixSequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)

MESSAGE:C88(Char:C90(13)+"InventoryPhotoInsp ...")  // INSP_DuplicateInventoryPhotos
ut_FixSequence("InventoryPhotoInsp"; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1)

MESSAGE:C88(Char:C90(13)+"InvoiceMaint ...")  // PRV_Invoice_FM
ut_FixSequence("InvoiceMaint"; ->[Invoice_Maintenance:95]InvoiceID:1)

MESSAGE:C88(Char:C90(13)+"LB_QueryTable ...")  // LB_ControlListBoxDisplay
ut_FixSequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)

MESSAGE:C88(Char:C90(13)+"LSS_AccessibilityId_s ...")  // LSS_AccessibilitySave
// ****  Sequence LSS_AccessibilityId_s Not found in table ! ****
// ut_FixSequence ( "LSS_AccessibilityId_s";->$Key_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_DMeterId_s ...")  // FM_DMeterInput
// ut_FixSequence ( "LSS_DMeterId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_ElementInspectionId_s ...")  // LSS_LoadElementInspectionRecord
// ut_FixSequence ( "LSS_ElementInspectionId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_InspectionId_s ...")  // FM_InspectionInput
// ut_FixSequence ( "LSS_InspectionId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_InventoryId_s ...")  // [tableForm]/LSS_Inventory/New_InventoryItem/{formMethod}
// ut_FixSequence ( "LSS_InventoryId_s";->$NextID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_PhotoId_s ...")  // FM_PhotoInput
// ut_FixSequence ( "LSS_PhotoId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_RouteDirectionId_s ...")  // FM_RefRouteDirectionInput
// ut_FixSequence ( "LSS_RouteDirectionId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_SignPanelId_s ...")  // FM_SignPanel
// ut_FixSequence ( "LSS_SignPanelId_s";->$Key_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_Structure ...")  // FM_refStructureMaterialInput
// ut_FixSequence ( "LSS_Structure";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_UTId_s ...")  // FM_UTInput
// ut_FixSequence ( "LSS_UTId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_UTResultId_s ...")  // FM_UTResults
// ut_FixSequence ( "LSS_UTResultId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"LSS_VerticalClearanceId_s ...")  // FM_VerticalClearance
// ut_FixSequence ( "LSS_VerticalClearanceId_s";->$ID_L) ` ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"MaintInvoiceAssign ...")  // [tableForm]/Invoice_AssignNo_Maintenance/Input/{formMethod}
ut_FixSequence("MaintInvoiceAssign"; ->[Invoice_AssignNo_Maintenance:94]ID:6)

MESSAGE:C88(Char:C90(13)+"NTI_ELEM_BIN_INSP ...")  // INSP_ImportInspection
ut_FixSequence("NTI_ELEM_BIN_INSP"; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2)

MESSAGE:C88(Char:C90(13)+"NTI_ELEM_TIN_INSP ...")  // NTI_ELEMINP_TIN_FM
ut_FixSequence("NTI_ELEM_TIN_INSP"; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2)

MESSAGE:C88(Char:C90(13)+"Personnel ...")  // ADDUSER_Utils
ut_FixSequence("Personnel"; ->[Personnel:42]Person ID:1)

MESSAGE:C88(Char:C90(13)+"PersUserGroups ...")  // ut_CNLPersonnelGroupRecords
ut_FixSequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)

MESSAGE:C88(Char:C90(13)+"PF_FileID_l ...")  // ut_PRJImportData
ut_FixSequence("PF_FileID_l"; ->[PRJ_ProjectFile:117]PF_FileID_l:1)

MESSAGE:C88(Char:C90(13)+"PM_RunKey_l ...")  // PM_ControlMetricRetrieve
ut_FixSequence("PM_RunKey_l"; ->[Pontis_Metrics:41]PM_RunKey_l:1)  // ****  Investigate this one!

MESSAGE:C88(Char:C90(13)+"PON_ELEM_COSTS ...")  // PON_UpdateCosts
// ****  Sequence PON_ELEM_COSTS Not found in table ! ****
ut_FixSequence("PON_ELEM_COSTS"; ->[PON_ELEM_COSTS:180]COSTID_L:5)

MESSAGE:C88(Char:C90(13)+"PON_ELEM_INSP ...")  // INSP_ImportInspection
ut_FixSequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)

MESSAGE:C88(Char:C90(13)+"Pontis Insp ID ...")  // IMP_One_File
ut_FixSequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)

MESSAGE:C88(Char:C90(13)+"PreservMtgs ...")  // PRV_MEETINGINP_FM
// ****  Sequence PreservMtgs Not found in table ! ****
ut_FixSequence("PreservMtgs"; ->[Preservation_Meetings:148]MeetingID_L:1)

MESSAGE:C88(Char:C90(13)+"PreservReview ...")  // PRV_ReviewInput_FM
ut_FixSequence("PreservReview"; ->[Preservation_Reviews:145]Review_ID:1)

MESSAGE:C88(Char:C90(13)+"PRJ_ProjectID_l ...")  // ut_PRJImportData
ut_FixSequence("PRJ_ProjectID_l"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)

MESSAGE:C88(Char:C90(13)+"PRJ_TimeSheetEntry ...")  // PRJ_PT_ValidateTime_OM
ut_FixSequence("PRJ_TimeSheetEntry"; ->[PRJ_ProjectTimeTracking:124]PT_TimeTrackingID_l:1)

MESSAGE:C88(Char:C90(13)+"ProjMaint ...")  // PRV_ProjBridgeInput_FM
ut_FixSequence("ProjMaint"; ->[Contract_Project_Maintenance:100]ProjectID:1)

MESSAGE:C88(Char:C90(13)+"RatingID_L ...")  // FM_TunnelRatingInput
// ****  Sequence RatingID_L Not found in table ! ****
ut_FixSequence("RatingID_L"; ->[NTI_TunnelRatings:189]RatingID_L:11)

MESSAGE:C88(Char:C90(13)+"RatingReports ...")  // [tableForm]/RatingReports/RatReportsIn/{formMethod}
ut_FixSequence("RatingReports"; ->[RatingReports:65]RatingID:21)

MESSAGE:C88(Char:C90(13)+"RatingRequest ...")  // RtgReq_Input_FM
ut_FixSequence("RatingRequest"; ->[RatingRequests:154]RatingRequestID_L:2)

MESSAGE:C88(Char:C90(13)+"ScourPOA ...")  // SCPOA_InpFormMethod
ut_FixSequence("ScourPOA"; ->[ScourPOA:132]ScourPOAID:1)

MESSAGE:C88(Char:C90(13)+"ScourPOA_DetourBridge ...")  // [tableForm]/ScourPOA_DetourBridge/Input/DE bValidate
ut_FixSequence("ScourPOA_DetourBridge"; ->[ScourPOA_DetourBridge:133]DetourBridgeID_L:1)

MESSAGE:C88(Char:C90(13)+"ScourPOA_Images ...")  // SCPOA_CopyInvPhotos
ut_FixSequence("ScourPOA_Images"; ->[ScourPOA_Images:134]ScourPOAImgID:1)

MESSAGE:C88(Char:C90(13)+"SpecialRptsTbl ...")  // [tableForm]/Dialogs/LoadQuickReport/BAddQuickReport
ut_FixSequence("SpecialRptsTbl"; ->[zSpecialReports:106]Record_ID:7)

MESSAGE:C88(Char:C90(13)+"StandardPhotos ...")  // Duplicate_Inspection
ut_FixSequence("StandardPhotos"; ->[Standard Photos:36]StdPhotoID:7)

MESSAGE:C88(Char:C90(13)+"TableOfLists ...")  // PRJ_SelectorCreateAttribute
ut_FixSequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)

MESSAGE:C88(Char:C90(13)+"TemplateInc ...")  // [tableForm]/Dialogs/LoadQuickReport/BAddQuickReport
ut_FixSequence("TemplateInc"; ->[Templates:86]TemplateID:1)

MESSAGE:C88(Char:C90(13)+"TIN_Insp_Comments ...")  // NTI_DuplicateInspection
ut_FixSequence("TIN_Insp_Comments"; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3)

MESSAGE:C88(Char:C90(13)+"TIN_Insp_Images ...")  // NTI_DuplicateInspection
ut_FixSequence("TIN_Insp_Images"; ->[TIN_Insp_Images:186]ImageID:2)

MESSAGE:C88(Char:C90(13)+"TIN_Inspections ...")  // NTI_InspectionInput_FM
ut_FixSequence("TIN_Inspections"; ->[TIN_Inspections:184]InspectionID:2)

MESSAGE:C88(Char:C90(13)+"TownAddress ...")  // temp_LoadDist1TownAddress
ut_FixSequence("TownAddress"; ->[Town Address:78]TownAddressID:1)

MESSAGE:C88(Char:C90(13)+"TownLine ...")  // [tableForm]/Bridge MHD NBIS/BDEPT Input/{formMethod}
ut_FixSequence("TownLine"; ->[TownLineInfo:73]RefID:3)

MESSAGE:C88(Char:C90(13)+"TunnelInspection ...")  // Duplicate_Inspection
ut_FixSequence("TunnelInspection"; ->[TunnelInspection:152]TunnelInspID_L:15)

MESSAGE:C88(Char:C90(13)+"WorkHrEstimate ...")  // WKHR_CreateProposal
ut_FixSequence("WorkHrEstimate"; ->[Work_Estimate:103]WKID:1)

MESSAGE:C88(Char:C90(13)+"RatingReportVehicles ...")
ut_FixSequence("RatingReportVehicles"; ->[RatingReportVehicles:191]RatingVehicleID:1)

MESSAGE:C88(Char:C90(13)+"BridgeStairs ...")
ut_FixSequence("BridgeStairs"; ->[BridgeStairs:192]BridgeStairsID:1)

CLOSE WINDOW:C154

ALERT:C41("Done Scanning sequences")