//%attributes = {"invisible":true}
//Method: SQL_Direct
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/11/19, 16:00:28
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06_bug
	Mods_2019_10_bug  //Modified Poject retrieve to create CSV files for all returned data
	//Modified by: Chuck Miller (10/24/19 11:07:37)
End if 
//
C_BOOLEAN:C305($0)
C_TEXT:C284($currentErrCall_txt)
$currentErrCall_txt:=Method called on error:C704
4DError_b:=False:C215
ON ERR CALL:C155("4D_Errors")
C_TEXT:C284($1)
C_TEXT:C284($1; $SQLName_txt; $SQL_SelectArrays_txt)
$SQLName_txt:=$1
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$SQLName_txt)

SQL_Select:=[Parameters:107]Description:2
SQL_ClearArrays($SQLName_txt)

C_LONGINT:C283(NumberOfRowsPerFetch_l)
NumberOfRowsPerFetch_l:=5  //set default to 5 rows

Case of 
	: ($SQLName_txt="sp_RTRV_MMARSTotal")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID_l"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_MMAR_Total_ar)
		//SET TEXT TO CLIPBOARD(SQL_Select)
	: ($SQLName_txt="sp_RTRV_MMARSSpent")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID_l"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_MMAR_Spent_ar)
		//SET TEXT TO CLIPBOARD(SQL_Select)
	: ($SQLName_txt="sp_RTRV_EXPSCTotal")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID_l"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_EXPSCTotal_ar)
		//SET TEXT TO CLIPBOARD(SQL_Select)
	: ($SQLName_txt="sp_RTRV_EXPSCSpent")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID_l"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_EXPSCSpent_ar)
		//SET TEXT TO CLIPBOARD(SQL_Select)
	: ($SQLName_txt="sp_RTRV_MMARSAccept")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID_l"; String:C10(PRJ_RTRV_ContractID_L))
		//SET TEXT TO CLIPBOARD(SQL_Select)
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_MMAR_Accepted_ar)
		//SET TEXT TO CLIPBOARD(SQL_Select)
		
	: ($SQLName_txt="sp_RTRV_MMARSPay")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID_l"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_MMAR_Payed_ar)
		//SET TEXT TO CLIPBOARD(SQL_Select)
	: ($SQLName_txt="sp_RTRV_MMARSBFYAMT")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID_l"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_MMAR_BFY_ar)
		//SET TEXT TO CLIPBOARD(SQL_Select)
	: ($SQLName_txt="sp_RTRVAdDtForFileNo")
		SQL_Select:=Replace string:C233(SQL_Select; "[PRJ_ProjectFile]PF_FileNumber_l"; String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJFileAdDate_atxt)
		
		
	: ($SQLName_txt="sp_RTRVUpdateID")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_SQLID_al; ->PRJ_ConstructionContract_atxt)
		NumberOfRowsPerFetch_l:=1000
		
	: ($SQLName_txt="sp_RTRVNewContract")
		//TBL_CONTRACT.CONTRACT_NOCTR_Contract_No_al[PRJ_DesignContracts]DC_DesignContractNumber_l
		//tbl_lu_contract_types.contract_type_descriptionCTR_CONTR_TypeDesc_atxt[PRJ_DesignContracts]DC_ContrTypeDesc_s
		//fngetContractStatusCTR_CONTRACT_Status_atxt[PRJ_DesignContracts]DC_ContractStatus_s
		//TBL_CONTRACT.CONTRACT_DESCPTCTR_CONTRACT_DESC_atxt[PRJ_DesignContracts]DC_Description_txt
		//TBL_CONTRACT.EST_COMPL_DATECTR_EST_COMPL_DATE_atxt[PRJ_DesignContracts]DC_Completion_d
		//TBL_CONTRACT_PROJECT.PROJECT_NOCTR_PROJECT_NO_al[PRJ_ProjectFile]PF_FileNumber_l
		//TBL_CONTRACT.COMPL_DATECTR_COMPL_DATE_atxt[PRJ_DesignContracts]DC_EstComplete_d
		//TBL_LU_CONTRACT_TYPES.CONTRACT_TYPECTR_ContractType_atxtNOT STORED
		//CHild_name FROM  VIEW_CONTRACT_VENDORPRJ_ConsultantName_atxt[Conslt_Name]ConsultantName_s
		//CHild_ID FROM  VIEW_CONTRACT_VENDORPRJ_ConsultantID_al[Conslt_Name]SQL_VendorID_l
		//BL_EMPLOYEES.EMPLOYEE_FNAMEPRJ_EMPLOYEE_FNAME_atxt[PRJ_DesignContracts]DC_ContractManager_s
		//dbo.TBL_EMPLOYEES.EMPLOYEE_MNAMEPRJ_EMPLOYEE_MNAME_atxt[PRJ_DesignContracts]DC_ContractManager_s
		//TBL_EMPLOYEES.EMPLOYEE_LNAMEPRJ_EMPLOYEE_LNAME_atxt[PRJ_DesignContracts]DC_ContractManager_s
		//TBL_EMPLOYEES.BUSINESS_PHONEPRJ_BUSINESS_PHONE_atxt[PRJ_DesignContracts]DC_ContractManager_s
		
		SQL_Select:=Replace string:C233(SQL_Select; "CTR_LastUpdateYYYYMMDD_txt"; CTR_LastUpdateYYYYMMDD_txt)
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->CTR_Contract_No_al; ->CTR_CONTR_TypeDesc_atxt; ->CTR_CONTRACT_Status_atxt; ->CTR_CONTRACT_DESC_atxt; ->CTR_EST_COMPL_DATE_atxt; ->CTR_PROJECT_NO_al; ->CTR_COMPL_DATE_atxt; ->CTR_ContractType_atxt; ->PRJ_ConsultantName_atxt; ->PRJ_ConsultantID_al)
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_EMPLOYEE_FNAME_atxt; ->PRJ_EMPLOYEE_MNAME_atxt; ->PRJ_EMPLOYEE_LNAME_atxt; ->PRJ_BUSINESS_PHONE_atxt)
		NumberOfRowsPerFetch_l:=500
	: ($SQLName_txt="sp_RTRVProjects")
		//PRJ_PROJECT_NO_al            `[ProjectFile]PF_FileNumber_l                         `  `           `TBL_PRJ_PROJECT.PROJECT_NO
		//PRJ_PARS_DESIGN_atxt       `[ProjectFile]PF_EWO_s                                  `  `            `TBL_PRJ_PROJECT.PARS_DESIGN
		//PRJ_EMPLOYEE_FNAME_atxt  `[ProjectFile]PF_ProjectExpiditer_s (1st initial .)       `  ``TBL_EMPLOYEES.EMPLOYEE_FNAME
		//PRJ_EMPLOYEE_MNAME_atxt `[ProjectFile]PF_ProjectExpiditer_s (1st Initial .)     `  `  `TBL_EMPLOYEES.EMPLOYEE_MNAME
		//PRJ_EMPLOYEE_LNAME_atxt  `[ProjectFile]PF_ProjectExpiditer_s (all)                 `  `   `TBL_EMPLOYEES.EMPLOYEE_LNAME
		//PRJ_BUSINESS_PHONE_atxt  `[ProjectFile]PF_ProjectExpiditer_s (- all)               `  `   `TBL_EMPLOYEES.BUSINESS_PHONE
		SQL_Select:=Replace string:C233(SQL_Select; "CTR_LastUpdateYYYYMMDD_txt"; CTR_LastUpdateYYYYMMDD_txt)
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_PROJECT_NO_al; ->PRJ_PARS_DESIGN_atxt; ->PRJ_EMPLOYEE_FNAME_atxt; ->PRJ_EMPLOYEE_MNAME_atxt; ->PRJ_EMPLOYEE_LNAME_atxt; ->PRJ_BUSINESS_PHONE_atxt; ->PRJ_Status_al)
		NumberOfRowsPerFetch_l:=500
	: ($SQLName_txt="sp_RTRVConstData")
		
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_AwardDate_atxt; ->PRJ_NTPDate_atxt; ->PRJ_ComplDate_atxt; ->PRJ_ConstructionContract_atxt; ->PRJ_FileNumber_ar; ->PRJ_BidOpenedDate_atxt; ->PRJ_OfficeEst_ar; ->PRJ_BidAmt_ar; ->PRJ_AdvertisedDate_atxt; ->PRJ_SQLID_al; ->PRJ_ComplDate_2_atxt)
		NumberOfRowsPerFetch_l:=500
		
	: ($SQLName_txt="sp_RTRVSpecData")
		SQL_Select:=Replace string:C233(SQL_Select; "[PRJ_ConstructionProject]CP_SQLID_l"; String:C10([PRJ_ConstructionProject:116]CP_SQLID_l:13))
		//SQL_Direct_ReturnArrays (->$SQL_SelectArrays_txt;->PRJ_SpecsToPrint_as;->PRJ_SpecsFromPrint_as;->PRJ_PlansToPrint_as;->PRJ_PlansFromPrint_as;->PRJ_ToCashier_as)
		// reduced to planst to print and toCashier
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_PlansToPrint_as; ->PRJ_ToCashier_as)
		NumberOfRowsPerFetch_l:=500
	: ($SQLName_txt="sp_RTRVConstCompany")
		SQL_Select:=Replace string:C233(SQL_Select; "[PRJ_ConstructionProject]CP_ConstructionContractNo_s"; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5)
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_CPCompanyNameID_al; ->PRJ_CPCompanyName_atxt)
		
	: ($SQLName_txt="sp_RetrieveVendorID")
		SQL_Select:=Replace string:C233(SQL_Select; "[PRJ_Contractor]CTR_ContractorID_l"; String:C10([PRJ_Contractor:114]CTR_ContractorID_l:1))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_CPVendorCode_atxt)
		
	: ($SQLName_txt="sp_RTRVPO_EstOpen_Dt")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_PROJECT_NO_al; ->PRJ_OfficeEst_ar; ->PRJ_BidOpenedDate_atxt)
		
		
	: ($SQLName_txt="sp_RTRVFisclCntTotal")  //is this used
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_RetrievedAmounts_atxt)
		
	: ($SQLName_txt="sp_RTRVDesCtrFedAid")
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID"; String:C10(PRJ_RTRV_ContractID_L))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_RetrievedFedAids_atxt)
		
	: ($SQLName_txt="sp_RetrieveEncumberedAmount@")  //is this used
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID"; String:C10(CTR_Contract_NO_ID_al{1}))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_retrievedAmounts_ar)
	: ($SQLName_txt="sp_RetrieveSpentAmount@")  //is this used
		SQL_Select:=Replace string:C233(SQL_Select; "SQL_ContractID"; String:C10(CTR_Contract_NO_ID_al{1}))
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_retrievedAmounts_ar)
	: ($SQLName_txt="sp_RTRVContractID")
		SQL_Select:=Replace string:C233(SQL_Select; "[PRJ_DesignContracts]DC_DesignContractNumber_l"; PRJ_RTRV_ContractNo_txt)
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->CTR_Contract_NO_ID_al)
	: ($SQLName_txt="sp_VW_PRJ_PROJECT")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_PROJECT_NO_al; ->PRJFileAdDate_atxt; ->PRJ_AdCost_ar; ->PRJ_FedPartCost_ar; ->PRJTipYear_atxt; ->PRJ_TipCost_ar; ->PRJ_BidOpenedDate_atxt; ->PRJ_OfficeEst_ar; ->PRJ_TypeCode_as; ->PRJ_Description_atxt)
		NumberOfRowsPerFetch_l:=500
		
	: ($SQLName_txt="sp_RTRVAttributes")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_AttributeID_al; ->PRJ_AttributeName_atxt; ->PRJ_AttributeDesc_atxt; ->PRJ_CreatedDate_atxt; ->PRJ_ModifiedDate_atxt)
		NumberOfRowsPerFetch_l:=100
		
	: ($SQLName_txt="sp_VW_PRJ_TASKEVENTS")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_PROJECT_NO_al; ->PRJ_TASK_TYPE_CODE_atxt; ->PRJ_EVENT_TYPE_DESC_atxt; ->PRJ_EVENT_ORDER_aL; ->PRJ_EVENT_DATE_atxt)
		NumberOfRowsPerFetch_l:=500
		
	: ($SQLName_txt="sp_RTRVProjTypes")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_AttributeName_atxt; ->PRJ_AttributeDesc_atxt; ->PRJ_CreatedDate_atxt; ->PRJ_ModifiedDate_atxt)
		NumberOfRowsPerFetch_l:=100
		
	: ($SQLName_txt="sp_RTRVPRJAttributes")
		SQL_Select:=Replace string:C233(SQL_Select; "ATTR_ID_in_Selection"; ATTR_ID_in_Selection_txt)
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_PROJECT_NO_al; ->PRJ_AttributeID_al; ->PRJ_CreatedDate_atxt)
		NumberOfRowsPerFetch_l:=500
	: ($SQLName_txt="sp_RTRVPRJ_Bridge")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PRJ_BDEPT_atxt; ->PRJ_PROJECT_NO_al)
		NumberOfRowsPerFetch_l:=500
	: ($SQLName_txt="sp_RTRV_PontisMetric")  //one of these for each stored proc to be run
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PM_BRKey_atxt; ->PM_SCKey_as; ->PM_TEV_ar)
		NumberOfRowsPerFetch_l:=15000
		SQL_Select:=Replace string:C233(SQL_Select; "?"; "BQ")
	: ($SQLName_txt="sp_RTRV_Metricdata")  //one of these for each stored proc to be run
		//ykey, hindex, adt, ptindex, cix_supr, cix_sub, cix_joint, cix_bear
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->PM_YKey_al; ->PM_Hindex_ar; ->PM_ADT_al; ->PM_PTIndex_ar; ->PM_CIX_Supr_ar; ->PM_CIX_Sub_ar; ->PM_CIX_Joint_ar; ->PM_CIX_Bear_ar; ->PM_CIX_Deck_ar)
		NumberOfRowsPerFetch_l:=PM_NumberofRows_l
		SQL_Select:=Replace string:C233(SQL_Select; "?"; "BQ")
		SQL_Select:=Replace string:C233(SQL_Select; "brkey_data"; PM_BRKey_txt)
		
	: ($SQLName_txt="sp_RTRVAEContData")
		
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->AE_Item_No_as; ->AE_Units_as; ->AE_ItemDescpt_atxt; ->AE_CONTQ_ar; ->AE_CONTR_Price_ar)
		NumberOfRowsPerFetch_l:=50
		SQL_Select:=Replace string:C233(SQL_Select; "?"; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5)
		
	: ($SQLName_txt="sp_RTRVAEContractNo")
		SQL_Direct_ReturnArrays(->$SQL_SelectArrays_txt; ->AE_ContractNumber_as; ->AE_FileNumber_al; ->AE_LOCATION_atxt; ->AE_ContractDescpt_atxt)
		NumberOfRowsPerFetch_l:=1500
		
