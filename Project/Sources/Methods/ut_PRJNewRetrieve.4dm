//%attributes = {"invisible":true}
READ WRITE:C146([Conslt Address:77])
READ WRITE:C146([Conslt_Name:127])
READ WRITE:C146([PRJ_DesignContracts:123])
READ WRITE:C146([PRJ_ProjectFile:117])
//CTR_Contract_No_al `[DesignContracts]DC_DesignContractNumber_l dbo.TBL_CONTRACT.CONTRACT_NO
//CTR_CONTRACT_DESC_atxt      `[DesignContracts]DC_Description_txt     dbo.TBL_CONTRACT.CONTRACT_DESCPT , 
//CTR_EST_Contract_Amt_ar      `[DesignContracts]DC_ESTContractAmt_r    dbo.TBL_CONTRACT.EST_CONTRACT_AMT , 
//CTR_EST_COMPL_DATE_atxt    `[DesignContracts]DC_EstComplete_d  CONVERT(varchar, dbo.TBL_CONTRACT.EST_COMPL_DATE, 101), 
//CTR_PROJECT_NO_al                `Used to query project file                                 dbo.TBL_CONTRACT_PROJECT.PROJECT_NO,  
//CTR_COMPL_DATE_atxt            `[DesignContracts]DC_Completion_d  CONVERT(varchar,  dbo.TBL_CONTRACT.COMPL_DATE, 101) ,  
//CTR_ContractType_atxt `Used to make sue we only process design contracts dbo.TBL_LU_CONTRACT_TYPES.CONTRACT_TYPE,  
//PRJ_ConsultantName_atxt `[Conslt_Name]ConsultantName_s `dbo.TBL_VENDORS.CONAME,
//PRJ_ConsultantID_al `[Conslt_Name]SQL_VendorID_l `dbo.TBL_VENDORS.VENDOR_ID 