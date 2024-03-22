//%attributes = {"invisible":true}
//Method: Compiler_SPRetrieve
//Description
//  ` copy of  SQL_ClearArrays for array declaration
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/09/13, 11:29:16
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: manousakisc (1/2/2015)
	Mods_2014_12
	//  `changed field [Pontis_Metrics]PM_Tev_l to a real
	
	ARRAY DATE:C224(PM_IMPORTDATE_AD; 0)
	
End if 
//

C_TEXT:C284($SQLName_txt)
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

//End Compiler_SPRetrieve