End case 


If (4DError_b)
Else 
	SQLError_b:=False:C215
	ON ERR CALL:C155("SQL_ERROR")
	
	C_TEXT:C284($sqlStmt_txt)
	If (SQL_Select#"")
		$sqlStmt_txt:=" SQL EXECUTE(SQL_Select; "+$SQL_SelectArrays_txt+")"
		EXECUTE FORMULA:C63($sqlStmt_txt)
		Case of 
			: (NumberOfRowsPerFetch_l>0)
				While (Not:C34(SQL End selection:C821))
					SQL LOAD RECORD:C822(NumberOfRowsPerFetch_l)
				End while 
			Else 
				While (Not:C34(SQL End selection:C821))
					SQL LOAD RECORD:C822(SQL all records:K49:10)
				End while 
		End case 
		
		SQL CANCEL LOAD:C824
	End if 
End if 

ON ERR CALL:C155($currentErrCall_txt)
Case of 
	: ($SQLName_txt="sp_RTRVAEContData")
	: ($SQLName_txt="sp_RTRVConstCompany")
	: ($SQLName_txt="sp_RTRV_MMARSTotal")
	: ($SQLName_txt="sp_RTRV_MMARSSpent")
	: ($SQLName_txt="sp_RTRV_EXPSCTotal")
	: ($SQLName_txt="sp_RTRV_EXPSCSpent")
	: ($SQLName_txt="sp_RTRV_MMARSAccept")
	: ($SQLName_txt="sp_RTRV_MMARSPay")
	: ($SQLName_txt="sp_RTRV_MMARSBFYAMT")
	: ($SQLName_txt="sp_RTRVContractID")
	: ($SQLName_txt="sp_RTRVDesCtrFedAid")
		
	Else 
		
		ARRAY TEXT:C222($Results_atxt; 0)
		ut_NewTextToArray($SQL_SelectArrays_txt; ->$Results_atxt; ";")
		
		C_LONGINT:C283($loop_L)
		
		C_TEXT:C284($Result_txt; $ConvertArraysToCSV_txt)
		$ConvertArraysToCSV_txt:=""
		For ($loop_L; 1; Size of array:C274($Results_atxt))
			
			$ConvertArraysToCSV_txt:=$ConvertArraysToCSV_txt+"->"+$Results_atxt{$loop_L}+";"
			
		End for 
		
		$ConvertArraysToCSV_txt:=Substring:C12($ConvertArraysToCSV_txt; 1; Length:C16($ConvertArraysToCSV_txt)-1)
		
		$ConvertArraysToCSV_txt:="v_1_001_txt:=ut_ArraysToText("+Char:C90(Double quote:K15:41)+","+Char:C90(Double quote:K15:41)+";"+$ConvertArraysToCSV_txt+")"
		
		EXECUTE FORMULA:C63($ConvertArraysToCSV_txt)
		C_TEXT:C284($Path_txt; $FolderName_txt)
		
		$Path_txt:=ut_PRJ_CreateFolderPath("CSV_OutPut")
		
		
		C_TEXT:C284($FileName_txt)
		$FileName_txt:=$SQLName_txt+"-"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178; "a")+".csv"
		C_TIME:C306($Doc_tm)
		$Doc_tm:=Create document:C266($Path_txt+$FileName_txt)
		CLOSE DOCUMENT:C267($Doc_tm)
		TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; v_1_001_txt; UTF8 text without length:K22:17)
End case 
If (4DError_b) | (SQLError_b)
	$0:=False:C215
Else 
	$0:=True:C214
End if 
//End SQL_Direct