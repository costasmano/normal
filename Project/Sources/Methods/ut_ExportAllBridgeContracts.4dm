//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/08, 12:54:16
	// ----------------------------------------------------
	// Method: ut_ExportAllBridgeContracts
	// Description
	//  `Export the contract info from ut_RetrieveAllBridgeContracts to a tab delim text file
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_BLOB:C604($ContractData_blb)
SHORT_MESSAGE("Extracting Data...")
$ContractData_blb:=ut_RetrieveAllBridgeContracts
CLOSE WINDOW:C154

ARRAY TEXT:C222($ContractNo_atxt; 0)
ARRAY TEXT:C222($ConsltName_atxt; 0)
ARRAY TEXT:C222($ConsltNamePinfo_atxt; 0)
ARRAY TEXT:C222($ConsltAddr_atxt; 0)
ARRAY TEXT:C222($ConsltPhone_atxt; 0)
ARRAY TEXT:C222($ConsltEmail_atxt; 0)
ARRAY TEXT:C222($ConsltContact_atxt; 0)
ARRAY DATE:C224($AwardDate_aD; 0)
ARRAY DATE:C224($InitComplDate_aD; 0)
ARRAY DATE:C224($ExtenComplDate_aD; 0)
ARRAY TEXT:C222($Status_atxt; 0)
ARRAY TEXT:C222($ContrType_atxt; 0)
ARRAY TEXT:C222($ContrTypePinfo_atxt; 0)
ARRAY TEXT:C222($ContrDesc_atxt; 0)
ARRAY TEXT:C222($FedAid_atxt; 0)
ARRAY TEXT:C222($ProjMgr_atxt; 0)
ARRAY TEXT:C222($ProjMgrPInfo_atxt; 0)
ARRAY REAL:C219($TotFundEnc_ar; 0)
ARRAY REAL:C219($TotFundApproxRem_ar; 0)
ARRAY TEXT:C222($ProjNumbers_atxt; 0)
ARRAY LONGINT:C221($NumAssign_aL; 0)
ARRAY LONGINT:C221($NumInvoice_aL; 0)
ARRAY LONGINT:C221($NumInvoiceAcc_aL; 0)
ARRAY REAL:C219($TotAmtInvoice_ar; 0)
ARRAY REAL:C219($TotAmtPaid_ar; 0)

