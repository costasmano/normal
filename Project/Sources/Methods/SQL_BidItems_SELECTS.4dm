//%attributes = {"invisible":true}
// Method: SQL_BidItems_SELECTS
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/06/15, 12:18:38
	// ----------------------------------------------------
	// First Release
	Mods_2015_11
	
	C_TEXT:C284(SQL_BidItems_SELECTS; $0)
	C_TEXT:C284(SQL_BidItems_SELECTS; $1)
	
End if 

C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($sqlStmt_txt)
$sqlStmt_txt:=""
Case of 
	: ($1="Awarded")
		$sqlStmt_txt:=$sqlStmt_txt+"SELECT        dbo.TBL_PRJ_PROJECT_BRIDGE.BDEPT, dbo.TBL_PRJ_PROJECT_BRIDGE.PROJECT_NO, dbo.TBL_CONTRACT_PROJECT.CONTRACT_ID, "
		$sqlStmt_txt:=$sqlStmt_txt+"  dbo.TBL_CONTRACT.CONTRACT_NO, dbo.TBL_CONTRACT.AWARD_DATE "
		$sqlStmt_txt:=$sqlStmt_txt+"FROM            dbo.TBL_CONTRACT_PROJECT INNER JOIN "
		$sqlStmt_txt:=$sqlStmt_txt+"  dbo.TBL_PRJ_PROJECT_BRIDGE ON dbo.TBL_CONTRACT_PROJECT.PROJECT_NO = dbo.TBL_PRJ_PROJECT_BRIDGE.PROJECT_NO INNER JOIN "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.TBL_CONTRACT ON dbo.TBL_CONTRACT_PROJECT.CONTRACT_ID = dbo.TBL_CONTRACT.CONTRACT_ID "
		$sqlStmt_txt:=$sqlStmt_txt+"WHERE        (TBL_CONTRACT_PROJECT.CONTRACT_ID IN "
		$sqlStmt_txt:=$sqlStmt_txt+"  (SELECT        TBL_CONTRACT_1.CONTRACT_ID "
		$sqlStmt_txt:=$sqlStmt_txt+"FROM            dbo.TBL_CONTRACT AS TBL_CONTRACT_1 INNER JOIN  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.TBL_CONSTRUCTION_VALID_ITEM ON TBL_CONTRACT_1.CONTRACT_ID = dbo.TBL_CONSTRUCTION_VALID_ITEM.CONTRACT_ID  "
		$sqlStmt_txt:=$sqlStmt_txt+"WHERE        (dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO LIKE '995.%') AND (TBL_CONTRACT_1.AWARD_DATE >= CONVERT(DATETIME,   "
		$sqlStmt_txt:=$sqlStmt_txt+" '2014-10-01 00:00:00', 102)) AND (TBL_CONTRACT_1.AWARD_DATE < CONVERT(DATETIME, '2015-10-01 00:00:00', 102)))) "
		$sqlStmt_txt:=$sqlStmt_txt+"  "
		
	: ($1="ITEMS")
		
		$sqlStmt_txt:=$sqlStmt_txt+"SELECT  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.DESCRIPTION,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.ITEM_NO,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT,   "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.UNIT_PRICE,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.ITEM_BID_QUANTITY,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.CONTRACT_ID  "
		$sqlStmt_txt:=$sqlStmt_txt+"FROM  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item  "
		$sqlStmt_txt:=$sqlStmt_txt+" left join dbo.TBL_LU_ITEM_MEASUREMENT_UNIT on dbo.tbl_construction_valid_item.UNIT_OF_MEASUREMENT_ID = dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT_ID "
		$sqlStmt_txt:=$sqlStmt_txt+" "
		$sqlStmt_txt:=$sqlStmt_txt+"WHERE  "
		$sqlStmt_txt:=$sqlStmt_txt+" ( "
		$sqlStmt_txt:=$sqlStmt_txt+"  ( "
		$sqlStmt_txt:=$sqlStmt_txt+" dbo.tbl_construction_valid_item.ITEM_NO Not Like '90%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '10%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '11%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '17%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '18%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '19%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '127%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '128%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '129%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '2%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '3%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '40%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '41%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '42%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '43%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '44%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '45%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '47%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '48%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '49%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '5%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '8%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '121%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '7%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '98%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '95%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '991%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '993%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '994%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '999%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '992%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '93%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '6%' "
		$sqlStmt_txt:=$sqlStmt_txt+" )  "
		$sqlStmt_txt:=$sqlStmt_txt+"OR  "
		$sqlStmt_txt:=$sqlStmt_txt+" dbo.tbl_construction_valid_item.ITEM_NO='901.'  "
		$sqlStmt_txt:=$sqlStmt_txt+" ) "
		$sqlStmt_txt:=$sqlStmt_txt+" and dbo.tbl_construction_valid_item.CONTRACT_ID = :$ContrID_L  "
		$sqlStmt_txt:=$sqlStmt_txt+" "
		$sqlStmt_txt:=$sqlStmt_txt+"ORDER BY  dbo.tbl_construction_valid_item.ITEM_NO "
		$sqlStmt_txt:=$sqlStmt_txt+"; "
		
		
	: ($1="BRIDGEANDITEMS")
		
		$sqlStmt_txt:=$sqlStmt_txt+"SELECT  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.TBL_PRJ_PROJECT_BRIDGE.BDEPT,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_contract_project.PROJECT_NO,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.DESCRIPTION,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.ITEM_NO,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT,   "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.UNIT_PRICE,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.ITEM_BID_QUANTITY,  "
		//$sqlStmt_txt:=$sqlStmt_txt+"(dbo.tbl_construction_valid_item.ITEM_BID_QUANTITY*dbo.tbl_construction_valid_item.UNIT_PRICE) AS Item_Total,  "
		$sqlStmt_txt:=$sqlStmt_txt+"dbo.tbl_construction_valid_item.CONTRACT_ID  "
		$sqlStmt_txt:=$sqlStmt_txt+"FROM  "
		$sqlStmt_txt:=$sqlStmt_txt+"(dbo.tbl_construction_valid_item  "
		$sqlStmt_txt:=$sqlStmt_txt+"INNER JOIN dbo.tbl_contract_project ON dbo.tbl_construction_valid_item.CONTRACT_ID = dbo.tbl_contract_project.CONTRACT_ID) "
		$sqlStmt_txt:=$sqlStmt_txt+" LEFT JOIN dbo.TBL_PRJ_PROJECT_BRIDGE ON dbo.tbl_contract_project.PROJECT_NO = dbo.TBL_PRJ_PROJECT_BRIDGE.PROJECT_NO "
		$sqlStmt_txt:=$sqlStmt_txt+" left join dbo.TBL_LU_ITEM_MEASUREMENT_UNIT on dbo.tbl_construction_valid_item.UNIT_OF_MEASUREMENT_ID = dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT_ID "
		$sqlStmt_txt:=$sqlStmt_txt+" "
		$sqlStmt_txt:=$sqlStmt_txt+"WHERE  "
		$sqlStmt_txt:=$sqlStmt_txt+" ( "
		$sqlStmt_txt:=$sqlStmt_txt+"  ( "
		$sqlStmt_txt:=$sqlStmt_txt+" dbo.tbl_construction_valid_item.ITEM_NO Not Like '90%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '10%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '11%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '17%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '18%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '19%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '127%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '128%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '129%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '2%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '3%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '40%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '41%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '42%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '43%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '44%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '45%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '47%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '48%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '49%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '5%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '8%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '121%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '7%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '98%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '95%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '991%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '993%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '994%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '999%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '992%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '93%'  "
		$sqlStmt_txt:=$sqlStmt_txt+" And dbo.tbl_construction_valid_item.ITEM_NO Not Like '6%' "
		$sqlStmt_txt:=$sqlStmt_txt+" )  "
		$sqlStmt_txt:=$sqlStmt_txt+"OR  "
		$sqlStmt_txt:=$sqlStmt_txt+" dbo.tbl_construction_valid_item.ITEM_NO='901.'  "
		$sqlStmt_txt:=$sqlStmt_txt+" ) "
		$sqlStmt_txt:=$sqlStmt_txt+" and dbo.tbl_construction_valid_item.CONTRACT_ID = :$ContrID_L "
		$sqlStmt_txt:=$sqlStmt_txt+" "
		$sqlStmt_txt:=$sqlStmt_txt+"ORDER BY dbo.TBL_PRJ_PROJECT_BRIDGE.BDEPT, dbo.tbl_construction_valid_item.ITEM_NO "
		$sqlStmt_txt:=$sqlStmt_txt+"; "
		
End case 

$0:=$sqlStmt_txt