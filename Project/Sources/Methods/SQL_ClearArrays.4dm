//%attributes = {"invisible":true}
// ----------------------------------------------------
// SQL_ClearArrays
// User name (OS): 
// Date and time: 05/17/05, 16:32:50
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 - name of stored procedure to run
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM04
	Mods_2006_CJMv2  //06/15/06, 12:14:34`add sp_retrieveConstructionCompany
	Mods_2006_CJMv2  //11/21/06, 15:27:12` new calls to get consultant company name and contact info
	Mods_2007_CJM_v5310
	Mods_2007_CJM_v5310  //06/20/07 `Add data to stored procedure and a new stored procedure call
	Mods_2007_CJM_v5310  //06/28/07 `Modify sql to update from correct calls
	// Modified by: costasmanousakis-(Designer)-(10/10/2007 13:54:41)
	Mods_2007_CM12_5301  // Added array PRJ_ComplDate_2_atxt to get more recent completion dates
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	Mods_2008_CJM_v001  //r001 `01/22/08, 15:05:23  
	// Modified by: costasmanousakis-(Designer)-(2/22/08 08:30:44)
	Mods_2008_CM_5402
	//Added retrieval of status for projects   
	// Modified by: costasmanousakis-(Designer)-(12/16/08 11:31:06)
	Mods_2008_CM_5404("PRJDESRTRV")
	//changes in the Retrieve of design contracts
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 11:17:48
	Mods_2009_05  //r002 `05/28/09, 10:01:32   `Add code and tables to retrieve pontis simulation data
	Mods_2009_07  //r001 `07/23/09, 10:44:25   `Add call to AE to retrieve additional [PRJ_ConstructionProject] data
	// Modified by: costasmanousakis-(Designer)-(8/31/10 14:52:35)
	Mods_2010_08
	//Added call to retrieve Project Type descriptions sp_RTRVProjTypes
	Mods_2012_04  //r001 Add call sp_RetrieveVendorID to get vendor id
	//Modified by: Charles Miller (4/26/12 15:01:51)
	// Modified by: Costas Manousakis-(Designer)-(6/19/12 16:14:51)
	Mods_2012_06
	//  ` Addition of sp_VW_PRJ_TASKEVENTS
	Mods_2013_04  //r001 ` Add AEAward date [PRJ_ConstructionProject]
	//Modified by: Charles Miller (4/4/13 15:06:56)
	
	// Modified by: manousakisc (1/2/2015)
	Mods_2014_12
	//  `changed field [Pontis_Metrics]PM_Tev_l to a real
	
