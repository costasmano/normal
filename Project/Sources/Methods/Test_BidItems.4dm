//%attributes = {"invisible":true}
SQL_UserName_s:="manousakisc"
SQL_Password_s:=""
SQL_ODBCName_s:="tisht"
SQL_DatabaseName_s:="Tisht"
C_BOOLEAN:C305(SQLError_b)
SQLError_b:=False:C215
ON ERR CALL:C155("SQL_error")

SQL LOGIN:C817("ODBC:"+"tisht"; "manousakisc"; "")

If (Not:C34(SQLError_b))
	ARRAY TEXT:C222($Results_atxt; 0)
	ARRAY TEXT:C222($BDEPTS_atxt; 0)
	ARRAY TEXT:C222($Item995_atxt; 0)
	ARRAY DATE:C224($awardd_ad; 0)
	ARRAY LONGINT:C221($ContractNo_aL; 0)
	ARRAY LONGINT:C221($ProjFileNo_aL; 0)
	ARRAY TEXT:C222($ContrDesc_atxt; 0)
	ARRAY TEXT:C222($ItemDesc_atxt; 0)
	ARRAY LONGINT:C221($projFile_atxt; 0)
	ARRAY LONGINT:C221($contrID_aL; 0)
	C_TEXT:C284($sqlStmt_txt)
	$sqlStmt_txt:=""
	
	If (False:C215)
		$sqlStmt_txt:=$sqlStmt_txt+"SELECT dbo.TBL_CONTRACT.CONTRACT_ID, dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO, dbo.TBL_CONTRACT.AWARD_DATE, dbo.TBL_CONTRACT.CONTRACT_NO, "
		$sqlStmt_txt:=$sqlStmt_txt+"  dbo.TBL_CONTRACT.CONTRACT_DESCPT, dbo.TBL_CONSTRUCTION_VALID_ITEM.DESCRIPTION "
		$sqlStmt_txt:=$sqlStmt_txt+"FROM dbo.TBL_CONTRACT INNER JOIN "
		$sqlStmt_txt:=$sqlStmt_txt+"  dbo.TBL_CONSTRUCTION_VALID_ITEM ON dbo.TBL_CONTRACT.CONTRACT_ID = dbo.TBL_CONSTRUCTION_VALID_ITEM.CONTRACT_ID "
		$sqlStmt_txt:=$sqlStmt_txt+"WHERE        (dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO LIKE '995.%') AND (dbo.TBL_CONTRACT.AWARD_DATE >= CONVERT(DATETIME, '2014-10-01 00:00:00', 102)) and "
		$sqlStmt_txt:=$sqlStmt_txt+"(dbo.TBL_CONTRACT.AWARD_DATE < CONVERT(DATETIME, '2015-10-01 00:00:00', 102))"
		ON ERR CALL:C155("SQL_error")
		
		SQL EXECUTE:C820($sqlStmt_txt; $contrID_aL; $Item995_atxt; $awardd_ad; $ContractNo_aL; $ContrDesc_atxt; $ItemDesc_atxt)
		While (Not:C34(SQL End selection:C821))
			SQL LOAD RECORD:C822(SQL all records:K49:10)
		End while 
		SQL CANCEL LOAD:C824
		If (SQLError_b)
			ut_DisplayArray(->SQL_InternalDescriptions_atxt; "List of errors"; "Error descr")
			ALERT:C41(" Errors!")
		End if 
		
	End if 
	
	$sqlStmt_txt:=SQL_BidItems_SELECTS("awarded")
	
	ON ERR CALL:C155("SQL_error")
	
	SQL EXECUTE:C820($sqlStmt_txt; $BDEPTS_atxt; $ProjFileNo_aL; $contrID_aL; $ContractNo_aL; $awardd_ad)
	While (Not:C34(SQL End selection:C821))
		SQL LOAD RECORD:C822(SQL all records:K49:10)
	End while 
	SQL CANCEL LOAD:C824
	If (SQLError_b)
		ut_DisplayArray(->SQL_InternalDescriptions_atxt; "List of errors"; "Error descr")
		ALERT:C41(" Errors!")
	Else 
		ARRAY TEXT:C222($Results_atxt; Size of array:C274($BDEPTS_atxt))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($BDEPTS_atxt))
			$Results_atxt{$loop_L}:=$BDEPTS_atxt{$loop_L}+" "+String:C10($ProjFileNo_aL{$loop_L})+" "+String:C10($ContractNo_aL{$loop_L})+" "+String:C10($awardd_ad{$loop_L})
		End for 
		ut_DisplayArray(->$Results_atxt; "Results"; "BDEPT ProjFileNo ContractNo AwardDate")
		
	End if 
	
	ARRAY TEXT:C222($IT_Bdept_atxt; 0)
	ARRAY LONGINT:C221($IT_ProjNo_aL; 0)
	ARRAY TEXT:C222($IT_Desc_atxt; 0)
	ARRAY TEXT:C222($IT_ItemNo_atxt; 0)
	ARRAY TEXT:C222($IT_unitofMeas_atxt; 0)
	ARRAY REAL:C219($IT_Price_ar; 0)
	ARRAY REAL:C219($IT_BidQ_ar; 0)
	ARRAY REAL:C219($IT_ItemTot_ar; 0)
	ARRAY LONGINT:C221($IT_ContrID_aL; 0)
	C_LONGINT:C283($ContrID_L; $ContrNo_L)
	$sqlStmt_txt:=SQL_BidItems_SELECTS("ITEMS")
	
	C_LONGINT:C283($contrLoop_L)
	For ($contrLoop_L; 1; Size of array:C274($contrID_aL))
		$ContrID_L:=$contrID_aL{$contrLoop_L}
		
		If (Find in array:C230($contrID_aL; $ContrID_L)<$contrLoop_L)
			//done this contract before
		Else 
			$ContrNo_L:=$ContractNo_aL{$contrLoop_L}
			SQL EXECUTE:C820($sqlStmt_txt; $IT_Desc_atxt; $IT_ItemNo_atxt; $IT_unitofMeas_atxt; $IT_Price_ar; $IT_BidQ_ar; $IT_ContrID_aL)
			While (Not:C34(SQL End selection:C821))
				SQL LOAD RECORD:C822(SQL all records:K49:10)
			End while 
			SQL CANCEL LOAD:C824
			If (SQLError_b)
				ut_DisplayArray(->SQL_InternalDescriptions_atxt; "List of errors"; "Error descr")
				ALERT:C41(" Errors!")
			Else 
				ARRAY TEXT:C222($Results_atxt; 0)
				ARRAY TEXT:C222($Results_atxt; Size of array:C274($IT_Desc_atxt))
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($IT_Desc_atxt))
					$Results_atxt{$loop_L}:=String:C10($loop_L)+" : "+$IT_ItemNo_atxt{$loop_L}+" "+$IT_Desc_atxt{$loop_L}+" "+$IT_unitofMeas_atxt{$loop_L}+" "+String:C10($IT_Price_ar{$loop_L})+" "+String:C10($IT_BidQ_ar{$loop_L})+" "+String:C10($IT_ContrID_aL{$loop_L})
					//$Results_atxt{$loop_L}:=String($loop_L)+" : "+$IT_Bdept_atxt{$loop_L}+" "+String($IT_ProjNo_aL{$loop_L})+" "+$IT_ItemNo_atxt{$loop_L}+" "+$IT_Desc_atxt{$loop_L}+" "+String($IT_Price_ar{$loop_L})+" "+String($IT_BidQ_ar{$loop_L})+" "+String($IT_ContrID_aL{$loop_L})+" "+String(Length($IT_unitofMeas_atxt{$loop_L}))
				End for 
				
				ut_DisplayArray(->$Results_atxt; "ContrID:"+String:C10($ContrID_L)+"  ContrNo:"+String:C10($ContrNo_L)+"  count:"+String:C10(Size of array:C274($IT_ItemNo_atxt)); "Item Desc UM Price Quantity ContrID")
				
			End if 
			
		End if 
		
	End for 
	
	ON ERR CALL:C155("")
	
	SQL LOGOUT:C872
	
End if 