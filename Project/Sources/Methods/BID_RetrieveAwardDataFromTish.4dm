//%attributes = {"invisible":true}
// Method: BID_RetrieveAwardDataFromTish
// Description
//  ` retrieve awarded bridge projects form Tish based on a federal fiscal year - meant to be run interactively
//  ` parse the list to get rid of 'duplicate' lines'
//  ` for each bridge-projinfo-contrno combination retrueve the appropriate bid items - asemble in one array
//  ` save the bid items to a text file
//  ` save needed bridge information to a text file
//  ` save the info retrieved from TISH to a text file
//  ` the text files can be imported into Excel for further processing.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 12/29/16, 15:01:25
	// ----------------------------------------------------
	// First Release
	
	// Modified by: Costas Manousakis-(Designer)-(2/5/19 17:21:12)
	Mods_2019_02_bug
	//  `changed all vars used in the SQL calls to process variables - otherwise did not work compiled
End if 


SQL LOGIN:C817(""; ""; ""; *)

If (OK=1)
	
	ARRAY TEXT:C222(Bdepts_atxt; 0)
	ARRAY LONGINT:C221(CONTRACT_ID_aL; 0)
	ARRAY LONGINT:C221(PROJECT_NO_aL; 0)
	ARRAY TEXT:C222(ITEM_NO_Atxt; 0)
	ARRAY TEXT:C222(UNIT_OF_MEASUREMENT_atxt; 0)
	ARRAY REAL:C219(ITEM_PROJECTED_QUANTITY_ar; 0)
	ARRAY REAL:C219(ITEM_BID_QUANTITY_ar; 0)
	ARRAY REAL:C219(UNIT_PRICE_ar; 0)
	ARRAY LONGINT:C221(CONTRACT_NO_aL; 0)
	ARRAY TEXT:C222(AWARD_DATE_aD; 0)
	ARRAY TEXT:C222(ACTUAL_NTP_DATE_aD; 0)
	ARRAY TEXT:C222(CONTRACT_DESCPT_atxt; 0)
	ARRAY TEXT:C222(DESCRIPTION_atxt; 0)
	ARRAY TEXT:C222(CHILD_NAME_atxt; 0)
	ARRAY TEXT:C222(MODIFIED_DATE_ad; 0)
	ARRAY TEXT:C222(BID_OPEN_DATE_ad; 0)
	C_TEXT:C284(startDate_txt; EndDate_txt)
	
	C_TEXT:C284($FFYYear_txt)
	$FFYYear_txt:=String:C10(Year of:C25(Current date:C33(*)))
	$FFYYear_txt:=Request:C163("Choose Federal Fiscal Year"; $FFYYear_txt)
	
	//  // startDate_txt:="2015.10.01"
	//  // EndDate_txt:="2016.10.01"
	EndDate_txt:=$FFYYear_txt+".10.01"
	startDate_txt:=String:C10(Num:C11($FFYYear_txt)-1)+".10.01"
	
	Begin SQL
		SELECT  
		dbo.TBL_PRJ_PROJECT_BRIDGE.BDEPT,  
		dbo.TBL_CONSTRUCTION_VALID_ITEM.CONTRACT_ID, 
		dbo.TBL_CONTRACT_PROJECT.PROJECT_NO, 
		dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO, 
		dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT,
		dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_PROJECTED_QUANTITY, 
		dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_BID_QUANTITY, 
		dbo.TBL_CONSTRUCTION_VALID_ITEM.UNIT_PRICE, 
		dbo.TBL_CONTRACT.CONTRACT_NO, 
		cast( dbo.TBL_CONTRACT.AWARD_DATE as date) 'awarddate' ,
		cast( dbo.TBL_CONTRACT.ACTUAL_NTP_DATE as date) 'actualntp' ,
		dbo.TBL_CONTRACT.CONTRACT_DESCPT, 
		dbo.TBL_CONSTRUCTION_VALID_ITEM.DESCRIPTION, 
		dbo.VIEW_CONTRACT_VENDOR.CHILD_NAME,
		cast(dbo.TBL_CONSTRUCTION_VALID_ITEM.MODIFIED_DATE as date) 'modDate',
		cast(dbo.TBL_CONTRACT_BID_INFORMATION.BID_OPEN_DATE as date) 'BidOpenDate'
		
		FROM            dbo.TBL_CONTRACT_PROJECT INNER JOIN
		dbo.TBL_CONSTRUCTION_VALID_ITEM ON dbo.TBL_CONTRACT_PROJECT.CONTRACT_ID = dbo.TBL_CONSTRUCTION_VALID_ITEM.CONTRACT_ID INNER JOIN
		dbo.TBL_PRJ_PROJECT_BRIDGE ON dbo.TBL_CONTRACT_PROJECT.PROJECT_NO = dbo.TBL_PRJ_PROJECT_BRIDGE.PROJECT_NO INNER JOIN
		dbo.TBL_LU_ITEM_MEASUREMENT_UNIT ON 
		dbo.TBL_CONSTRUCTION_VALID_ITEM.UNIT_OF_MEASUREMENT_ID = dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT_ID INNER JOIN
		dbo.TBL_CONTRACT ON dbo.TBL_CONTRACT_PROJECT.CONTRACT_ID = dbo.TBL_CONTRACT.CONTRACT_ID INNER JOIN
		dbo.VIEW_CONTRACT_VENDOR ON dbo.TBL_CONTRACT_PROJECT.CONTRACT_ID = dbo.VIEW_CONTRACT_VENDOR.CONTRACT_ID INNER JOIN
		dbo.TBL_CONTRACT_BID_INFORMATION ON dbo.TBL_CONTRACT.CONTRACT_ID = dbo.TBL_CONTRACT_BID_INFORMATION.CONTRACT_ID
		WHERE        (dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO LIKE '995.%') AND (convert(varchar,dbo.TBL_CONTRACT.AWARD_DATE,102) >= '2017.09.30' ) AND 
		(convert(varchar, dbo.TBL_CONTRACT.AWARD_DATE,102) <  '2018.10.01' )
		/* */
		ORDER BY convert(varchar, dbo.TBL_CONTRACT.AWARD_DATE, 101) DESC, dbo.TBL_CONTRACT.CONTRACT_NO ASC, dbo.TBL_PRJ_PROJECT_BRIDGE.BDEPT ASC
		
		Into 
		
		:Bdepts_atxt ,
		:CONTRACT_ID_aL ,
		:PROJECT_NO_aL ,
		:ITEM_NO_Atxt ,
		:UNIT_OF_MEASUREMENT_atxt ,
		:ITEM_PROJECTED_QUANTITY_ar ,
		:ITEM_BID_QUANTITY_ar ,
		:UNIT_PRICE_ar ,
		:CONTRACT_NO_aL ,
		:AWARD_DATE_aD ,
		:ACTUAL_NTP_DATE_aD,
		:CONTRACT_DESCPT_atxt ,
		:DESCRIPTION_atxt ,
		:CHILD_NAME_atxt ,
		:MODIFIED_DATE_ad ,
		:BID_OPEN_DATE_ad  
		;
	End SQL
	ALERT:C41("Found "+String:C10(Size of array:C274(Bdepts_atxt))+" entries")
	
	C_LONGINT:C283($loop_L)
	ARRAY TEXT:C222($BdeptsResult_atxt; 0)
	ARRAY LONGINT:C221($ProjNumResult_aL; 0)
	ARRAY LONGINT:C221($ContractNumResult_aL; 0)
	ARRAY LONGINT:C221($ContractIDResult_aL; 0)
	ARRAY TEXT:C222($ComboResults_atxt; 0)
	ARRAY TEXT:C222($ComboKey_atxt; Size of array:C274(Bdepts_atxt))
	For ($loop_L; 1; Size of array:C274(Bdepts_atxt))
		$ComboKey_atxt{$loop_L}:=Bdepts_atxt{$loop_L}+String:C10(PROJECT_NO_aL{$loop_L}; "0000000000")+String:C10(CONTRACT_NO_aL{$loop_L}; "0000000000")+String:C10(CONTRACT_ID_aL{$loop_L}; "0000000000")
	End for 
	
	APPEND TO ARRAY:C911($ComboResults_atxt; $ComboKey_atxt{1})
	APPEND TO ARRAY:C911($BdeptsResult_atxt; Bdepts_atxt{1})
	APPEND TO ARRAY:C911($ProjNumResult_aL; PROJECT_NO_aL{1})
	APPEND TO ARRAY:C911($ContractNumResult_aL; CONTRACT_NO_aL{1})
	APPEND TO ARRAY:C911($ContractIDResult_aL; CONTRACT_ID_aL{1})
	
	For ($loop_L; 2; Size of array:C274(Bdepts_atxt))
		
		If (Find in array:C230($ComboResults_atxt; $ComboKey_atxt{$loop_L})>0)
		Else 
			APPEND TO ARRAY:C911($ComboResults_atxt; $ComboKey_atxt{$loop_L})
			APPEND TO ARRAY:C911($BdeptsResult_atxt; Bdepts_atxt{$loop_L})
			APPEND TO ARRAY:C911($ProjNumResult_aL; PROJECT_NO_aL{$loop_L})
			APPEND TO ARRAY:C911($ContractNumResult_aL; CONTRACT_NO_aL{$loop_L})
			APPEND TO ARRAY:C911($ContractIDResult_aL; CONTRACT_ID_aL{$loop_L})
		End if 
		
	End for 
	ALERT:C41("Result is "+String:C10(Size of array:C274($BdeptsResult_atxt))+" bridge projects")
	
	SORT ARRAY:C229($ComboResults_atxt; $BdeptsResult_atxt; $ProjNumResult_aL; $ContractNumResult_aL; $ContractIDResult_aL; >)
	
	ARRAY TEXT:C222($BDEPTInfo_atxt; 0)
	ARRAY TEXT:C222($BDEPT_ItemLines_atxt; 0)
	READ ONLY:C145(*)
	//now get the items for each of the projects and info for each bridge
	
	For ($loop_L; 1; Size of array:C274($BdeptsResult_atxt))
		// ******
		//First the appropriate BiD Items
		// ******
		ARRAY TEXT:C222(ItemNo_atxt; 0)
		ARRAY TEXT:C222(Unit_atxt; 0)
		ARRAY TEXT:C222(Descr_atxt; 0)
		ARRAY REAL:C219(ItemQ_ar; 0)
		ARRAY REAL:C219(UnitPrice_ar; 0)
		
		C_LONGINT:C283(ContrID_L)
		ContrID_L:=$ContractNumResult_aL{$loop_L}
		Begin SQL
			
			SELECT [TISH].[dbo].[TBL_CONSTRUCTION_VALID_ITEM].[ITEM_NO]
			, dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT
			,[TISH].[dbo].[TBL_CONSTRUCTION_VALID_ITEM].[DESCRIPTION]
			,[ITEM_BID_QUANTITY]
			,[UNIT_PRICE]
			FROM [TISH].[dbo].[TBL_CONSTRUCTION_VALID_ITEM], dbo.TBL_CONTRACT, dbo.TBL_LU_ITEM_MEASUREMENT_UNIT
			where [TISH].[dbo].[TBL_CONSTRUCTION_VALID_ITEM].[CONTRACT_ID] =  dbo.TBL_CONTRACT.CONTRACT_ID
			and [TISH].[dbo].[TBL_CONSTRUCTION_VALID_ITEM].[UNIT_OF_MEASUREMENT_ID] = dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT_ID
			and dbo.TBL_CONTRACT.CONTRACT_NO = :ContrID_L
			and dbo.TBL_LU_ITEM_MEASUREMENT_UNIT.UNIT_OF_MEASUREMENT not like ' '
			and
			(
			(
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '90%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '10%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '11%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '17%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '18%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '19%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '127%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '128%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '129%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '2%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '3%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '40%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '41%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '42%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '43%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '44%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '45%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '47%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '48%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '49%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '5%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '8%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '121%' And  
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '7%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '98%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '95%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '991%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '993%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '994%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '999%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '992%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '93%' And 
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO Not Like '6%'
			) 
			or
			dbo.TBL_CONSTRUCTION_VALID_ITEM.ITEM_NO='901.' 
			)
			into 
			:ItemNo_atxt,
			:Unit_atxt,
			:Descr_atxt,
			:ItemQ_ar,
			:UnitPrice_ar
			;
			
			
		End SQL
		C_TEXT:C284($REs_txt)
		$REs_txt:=("Got "+String:C10(Size of array:C274(ItemNo_atxt))+" items for Bdept "+$BdeptsResult_atxt{$loop_L}+" Proj "+String:C10($ProjNumResult_aL{$loop_L})+"  contr "+String:C10($ContractNumResult_aL{$loop_L}))
		$REs_txt:=$REs_txt+" Awarded "+AWARD_DATE_aD{Find in array:C230(CONTRACT_NO_aL; $ContractNumResult_aL{$loop_L})}
		C_LONGINT:C283($pos995_L; $start_L)
		$start_L:=0
		C_TEXT:C284($Item995s_txt)
		$Item995s_txt:=""
		Repeat 
			$pos995_L:=Find in array:C230(ItemNo_atxt; "995@"; $start_L)
			
			If ($pos995_L>0)
				$Item995s_txt:=$Item995s_txt+Descr_atxt{$pos995_L}+Char:C90(13)
				$start_L:=$pos995_L+1
			End if 
			
		Until ($pos995_L<=0)
		$REs_txt:=$REs_txt+Char:C90(13)+$Item995s_txt
		ALERT:C41($REs_txt)
		
		C_LONGINT:C283($Item_L)
		C_TEXT:C284($Item_Line_txt)
		
		For ($Item_L; 1; Size of array:C274(ItemNo_atxt))
			$Item_Line_txt:=$BdeptsResult_atxt{$loop_L}+Char:C90(Tab:K15:37)+String:C10($ProjNumResult_aL{$loop_L})+Char:C90(Tab:K15:37)+Descr_atxt{$Item_L}+Char:C90(Tab:K15:37)+ItemNo_atxt{$Item_L}+Char:C90(Tab:K15:37)
			$Item_Line_txt:=$Item_Line_txt+Unit_atxt{$Item_L}+Char:C90(Tab:K15:37)+String:C10(UnitPrice_ar{$Item_L})+Char:C90(Tab:K15:37)+""+Char:C90(Carriage return:K15:38)
			APPEND TO ARRAY:C911($BDEPT_ItemLines_atxt; $Item_Line_txt)
		End for 
		
		// ******
		// the Brdge info
		// ******
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$BdeptsResult_atxt{$loop_L})
		ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3)
		C_TEXT:C284($BINInfo_txt)
		
		While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
			
			$BINInfo_txt:=[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]BIN:3+Char:C90(Tab:K15:37)+QR_Item26OnOff+Char:C90(Tab:K15:37)+String:C10([Bridge MHD NBIS:1]Item104:119)+Char:C90(Tab:K15:37)
			$BINInfo_txt:=$BINInfo_txt+[Bridge MHD NBIS:1]Item8 BridgeCat:207+Char:C90(Tab:K15:37)+String:C10([Bridge MHD NBIS:1]StructDef:103)+Char:C90(Tab:K15:37)
			$BINInfo_txt:=$BINInfo_txt+String:C10(Round:C94([Bridge MHD NBIS:1]Item49:93; 3))+Char:C90(Tab:K15:37)+String:C10(Round:C94([Bridge MHD NBIS:1]Item52:97; 3))+Char:C90(Tab:K15:37)
			$BINInfo_txt:=$BINInfo_txt+String:C10([Bridge MHD NBIS:1]FHWARecord:174)+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Item26:120+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Item7:65+Char:C90(Tab:K15:37)
			$BINInfo_txt:=$BINInfo_txt+[Bridge MHD NBIS:1]Item6A:63+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Town Name:175+Char:C90(Tab:K15:37)
			QUERY:C277([Bridge Design:75]; [Bridge Design:75]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			
			If (Records in selection:C76([Bridge Design:75])>0)
				ORDER BY:C49([Bridge Design:75]; [Bridge Design:75]BridgeDesignID:35; <)
				FIRST RECORD:C50([Bridge Design:75])
				$BINInfo_txt:=$BINInfo_txt+String:C10(Round:C94([Bridge Design:75]WideOutToOut:26; 3))+Char:C90(Tab:K15:37)+String:C10(Round:C94([Bridge Design:75]StructLength:43; 3))+Char:C90(Tab:K15:37)+String:C10(Round:C94([Bridge Design:75]ApproachSlabVolume:32; 3))
				$BINInfo_txt:=$BINInfo_txt+Choose:C955([Bridge Design:75]MetricUnit:38; "ME"; "")
				
			End if 
			$BINInfo_txt:=$BINInfo_txt+Char:C90(Carriage return:K15:38)
			APPEND TO ARRAY:C911($BDEPTInfo_atxt; $BINInfo_txt)
			NEXT RECORD:C51([Bridge MHD NBIS:1])
		End while 
		
	End for 
	
	SQL LOGOUT:C872
	C_TIME:C306($ItemsList_t)
	C_TEXT:C284($ItemsList_txt)
	$ItemsList_txt:=""
	C_BLOB:C604($Items_X)
	ALERT:C41("Save BID Item data")
	$ItemsList_t:=Create document:C266(""; ".txt")
	
	If (OK=1)
		$ItemsList_txt:=Document
		
		CLOSE DOCUMENT:C267($ItemsList_t)
		C_TEXT:C284($header_txt)
		$header_txt:="BDEPT"+Char:C90(Tab:K15:37)+"PROJFILENO"+Char:C90(Tab:K15:37)+"ItemDesc"+Char:C90(Tab:K15:37)+"ItemNo"+Char:C90(Tab:K15:37)+"Units"+Char:C90(Tab:K15:37)+"UnitPrice"+Char:C90(Tab:K15:37)+"BridgeQ"+Char:C90(Carriage return:K15:38)
		TEXT TO BLOB:C554($header_txt; $Items_X; UTF8 text without length:K22:17; *)
		For ($loop_L; 1; Size of array:C274($BDEPT_ItemLines_atxt))
			TEXT TO BLOB:C554($BDEPT_ItemLines_atxt{$loop_L}; $Items_X; UTF8 text without length:K22:17; *)
		End for 
		
		BLOB TO DOCUMENT:C526($ItemsList_txt; $Items_X)
		
	End if 
	ALERT:C41("Save Bridge Info data")
	$ItemsList_t:=Create document:C266(""; ".txt")
	If (OK=1)
		$ItemsList_txt:=Document
		
		CLOSE DOCUMENT:C267($ItemsList_t)
		SET BLOB SIZE:C606($Items_X; 0)
		C_TEXT:C284($header_txt)
		$header_txt:="BDEPT"+Char:C90(Tab:K15:37)+"BIN"+Char:C90(Tab:K15:37)+"OnOff"+Char:C90(Tab:K15:37)+"Item104"+Char:C90(Tab:K15:37)
		$header_txt:=$header_txt+"Owner"+Char:C90(Tab:K15:37)+"SD"+Char:C90(Tab:K15:37)
		$header_txt:=$header_txt+"I49"+Char:C90(Tab:K15:37)+"I52"+Char:C90(Tab:K15:37)+"FHWARecord"+Char:C90(Tab:K15:37)+"I26"+Char:C90(Tab:K15:37)
		$header_txt:=$header_txt+"Item 7"+Char:C90(Tab:K15:37)+"Item 6A"+Char:C90(Tab:K15:37)+"TownName"+Char:C90(Tab:K15:37)
		$header_txt:=$header_txt+"Wide out to out"+Char:C90(Tab:K15:37)+"Struct Len"+Char:C90(Tab:K15:37)+"Approach Slab Vol"+Char:C90(Tab:K15:37)+"MetricUnit"+Char:C90(Carriage return:K15:38)
		TEXT TO BLOB:C554($header_txt; $Items_X; UTF8 text without length:K22:17; *)
		For ($loop_L; 1; Size of array:C274($BDEPTInfo_atxt))
			TEXT TO BLOB:C554($BDEPTInfo_atxt{$loop_L}; $Items_X; UTF8 text without length:K22:17; *)
		End for 
		
		BLOB TO DOCUMENT:C526($ItemsList_txt; $Items_X)
		
	End if 
	ALERT:C41("Save Bridge Project data")
	$ItemsList_t:=Create document:C266(""; ".txt")
	
	If (OK=1)
		$ItemsList_txt:=Document
		CLOSE DOCUMENT:C267($ItemsList_t)
		SET BLOB SIZE:C606($Items_X; 0)
		C_TEXT:C284($header_txt)
		$header_txt:="BDEPT"+Char:C90(Tab:K15:37)+"CONTRACT_ID"+Char:C90(Tab:K15:37)+"ProjectNo"+Char:C90(Tab:K15:37)+"ItemNo"+Char:C90(Tab:K15:37)+"ContractNo"+Char:C90(Tab:K15:37)
		$header_txt:=$header_txt+"AwardDate"+Char:C90(Tab:K15:37)+"Actual_NTP_date"+Char:C90(Tab:K15:37)+"ContrDescr"+Char:C90(Tab:K15:37)
		$header_txt:=$header_txt+"ItemDescr"+Char:C90(Tab:K15:37)+"Contractor"+Char:C90(Carriage return:K15:38)
		TEXT TO BLOB:C554($header_txt; $Items_X; UTF8 text without length:K22:17; *)
		C_TEXT:C284($Line_txt; $BDEPTPattern_txt; $BDEPT_txt)
		$BDEPTPattern_txt:="([A-Z])[-]?([0-9]{2})[-]?([0-9]{3})"
		C_BOOLEAN:C305($printLine_b)
		For ($loop_L; 1; Size of array:C274(Bdepts_atxt))
			$printLine_b:=False:C215
			If (Match regex:C1019($BDEPTPattern_txt; DESCRIPTION_atxt{$loop_L}; 1))
				//if there is a bdept in the item check to see if BDEPT matches 
				$BDEPT_txt:=Substring:C12(Bdepts_atxt{$loop_L}; 1; 1)+"-"+Substring:C12(Bdepts_atxt{$loop_L}; 2; 2)+"-"+Substring:C12(Bdepts_atxt{$loop_L}; 4; 3)
				If (Position:C15($BDEPT_txt; DESCRIPTION_atxt{$loop_L})>0)
					$printLine_b:=True:C214
				Else 
					//don't print it
				End if 
				
			Else 
				$printLine_b:=True:C214
			End if 
			
			If ($printLine_b)
				$Line_txt:=Bdepts_atxt{$loop_L}+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+String:C10(CONTRACT_ID_aL{$loop_L})+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+String:C10(PROJECT_NO_aL{$loop_L})+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+ITEM_NO_Atxt{$loop_L}+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+String:C10(CONTRACT_NO_aL{$loop_L})+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+AWARD_DATE_aD{$loop_L}+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+ACTUAL_NTP_DATE_aD{$loop_L}+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+CONTRACT_DESCPT_atxt{$loop_L}+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+DESCRIPTION_atxt{$loop_L}+Char:C90(Tab:K15:37)
				$Line_txt:=$Line_txt+CHILD_NAME_atxt{$loop_L}+Char:C90(Carriage return:K15:38)
				
				TEXT TO BLOB:C554($Line_txt; $Items_X; UTF8 text without length:K22:17; *)
				
			End if 
			
		End for 
		
		BLOB TO DOCUMENT:C526($ItemsList_txt; $Items_X)
		
	End if 
	
	If ($ItemsList_txt#"")  //if we saved at least one doc show the last one
		SHOW ON DISK:C922($ItemsList_txt)
	End if 
	
	ARRAY TEXT:C222($BDEPT_ItemLines_atxt; 0)
	ARRAY TEXT:C222($BDEPTInfo_atxt; 0)
	SET BLOB SIZE:C606($Items_X; 0)
	
End if 