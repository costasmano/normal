//%attributes = {"invisible":true}
// Method: Test_retrievVWProjectData
// Description
// test to retrieve prooject data from TISH same as "sp_prj_vw_project" call 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/10/19, 17:30:13
	// ----------------------------------------------------
	// First Release
	Mods_2019_06_bug
End if 

SQL LOGIN:C817(""; ""; ""; *)

If (OK=1)
	//Arrays used
	ARRAY LONGINT:C221(PRJ_PROJECT_NO_al; 0)
	ARRAY TEXT:C222(PRJFileAdDate_atxt; 0)
	ARRAY REAL:C219(PRJ_AdCost_ar; 0)
	ARRAY REAL:C219(PRJ_FedPartCost_ar; 0)
	ARRAY TEXT:C222(PRJTipYear_atxt; 0)
	ARRAY REAL:C219(PRJ_TipCost_ar; 0)
	ARRAY TEXT:C222(PRJ_BidOpenedDate_atxt; 0)
	ARRAY REAL:C219(PRJ_OfficeEst_ar; 0)
	ARRAY TEXT:C222(PRJ_TypeCode_as; 0)
	ARRAY TEXT:C222(PRJ_Description_atxt; 0)
	
	Begin SQL
		SELECT 
		PROJECT_NO , 
		CONVERT(varchar,ad_date,101) As 'AdDate',
		dbo.fnProjectAdCost(PROJECT_NO) As 'ProjAdCost' ,
		fed_part_cost ,
		tip_year, 
		tip_cost ,
		CONVERT(varchar,bid_opened,101) as 'BID_OPEN' , 
		office_est ,  
		PROJECT_TYPE_CODE, 
		DESCRIPTION As  'Description'
		from VW_PRJ_PROJECT 
		into 
		:PRJ_PROJECT_NO_al ,
		:PRJFileAdDate_atxt,
		:PRJ_AdCost_ar,
		:PRJ_FedPartCost_ar,
		:PRJTipYear_atxt,
		:PRJ_TipCost_ar,
		:PRJ_BidOpenedDate_atxt,
		:PRJ_OfficeEst_ar,
		:PRJ_TypeCode_as,
		:PRJ_Description_atxt ;
		
	End SQL
	
	
	If (False:C215)
		C_TEXT:C284($res_txt)
		
		$res_txt:=ut_ArraysToText(","; \
			->PRJ_PROJECT_NO_al; \
			->PRJFileAdDate_atxt; \
			->PRJ_AdCost_ar; \
			->PRJ_FedPartCost_ar; \
			->PRJTipYear_atxt; \
			->PRJ_TipCost_ar; \
			->PRJ_BidOpenedDate_atxt; \
			->PRJ_OfficeEst_ar; \
			->PRJ_TypeCode_as; \
			->PRJ_Description_atxt)
		
		ARRAY TEXT:C222($PRJ_Description_atxt; 0)
		C_TEXT:C284($doc_txt)
		$doc_txt:=Select document:C905(""; ".csv"; "Pick a CSV file"; File name entry:K24:17; $PRJ_Description_atxt)
		$doc_txt:=$PRJ_Description_atxt{1}
		TEXT TO DOCUMENT:C1237($doc_txt; $res_txt)
		SHOW ON DISK:C922($doc_txt)
		
	End if 
	
	SQL LOGOUT:C872
	
End if 