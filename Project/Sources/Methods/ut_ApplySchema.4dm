//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/23/11, 11:12:57
//----------------------------------------------------
//Method: ut_ApplySchema
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Mods_2011_11 `
	//Modified by: Charles Miller (11/23/11 11:12:58)
	// CREATE SCHEMA user_tables;
End if 
Begin SQL
	
	CREATE SCHEMA  user_tables;
	ALTER TABLE [Bridge MHD NBIS] SET SCHEMA user_tables;
	ALTER TABLE [Town Data] SET SCHEMA user_tables;
	ALTER TABLE [NBIS Secondary] SET SCHEMA user_tables;
	ALTER TABLE [MaintOwnerCode] SET SCHEMA user_tables;
	ALTER TABLE [FunctionalClass] SET SCHEMA user_tables;
	ALTER TABLE [Design Load] SET SCHEMA user_tables;
	ALTER TABLE [Posting Code] SET SCHEMA user_tables;
	ALTER TABLE [Service Over] SET SCHEMA user_tables;
	ALTER TABLE [Service Under] SET SCHEMA user_tables;
	ALTER TABLE [Material] SET SCHEMA user_tables;
	ALTER TABLE [Design] SET SCHEMA user_tables;
	ALTER TABLE [Truck Code] SET SCHEMA user_tables;
	ALTER TABLE [Direction] SET SCHEMA user_tables;
	ALTER TABLE [Deck Structure] SET SCHEMA user_tables;
	ALTER TABLE [Wearing Surface] SET SCHEMA user_tables;
	ALTER TABLE [Membrane] SET SCHEMA user_tables;
	ALTER TABLE [Deck Protection] SET SCHEMA user_tables;
	ALTER TABLE [Type of Work] SET SCHEMA user_tables;
	ALTER TABLE [Work Done By] SET SCHEMA user_tables;
	ALTER TABLE [Insp Resp] SET SCHEMA user_tables;
	ALTER TABLE [Dialogs] SET SCHEMA user_tables;
	ALTER TABLE [Item 20 Tolls] SET SCHEMA user_tables;
	ALTER TABLE [Item 33 Median] SET SCHEMA user_tables;
	ALTER TABLE [Item 38] SET SCHEMA user_tables;
	ALTER TABLE [HistSig] SET SCHEMA user_tables;
	ALTER TABLE [Months] SET SCHEMA user_tables;
	ALTER TABLE [Inspections] SET SCHEMA user_tables;
	ALTER TABLE [Sequences] SET SCHEMA user_tables;
	ALTER TABLE [ElementsSafety] SET SCHEMA user_tables;
	ALTER TABLE [ElementDict] SET SCHEMA user_tables;
	ALTER TABLE [Inspection Type] SET SCHEMA user_tables;
	ALTER TABLE [Element Cat] SET SCHEMA user_tables;
	ALTER TABLE [Item 100] SET SCHEMA user_tables;
	ALTER TABLE [Item 101] SET SCHEMA user_tables;
	ALTER TABLE [Item 111] SET SCHEMA user_tables;
	ALTER TABLE [Standard Photos] SET SCHEMA user_tables;
	ALTER TABLE [RAILBridgeInfo] SET SCHEMA user_tables;
	ALTER TABLE [Foundation Type] SET SCHEMA user_tables;
	ALTER TABLE [Bed Material] SET SCHEMA user_tables;
	ALTER TABLE [Pontis_Metric_Data] SET SCHEMA user_tables;
	ALTER TABLE [Pontis_Metrics] SET SCHEMA user_tables;
	ALTER TABLE [Personnel] SET SCHEMA user_tables;
	ALTER TABLE [Field Trip] SET SCHEMA user_tables;
	ALTER TABLE [BMS Inspections] SET SCHEMA user_tables;
	ALTER TABLE [Cond Units] SET SCHEMA user_tables;
	ALTER TABLE [Cond State Insp] SET SCHEMA user_tables;
	ALTER TABLE [BMS Elements] SET SCHEMA user_tables;
	ALTER TABLE [Environments] SET SCHEMA user_tables;
	ALTER TABLE [BMS Categories] SET SCHEMA user_tables;
	ALTER TABLE [Element Costs] SET SCHEMA user_tables;
	ALTER TABLE [Cond States] SET SCHEMA user_tables;
	ALTER TABLE [CS Actions] SET SCHEMA user_tables;
	ALTER TABLE [CS Notes] SET SCHEMA user_tables;
	ALTER TABLE [Common Notes] SET SCHEMA user_tables;
	ALTER TABLE [Cat CS Notes] SET SCHEMA user_tables;
	ALTER TABLE [BMS Field Trip] SET SCHEMA user_tables;
	ALTER TABLE [Preferences] SET SCHEMA user_tables;
	ALTER TABLE [Error Codes] SET SCHEMA user_tables;
	ALTER TABLE [Activity Log] SET SCHEMA user_tables;
	ALTER TABLE [FileIDRes Table] SET SCHEMA user_tables;
	ALTER TABLE [PostingStatus] SET SCHEMA user_tables;
	ALTER TABLE [Owners of Data] SET SCHEMA user_tables;
	ALTER TABLE [Conslt Rating] SET SCHEMA user_tables;
	ALTER TABLE [Cons Inspection] SET SCHEMA user_tables;
	ALTER TABLE [RatingReports] SET SCHEMA user_tables;
	ALTER TABLE [RatingMember] SET SCHEMA user_tables;
	ALTER TABLE [Rating Method] SET SCHEMA user_tables;
	ALTER TABLE [zDialogs] SET SCHEMA user_tables;
	ALTER TABLE [Status Report] SET SCHEMA user_tables;
	ALTER TABLE [Out of Freq] SET SCHEMA user_tables;
	ALTER TABLE [Integral Bridge] SET SCHEMA user_tables;
	ALTER TABLE [RPCs] SET SCHEMA user_tables;
	ALTER TABLE [TownLineInfo] SET SCHEMA user_tables;
	ALTER TABLE [Conslt Rating Cost] SET SCHEMA user_tables;
	ALTER TABLE [Bridge Design] SET SCHEMA user_tables;
	ALTER TABLE [Cons Inspection Cost] SET SCHEMA user_tables;
	ALTER TABLE [Conslt Address] SET SCHEMA user_tables;
	ALTER TABLE [Town Address] SET SCHEMA user_tables;
	ALTER TABLE [Contracts] SET SCHEMA user_tables;
	ALTER TABLE [Contract FundTransfer] SET SCHEMA user_tables;
	ALTER TABLE [Contract ExtendTime] SET SCHEMA user_tables;
	ALTER TABLE [Contract AddFund] SET SCHEMA user_tables;
	ALTER TABLE [Contract Assignments] SET SCHEMA user_tables;
	ALTER TABLE [Contract Invoice] SET SCHEMA user_tables;
	ALTER TABLE [Contract Invoice AssignNo] SET SCHEMA user_tables;
	ALTER TABLE [Templates] SET SCHEMA user_tables;
	ALTER TABLE [ServerProcesses] SET SCHEMA user_tables;
	ALTER TABLE [ClientAccess] SET SCHEMA user_tables;
	ALTER TABLE [SD_History] SET SCHEMA user_tables;
	ALTER TABLE [Combined Inspections] SET SCHEMA user_tables;
	ALTER TABLE [ACTMODLS] SET SCHEMA user_tables;
	ALTER TABLE [ELEMDEFS] SET SCHEMA user_tables;
	ALTER TABLE [CONDUMDL] SET SCHEMA user_tables;
	ALTER TABLE [Invoice_AssignNo_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [Invoice_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [FundTransfer_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [Contract_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [ExtendTime_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [AddFund_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [Contract_Project_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [Contract_Assignment_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [Addendum_Maintenance] SET SCHEMA user_tables;
	ALTER TABLE [Work_Estimate] SET SCHEMA user_tables;
	ALTER TABLE [WorkHour_Config] SET SCHEMA user_tables;
	ALTER TABLE [WorkHour_Summary] SET SCHEMA user_tables;
	ALTER TABLE [zSpecialReports] SET SCHEMA user_tables;
	ALTER TABLE [Parameters] SET SCHEMA user_tables;
	ALTER TABLE [ScourPriorityRank] SET SCHEMA user_tables;
	ALTER TABLE [PERS_Groups] SET SCHEMA user_tables;
	ALTER TABLE [PERS_GroupMembers] SET SCHEMA user_tables;
	ALTER TABLE [CM_ExtTimeFYAlloc] SET SCHEMA user_tables;
	ALTER TABLE [InventoryPhotoInsp] SET SCHEMA user_tables;
	ALTER TABLE [InventoryPhotos] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_Contractor] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ProjectDetails] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ConstructionProject] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ProjectFile] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ReportData] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_StructuralReview] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_SketchPlans] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_TypeStudy] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ProjectDetailsIncludedBINS] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_DesignContracts] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ProjectTimeTracking] SET SCHEMA user_tables;
	ALTER TABLE [TableOfLists] SET SCHEMA user_tables;
	ALTER TABLE [SQL_Connections] SET SCHEMA user_tables;
	ALTER TABLE [Conslt_Name] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_StrPrjManagerHistory] SET SCHEMA user_tables;
	ALTER TABLE [Scour Report] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_Attributes] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ATTRFileNoXrefs] SET SCHEMA user_tables;
	ALTER TABLE [ScourPOA] SET SCHEMA user_tables;
	ALTER TABLE [ScourPOA_DetourBridge] SET SCHEMA user_tables;
	ALTER TABLE [ScourPOA_Images] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_DCPFJoin] SET SCHEMA user_tables;
	ALTER TABLE [DCM_Contracts] SET SCHEMA user_tables;
	ALTER TABLE [DCM_WorkOrders] SET SCHEMA user_tables;
	ALTER TABLE [DCM_Project] SET SCHEMA user_tables;
	ALTER TABLE [BridgeMHDNBISArchive] SET SCHEMA user_tables;
	ALTER TABLE [NBISSecondaryArchive] SET SCHEMA user_tables;
	ALTER TABLE [PRJ_ProjectTypes] SET SCHEMA user_tables;
	ALTER TABLE [DCM_ProjDailyHrs] SET SCHEMA user_tables;
	ALTER TABLE [DCM_ProjDailys] SET SCHEMA user_tables;
	ALTER TABLE [DCM_ProjDailyItems] SET SCHEMA user_tables;
	ALTER TABLE [Bridge MHD NBIS_TownLineBDEPT] SET SCHEMA user_tables;
	ALTER TABLE [ONSQLAuthenticationErrors] SET SCHEMA user_tables;
	ALTER TABLE [Bridge MHD NBIS_Year Painted] SET SCHEMA user_tables;
	ALTER TABLE [Inspections_Reserved] SET SCHEMA user_tables;
	
	GRANT READ ON user_tables TO ReadOnly;
	GRANT READ_WRITE ON user_tables TO ReadWrite;
End SQL


//End 