C_LONGINT:C283($offset_L)
$offset_L:=0
C_TEXT:C284(<>EXPCONTRACTOUTPUT_txt)
C_TIME:C306($exportDoc_t)
If (<>EXPCONTRACTOUTPUT_txt#"")
	SET TEXT TO PASTEBOARD:C523(<>EXPCONTRACTOUTPUT_txt)
End if 
$exportDoc_t:=Create document:C266(""; "TEXT")
If (OK=1)
	<>EXPCONTRACTOUTPUT_txt:=Document
	Startup_PL
	Characters
	C_TEXT:C284($ExportLine_txt; $CostFmt_txt)
	C_LONGINT:C283($DateFmt_L)
	$CostFmt_txt:="$###,###,###,##0.##"
	$DateFmt_L:=Internal date short:K1:7
	$ExportLine_txt:="ContractNo"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ContractNoAccess"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ConsltName"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ConsltName-Pinfo"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ConsltAddr"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ConsltPhone"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ConsltEmail"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ConsltContact"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"AwardDate"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"InitComplDate"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ExtenComplDate"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"Status"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ContrType"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ContrType-Pinfo"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ContrDesc"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"FedAid"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ProjMgr"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ProjMgr-Pinfo"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"TotFundEnc"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"TotFundApproxRem"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"ProjectNumbers"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"NumAssign"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"NumInvoice"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"NumInvoiceAcc"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"TotAmtInvoice"+<>sTAB
	$ExportLine_txt:=$ExportLine_txt+"TotAmtPaid"+<>sCR
	
	SEND PACKET:C103($exportDoc_t; $ExportLine_txt)
	C_TEXT:C284($ContrURL_txt; $ContrURLCurr_txt)
	$ContrURL_txt:=ut_GetSysParameter("URL_GotoContrNo")
	
	BLOB TO VARIABLE:C533($ContractData_blb; $ContractNo_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ConsltName_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ConsltNamePinfo_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ConsltAddr_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ConsltPhone_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ConsltEmail_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ConsltContact_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $AwardDate_aD; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $InitComplDate_aD; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ExtenComplDate_aD; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $Status_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ContrType_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ContrTypePinfo_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ContrDesc_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $FedAid_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ProjMgr_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ProjMgrPInfo_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $TotFundEnc_ar; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $TotFundApproxRem_ar; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $ProjNumbers_atxt; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $NumAssign_aL; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $NumInvoice_aL; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $NumInvoiceAcc_aL; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $TotAmtInvoice_ar; $offset_L)
	BLOB TO VARIABLE:C533($ContractData_blb; $TotAmtPaid_ar; $offset_L)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($ContractNo_atxt))
		$ContrURLCurr_txt:=Replace string:C233($ContrURL_txt; "<vContrNo_txt>"; $ContractNo_atxt{$i})
		$ExportLine_txt:="=HYPERLINK("+<>sQU+$ContrURLCurr_txt+<>sQU+","+$ContractNo_atxt{$i}+")"+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ContractNo_atxt{$i}+"#"+$ContrURLCurr_txt+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ConsltName_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ConsltNamePinfo_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ConsltAddr_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ConsltPhone_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ConsltEmail_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ConsltContact_atxt{$i}+<>sTAB
		If ($AwardDate_aD{$i}#!00-00-00!)
			$ExportLine_txt:=$ExportLine_txt+String:C10($AwardDate_aD{$i}; $DateFmt_L)+<>sTAB
		Else 
			$ExportLine_txt:=$ExportLine_txt+<>sTAB
		End if 
		If ($InitComplDate_aD{$i}#!00-00-00!)
			$ExportLine_txt:=$ExportLine_txt+String:C10($InitComplDate_aD{$i}; $DateFmt_L)+<>sTAB
		Else 
			$ExportLine_txt:=$ExportLine_txt+<>sTAB
		End if 
		If ($ExtenComplDate_aD{$i}#!00-00-00!)
			$ExportLine_txt:=$ExportLine_txt+String:C10($ExtenComplDate_aD{$i}; $DateFmt_L)+<>sTAB
		Else 
			$ExportLine_txt:=$ExportLine_txt+<>sTAB
		End if 
		$ExportLine_txt:=$ExportLine_txt+$Status_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ContrType_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ContrTypePinfo_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ContrDesc_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$FedAid_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ProjMgr_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ProjMgrPInfo_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+String:C10($TotFundEnc_ar{$i}; $CostFmt_txt)+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+String:C10($TotFundApproxRem_ar{$i}; $CostFmt_txt)+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+$ProjNumbers_atxt{$i}+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+String:C10($NumAssign_aL{$i})+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+String:C10($NumInvoice_aL{$i})+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+String:C10($NumInvoiceAcc_aL{$i})+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+String:C10($TotAmtInvoice_ar{$i}; $CostFmt_txt)+<>sTAB
		$ExportLine_txt:=$ExportLine_txt+String:C10($TotAmtPaid_ar{$i}; $CostFmt_txt)+<>sCR
		
		SEND PACKET:C103($exportDoc_t; $ExportLine_txt)
		
	End for 
	
	CLOSE DOCUMENT:C267($exportDoc_t)
	//_ O _SET DOCUMENT CREATOR(Document;"????")
End if 

SET BLOB SIZE:C606($ContractData_blb; 0)

ARRAY TEXT:C222($ContractNo_atxt; 0)
ARRAY TEXT:C222($ConsltName_atxt; 0)
ARRAY TEXT:C222($ConsltNamePinfo_atxt; 0)
ARRAY TEXT:C222($ConsltAddr_atxt; 0)
ARRAY TEXT:C222($ConsltPhone_atxt; 0)
ARRAY TEXT:C222($ConsltEmail_atxt; 0)
ARRAY TEXT:C222($ConsltContact_atxt; 0)
ARRAY DATE:C224($AwardDate_aD; 0)
ARRAY DATE:C224($InitComplDate_aD; 0)
ARRAY DATE:C224($ExtenComplDate_aD; 0)
ARRAY TEXT:C222($Status_atxt; 0)
ARRAY TEXT:C222($ContrType_atxt; 0)
ARRAY TEXT:C222($FedAid_atxt; 0)
ARRAY TEXT:C222($ProjMgr_atxt; 0)
ARRAY REAL:C219($TotFundEnc_ar; 0)
ARRAY REAL:C219($TotFundApproxRem_ar; 0)
ARRAY LONGINT:C221($NumAssign_aL; 0)
ARRAY LONGINT:C221($NumInvoice_aL; 0)
ARRAY LONGINT:C221($NumInvoiceAcc_aL; 0)
ARRAY REAL:C219($TotAmtInvoice_ar; 0)
ARRAY REAL:C219($TotAmtPaid_ar; 0)