End if 
C_TEXT:C284($1; $SQLName_txt)
$SQLName_txt:=$1
Case of 
	: ($SQLName_txt="sp_RTRV_MMARSTotal")
		ARRAY REAL:C219(PRJ_MMAR_Total_ar; 0)
	: ($SQLName_txt="sp_RTRV_MMARSSpent")
		ARRAY REAL:C219(PRJ_MMAR_Spent_ar; 0)
	: ($SQLName_txt="sp_RTRV_EXPSCTotal")
		ARRAY REAL:C219(PRJ_EXPSCTotal_ar; 0)
	: ($SQLName_txt="sp_RTRV_EXPSCSpent")
		ARRAY REAL:C219(PRJ_EXPSCSpent_ar; 0)
	: ($SQLName_txt="sp_RTRV_MMARSAccept")
		ARRAY REAL:C219(PRJ_MMAR_Accepted_ar; 0)
	: ($SQLName_txt="sp_RTRV_MMARSPay")
		ARRAY REAL:C219(PRJ_MMAR_Payed_ar; 0)
	: ($SQLName_txt="sp_RTRV_MMARSBFYAMT")
		ARRAY REAL:C219(PRJ_MMAR_BFY_ar; 0)
	: ($SQLName_txt="sp_RTRVContractID")
		ARRAY LONGINT:C221(CTR_Contract_NO_ID_al; 0)
		
	: ($SQLName_txt="sp_RTRVContractID")
		ARRAY LONGINT:C221(CTR_Contract_NO_ID_al; 0)
	: ($SQLName_txt="sp_RTRVAdDtForFileNo")
		ARRAY TEXT:C222(PRJFileAdDate_atxt; 0)
	: ($SQLName_txt="sp_pontis_gen_inspkey")  //`I do not think used any longer
		ARRAY TEXT:C222(Pontis_UniqueInspectionKey_atxt; 0)
	: ($SQLName_txt="sp_Update_NBI_Data")
		ARRAY TEXT:C222(Pontis_UniqueInspectionKey_atxt; 0)
	: ($SQLName_txt="sp_RTRVNewContract")
		ARRAY LONGINT:C221(CTR_Contract_No_al; 0)
		ARRAY TEXT:C222(CTR_CONTR_TypeDesc_atxt; 0)
		ARRAY TEXT:C222(CTR_CONTRACT_DESC_atxt; 0)
		ARRAY TEXT:C222(CTR_CONTRACT_Status_atxt; 0)
		ARRAY REAL:C219(CTR_EST_Contract_Amt_ar; 0)
		ARRAY TEXT:C222(CTR_EST_COMPL_DATE_atxt; 0)
		ARRAY LONGINT:C221(CTR_PROJECT_NO_al; 0)
		ARRAY TEXT:C222(CTR_COMPL_DATE_atxt; 0)
		ARRAY TEXT:C222(CTR_ContractType_atxt; 0)
		ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)
		ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
		ARRAY TEXT:C222(PRJ_EMPLOYEE_FNAME_atxt; 0)
		ARRAY TEXT:C222(PRJ_EMPLOYEE_MNAME_atxt; 0)
		ARRAY TEXT:C222(PRJ_EMPLOYEE_LNAME_atxt; 0)
		ARRAY TEXT:C222(PRJ_BUSINESS_PHONE_atxt; 0)
		
		
	: ($SQLName_txt="sp_RTRVProjects")
		ARRAY LONGINT:C221(PRJ_PROJECT_NO_al; 0)
		ARRAY TEXT:C222(PRJ_PARS_DESIGN_atxt; 0)
		ARRAY TEXT:C222(PRJ_EMPLOYEE_FNAME_atxt; 0)
		ARRAY TEXT:C222(PRJ_EMPLOYEE_MNAME_atxt; 0)
		ARRAY TEXT:C222(PRJ_EMPLOYEE_LNAME_atxt; 0)
		ARRAY TEXT:C222(PRJ_BUSINESS_PHONE_atxt; 0)
		ARRAY LONGINT:C221(PRJ_Status_al; 0)
		
	: ($SQLName_txt="sp_RTRVConstData")
		ARRAY TEXT:C222(PRJ_AwardDate_atxt; 0)
		ARRAY TEXT:C222(PRJ_NTPDate_atxt; 0)
		ARRAY TEXT:C222(PRJ_ComplDate_atxt; 0)
		ARRAY TEXT:C222(PRJ_BidOpenedDate_atxt; 0)
		ARRAY REAL:C219(PRJ_FileNumber_ar; 0)
		ARRAY TEXT:C222(PRJ_ConstructionContract_atxt; 0)
		ARRAY REAL:C219(PRJ_OfficeEst_ar; 0)
		ARRAY REAL:C219(PRJ_BidAmt_ar; 0)
		ARRAY TEXT:C222(PRJ_AdvertisedDate_atxt; 0)
		ARRAY LONGINT:C221(PRJ_SQLID_al; 0)
		ARRAY TEXT:C222(PRJ_ComplDate_2_atxt; 0)
		
	: ($SQLName_txt="sp_RTRVUpdateID")
		ARRAY LONGINT:C221(PRJ_SQLID_al; 0)
		ARRAY TEXT:C222(PRJ_ConstructionContract_atxt; 0)
		
	: ($SQLName_txt="sp_RTRVConstCompany")
		ARRAY LONGINT:C221(PRJ_CPCompanyNameID_al; 0)
		ARRAY TEXT:C222(PRJ_CPCompanyName_atxt; 0)
		
	: ($SQLName_txt="sp_RetrieveVendorID")
		ARRAY TEXT:C222(PRJ_CPVendorCode_atxt; 0)
		
	: ($SQLName_txt="sp_RTRVPO_EstOpen_Dt")
		ARRAY LONGINT:C221(PRJ_PROJECT_NO_al; 0)
		ARRAY REAL:C219(PRJ_OfficeEst_ar; 0)
		ARRAY TEXT:C222(PRJ_BidOpenedDate_atxt; 0)
		
	: ($SQLName_txt="sp_VW_PRJ_PROJECT")
		ARRAY LONGINT:C221(PRJ_PROJECT_NO_al; 0)
		ARRAY TEXT:C222(PRJFileAdDate_atxt; 0)
		ARRAY REAL:C219(PRJ_AdCost_ar; 0)
		ARRAY REAL:C219(PRJ_FedPartCost_ar; 0)
		ARRAY TEXT:C222(PRJTipYear_atxt; 0)
		ARRAY REAL:C219(PRJ_TipCost_ar; 0)
		ARRAY TEXT:C222(PRJ_BidOpenedDate_atxt; 0)
		ARRAY REAL:C219(PRJ_OfficeEst_ar; 0)
		ARRAY TEXT:C222(PRJ_TypeCode_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(PRJ_Description_atxt; 0)
	: ($SQLName_txt="sp_RTRVFisclCntTotal")
		ARRAY TEXT:C222(PRJ_RetrievedAmounts_atxt; 0)
	: ($SQLName_txt="sp_RTRVDesCtrFedAid")
		ARRAY TEXT:C222(PRJ_RetrievedFedAids_atxt; 0)
		
	: ($SQLName_txt="sp_RTRVSpecData")
		ARRAY TEXT:C222(PRJ_SpecsToPrint_as; 0)  //Command Replaced was o_ARRAY string length was 10
		ARRAY TEXT:C222(PRJ_SpecsFromPrint_as; 0)  //Command Replaced was o_ARRAY string length was 10
		ARRAY TEXT:C222(PRJ_PlansToPrint_as; 0)  //Command Replaced was o_ARRAY string length was 10
		ARRAY TEXT:C222(PRJ_PlansFromPrint_as; 0)  //Command Replaced was o_ARRAY string length was 10
		ARRAY TEXT:C222(PRJ_ToCashier_as; 0)  //Command Replaced was o_ARRAY string length was 10
	: ($SQLName_txt="sp_RTRVAttributes")
		ARRAY LONGINT:C221(PRJ_AttributeID_al; 0)
		ARRAY TEXT:C222(PRJ_AttributeName_atxt; 0)
		ARRAY TEXT:C222(PRJ_AttributeDesc_atxt; 0)
		ARRAY TEXT:C222(PRJ_CreatedDate_atxt; 0)
		ARRAY TEXT:C222(PRJ_ModifiedDate_atxt; 0)
		
	: ($SQLName_txt="sp_RTRVProjTypes")
		ARRAY TEXT:C222(PRJ_AttributeName_atxt; 0)
		ARRAY TEXT:C222(PRJ_AttributeDesc_atxt; 0)
		ARRAY TEXT:C222(PRJ_CreatedDate_atxt; 0)
		ARRAY TEXT:C222(PRJ_ModifiedDate_atxt; 0)
		
	: ($SQLName_txt="sp_VW_PRJ_TASKEVENTS")
		ARRAY LONGINT:C221(PRJ_PROJECT_NO_al; 0)
		ARRAY TEXT:C222(PRJ_TASK_TYPE_CODE_atxt; 0)
		ARRAY TEXT:C222(PRJ_EVENT_TYPE_DESC_atxt; 0)
		ARRAY LONGINT:C221(PRJ_EVENT_ORDER_aL; 0)
		ARRAY TEXT:C222(PRJ_EVENT_DATE_atxt; 0)
		
	: ($SQLName_txt="sp_RTRVPRJAttributes")
		ARRAY LONGINT:C221(PRJ_PROJECT_NO_al; 0)
		ARRAY LONGINT:C221(PRJ_AttributeID_al; 0)
		ARRAY TEXT:C222(PRJ_CreatedDate_atxt; 0)
	: ($SQLName_txt="sp_RTRVPRJ_Bridge")
		ARRAY LONGINT:C221(PRJ_PROJECT_NO_al; 0)
		ARRAY TEXT:C222(PRJ_BDEPT_atxt; 0)
	: ($SQLName_txt="sp_RetrieveEncumberedAmount")  //is this used
		ARRAY REAL:C219(PRJ_retrievedAmounts_ar; 0)
	: ($SQLName_txt="sp_RetrieveSpentAmount")  //is this used
		ARRAY REAL:C219(PRJ_retrievedAmounts_ar; 0)
	: ($SQLName_txt="sp_RTRV_PontisMetric")
		ARRAY TEXT:C222(PM_BRKey_atxt; 0)
		ARRAY TEXT:C222(PM_SCKey_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY REAL:C219(PM_TEV_ar; 0)
		
	: ($SQLName_txt="sp_RTRV_Metricdata")
		ARRAY LONGINT:C221(PM_YKey_al; 0)
		ARRAY REAL:C219(PM_Hindex_ar; 0)
		ARRAY LONGINT:C221(PM_ADT_al; 0)
		ARRAY REAL:C219(PM_PTIndex_ar; 0)
		ARRAY REAL:C219(PM_CIX_Supr_ar; 0)
		ARRAY REAL:C219(PM_CIX_Sub_ar; 0)
		ARRAY REAL:C219(PM_CIX_Joint_ar; 0)
		ARRAY REAL:C219(PM_CIX_Bear_ar; 0)
		ARRAY REAL:C219(PM_CIX_Deck_ar; 0)
		
	: ($SQLName_txt="sp_RTRVAEContData")
		ARRAY TEXT:C222(AE_Item_No_as; 0)  //Command Replaced was o_ARRAY string length was 7
		ARRAY TEXT:C222(AE_Units_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(AE_ItemDescpt_atxt; 0)
		ARRAY REAL:C219(AE_CONTQ_ar; 0)
		ARRAY REAL:C219(AE_CONTR_Price_ar; 0)
		
	: ($SQLName_txt="sp_RTRVAEContractNo")
		ARRAY TEXT:C222(AE_ContractNumber_as; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222(AE_LOCATION_atxt; 0)
		ARRAY LONGINT:C221(AE_FileNumber_al; 0)
		ARRAY TEXT:C222(AE_ContractDescpt_atxt; 0)
		ARRAY TEXT:C222(AE_AwardDate_atxt; 0)
		
End case 
//End SQL_ClearArrays