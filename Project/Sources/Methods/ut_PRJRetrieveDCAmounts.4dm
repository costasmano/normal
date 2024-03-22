//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveDCAmounts
// User name (OS): cjmiller
// Date and time: 03/29/07, 16:31:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_PRJSELECTION
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	// Modified by: costasmanousakis-(Designer)-(12/16/08 11:31:06)
	Mods_2008_CM_5404("PRJDESRTRV")
	//changes in the Retrieve of design contracts -added Fed Aid numbers
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 15:50:12
	Mods_2009_07  //r003 `07/27/09, 10:34:49   `Fix errors when SQL calls fail
	// Modified by: costasmanousakis-(Designer)-(12/7/10 11:25:20)
	Mods_2010_12
	//  `instead of using [PRJ_DesignContracts]DC_DesignContractNumber_l and [PRJ_DesignContracts]DC_SQLContractID_l directly in the SQL_Fill.... methods
	//  `define process vars PRJ_RTRV_ContractNo_txt and PRJ_RTRV_ContractID_L.
	Mods_2011_01  //r001 CJ Miller`01/14/11, 11:28:21     
	//Add code to allow for retrieve of [PRJ_DesignContracts] amounts and
	//[PRJ_ConstructionProject] seperately
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_TEXT:C284($EOL)
C_TIME:C306($SQLDocument_tm)
C_BOOLEAN:C305($0)
$0:=True:C214
READ WRITE:C146([PRJ_DesignContracts:123])
QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_Completion_d:8=!00-00-00!; *)
QUERY:C277([PRJ_DesignContracts:123];  | ; [PRJ_DesignContracts:123]DC_Completion_d:8>Date:C102("1/1/"+String:C10(Year of:C25(Current date:C33(*))-5)))
C_LONGINT:C283($OuterLoop_l; $InnerLoop_l; $FiscalYear_l; $win; $NumberOfRecords_l)
FIRST RECORD:C50([PRJ_DesignContracts:123])
C_REAL:C285($ExpiredTotal_r; $EncumberedTotal_r; $SpentTotal_r)
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_DATE:C307($Begin_d; $End_d)
$FiscalYear_l:=Year of:C25(Current date:C33(*))
$Begin_d:=Date:C102("07/01/"+String:C10($FiscalYear_l))
$End_d:=Date:C102("12/31/"+String:C10($FiscalYear_l))
If (Current date:C33(*)>=$Begin_d) & (Current date:C33(*)<=$End_d)
	$FiscalYear_l:=$FiscalYear_l+1
End if 
PRJ_FiscalYear_s:=String:C10($FiscalYear_l)
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Design Contract Amounts")

//$win:=Open window(50;50;550;250;4;"")

$NumberOfRecords_l:=Records in selection:C76([PRJ_DesignContracts:123])
C_TIME:C306($StartTime_tm; $RemainingTime_tm)
$StartTime_tm:=Current time:C178(*)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve design contracts amounts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
C_LONGINT:C283($Counter_l; $Updated_l)
$Counter_l:=0
$Updated_l:=0
C_BOOLEAN:C305($RecordChanged_b)

C_LONGINT:C283(MMARSTotal_l; MMARSSpent_l; EXPSCTotal_l; EXPSCSpent_l; MMARSAccept_l; MMARSPay_l; MMARSBFYAMT_l)
MMARSTotal_l:=0
MMARSSpent_l:=0
EXPSCTotal_l:=0
EXPSCSpent_l:=0
MMARSAccept_l:=0
MMARSPay_l:=0
MMARSBFYAMT_l:=0
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Design Contract Amounts"; $NumberOfRecords_l; False:C215; ""; 3)
ARRAY LONGINT:C221($ContractIDs_aL; $NumberOfRecords_l)
ARRAY REAL:C219($PRJ_MMAR_Total_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSTotal
ARRAY REAL:C219($PRJ_MMAR_Spent_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSSpent
ARRAY REAL:C219($PRJ_EXPSCTotal_ar; $NumberOfRecords_l)  //sp_RTRV_EXPSCTotal
ARRAY REAL:C219($PRJ_EXPSCSpent_ar; $NumberOfRecords_l)  //sp_RTRV_EXPSCSpent
ARRAY REAL:C219($PRJ_MMAR_Accepted_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSAccept
ARRAY REAL:C219($PRJ_MMAR_Payed_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSPay
ARRAY REAL:C219($PRJ_MMAR_BFY_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSBFYAMT
ARRAY TEXT:C222($PRJ_RetrievedFedAids_atxt; 0)
ARRAY LONGINT:C221($FedAidContractIDs_aL; 0)

ARRAY TEXT:C222($PRJ_RTRV_ContractNo_atxt; 0)
ARRAY LONGINT:C221($RETContractIDs_aL; 0)
For ($OuterLoop_l; 1; $NumberOfRecords_l)
	$RecordChanged_b:=False:C215
	UpdateProgressNew($progressObj_o; $OuterLoop_l)
	//GOTO XY(5;2)
	//MESSAGE("Retrieving "+String($OuterLoop_l)+" out of "+String($NumberOfRecords_l))
	//GOTO XY(5;5)
	//$RemainingTime_tm:=(($NumberOfRecords_l/$OuterLoop_l)-1)*(Current time(*)-$StartTime_tm)
	//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
	//GOTO XY(5;7)
	//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
	
	ut_LoadRecord(->[PRJ_DesignContracts:123])
	C_TEXT:C284($XMLData_txt)
	C_BOOLEAN:C305($Continue_b)
	$Continue_b:=False:C215
	C_TEXT:C284(PRJ_RTRV_ContractNo_txt)
	PRJ_RTRV_ContractNo_txt:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
	Case of 
		: ([PRJ_DesignContracts:123]DC_SQLContractID_l:17>0)
			$Continue_b:=True:C214
		: (SQL_Direct("sp_RTRVContractID"))
			If (Size of array:C274(CTR_Contract_NO_ID_al)>0)
				If (CTR_Contract_NO_ID_al{1}>0)
					$RecordChanged_b:=True:C214
					[PRJ_DesignContracts:123]DC_SQLContractID_l:17:=CTR_Contract_NO_ID_al{1}
					$Continue_b:=True:C214
					APPEND TO ARRAY:C911($RETContractIDs_aL; [PRJ_DesignContracts:123]DC_SQLContractID_l:17)
					APPEND TO ARRAY:C911($PRJ_RTRV_ContractNo_atxt; PRJ_RTRV_ContractNo_txt)
					
				End if 
				
			Else 
				APPEND TO ARRAY:C911($RETContractIDs_aL; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)
				APPEND TO ARRAY:C911($PRJ_RTRV_ContractNo_atxt; "None retrieved for "+PRJ_RTRV_ContractNo_txt)
				
				PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"No row returned for contract  "+String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+$eol
				$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
				SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
				CLOSE DOCUMENT:C267($SQLDocument_tm)
				PRJ_SQLRetrieveStats_txt:=""
			End if 
		Else 
			
			PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVContractID Failed for "+"[PRJ_DesignContracts]DC_DesignContractNumber_l  "+String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+$eol
			PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	End case 
	//PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String([PRJ_DesignContracts]DC  `_DesignContractNumber_l)  `DEBUG
	If ($Continue_b)
		//PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+Char(9)+String(CTR_Contract_NO  `_ID_al{1})  `DEBUG
		$Counter_l:=$Counter_l+1
		
		C_LONGINT:C283(PRJ_RTRV_ContractID_L)
		PRJ_RTRV_ContractID_L:=[PRJ_DesignContracts:123]DC_SQLContractID_l:17
		C_TEXT:C284($Failure_txt)
		$Failure_txt:=ut_PRJNewFiscal
		If ($Failure_txt="")
			C_REAL:C285($TotalAmt_r; $ActualAmt_r; $RemainAmt_r; $RemainderAmt_r)
			$TotalAmt_r:=PRJ_MMAR_Total_ar{1}
			$RemainderAmt_r:=PRJ_EXPSCTotal_ar{1}-PRJ_EXPSCSpent_ar{1}
			$TotalAmt_r:=$TotalAmt_r-$RemainderAmt_r
			$TotalAmt_r:=$TotalAmt_r-PRJ_MMAR_Accepted_ar{1}
			$TotalAmt_r:=$TotalAmt_r+PRJ_MMAR_Payed_ar{1}
			$TotalAmt_r:=$TotalAmt_r+PRJ_MMAR_BFY_ar{1}
			$ActualAmt_r:=PRJ_MMAR_Spent_ar{1}
			$RemainAmt_r:=$TotalAmt_r-$ActualAmt_r
			
			$ContractIDs_aL{$OuterLoop_L}:=PRJ_RTRV_ContractID_L
			$PRJ_MMAR_Total_ar{$OuterLoop_L}:=PRJ_MMAR_Total_ar{1}  //sp_RTRV_MMARSTotal
			$PRJ_MMAR_Spent_ar{$OuterLoop_L}:=PRJ_MMAR_Spent_ar{1}  //sp_RTRV_MMARSSpent 
			$PRJ_EXPSCTotal_ar{$OuterLoop_L}:=PRJ_EXPSCTotal_ar{1}  //sp_RTRV_EXPSCTotal
			$PRJ_EXPSCSpent_ar{$OuterLoop_L}:=PRJ_EXPSCSpent_ar{1}  //sp_RTRV_EXPSCSpent
			$PRJ_MMAR_Accepted_ar{$OuterLoop_L}:=PRJ_MMAR_Accepted_ar{1}  //sp_RTRV_MMARSAccept
			$PRJ_MMAR_Payed_ar{$OuterLoop_L}:=PRJ_MMAR_Payed_ar{1}  //sp_RTRV_MMARSPay
			$PRJ_MMAR_BFY_ar{$OuterLoop_L}:=PRJ_MMAR_BFY_ar{1}  //sp_RTRV_MMARSBFYAMT
			
			
			If (Round:C94([PRJ_DesignContracts:123]DC_ActualAmount_r:6; 2)#Round:C94($ActualAmt_r; 2))
				[PRJ_DesignContracts:123]DC_ActualAmount_r:6:=Round:C94($ActualAmt_r; 2)
				$RecordChanged_b:=True:C214
			End if 
			If (Round:C94([PRJ_DesignContracts:123]DC_ESTContractAmt_r:10; 2)#Round:C94($TotalAmt_r; 2))
				[PRJ_DesignContracts:123]DC_ESTContractAmt_r:10:=Round:C94($TotalAmt_r; 2)
				$RecordChanged_b:=True:C214
			End if 
			If (Round:C94([PRJ_DesignContracts:123]DC_RemainingAmount_r:7; 2)#Round:C94($RemainAmt_r; 2))
				[PRJ_DesignContracts:123]DC_RemainingAmount_r:7:=Round:C94($RemainAmt_r; 2)
				$RecordChanged_b:=True:C214
			End if 
			
			//[PRJ_DesignContracts]DC_ActualAmount_r:=Round($ActualAmt_r;2)
			//[PRJ_DesignContracts]DC_ESTContractAmt_r:=Round($TotalAmt_r;2)
			//[PRJ_DesignContracts]DC_RemainingAmount_r:=Round($RemainAmt_r;2)
		Else 
			PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Error calling "+$Failure_txt+SQL_ReturnErrorDescriptions+" occurred on contract  "+String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+" ID is "+String:C10([PRJ_DesignContracts:123]DC_SQLContractID_l:17)+$eol
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		//End if 
		If (SQL_Direct("sp_RTRVDesCtrFedAid"))
			C_LONGINT:C283($Fnos)
			If (Size of array:C274(PRJ_RetrievedFedAids_atxt)=0)
				APPEND TO ARRAY:C911($PRJ_RetrievedFedAids_atxt; "None Retrieved")
				APPEND TO ARRAY:C911($FedAidContractIDs_aL; PRJ_RTRV_ContractID_L)
				
			Else 
				For ($Fnos; 1; Size of array:C274(PRJ_RetrievedFedAids_atxt))
					If (PRJ_RetrievedFedAids_atxt{$Fnos}#"N/A")
						APPEND TO ARRAY:C911($PRJ_RetrievedFedAids_atxt; PRJ_RetrievedFedAids_atxt{$Fnos})
						APPEND TO ARRAY:C911($FedAidContractIDs_aL; PRJ_RTRV_ContractID_L)
						
						If (Position:C15(PRJ_RetrievedFedAids_atxt{$Fnos}; [PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15)<=0)
							If ([PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15="")
								[PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15:=PRJ_RetrievedFedAids_atxt{$Fnos}
								$RecordChanged_b:=True:C214
							Else 
								[PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15:=[PRJ_DesignContracts:123]DC_ContrFedAidNos_s:15+","+PRJ_RetrievedFedAids_atxt{$Fnos}
								$RecordChanged_b:=True:C214
							End if 
							
						End if 
						
					End if 
					
				End for 
			End if 
		Else 
			PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Error calling sp_RTRVDesCtrFedAid "+SQL_ReturnErrorDescriptions+" occurred on contract  "+String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+" ID is "+String:C10([PRJ_DesignContracts:123]DC_SQLContractID_l:17)+$eol
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		
		
	End if 
	//PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+$Eol  `DEBUG
	If ($RecordChanged_b)
		SAVE RECORD:C53([PRJ_DesignContracts:123])
		$Updated_l:=$Updated_l+1
	End if 
	UNLOAD RECORD:C212([PRJ_DesignContracts:123])
	
	NEXT RECORD:C51([PRJ_DesignContracts:123])
	
End for 

PRJ_SQLRetrieveStats_txt:="Timing for dc amounts is "+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"MMARSTotal_l "+String:C10(MMARSTotal_l)+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"MMARSSpent_l "+String:C10(MMARSSpent_l)+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"EXPSCTotal_l "+String:C10(EXPSCTotal_l)+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"EXPSCSpent_l "+String:C10(EXPSCSpent_l)+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"MMARSAccept_l "+String:C10(MMARSAccept_l)+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"MMARSPay_l "+String:C10(MMARSPay_l)+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"MMARSBFYAMT_l "+String:C10(MMARSBFYAMT_l)+$eol

$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($Counter_l)+" design contract records processed "+$Eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($Updated_l)+" design contract records updated "+$Eol

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve design contracts amounts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

//CLOSE WINDOW

//End ut_PRJRetrieveDCAmounts

C_TEXT:C284($FolderName_txt)
C_TEXT:C284($result_txt)
COPY ARRAY:C226($PRJ_MMAR_Total_ar; PRJ_MMAR_Total_ar)  //sp_RTRV_MMARSTotal
COPY ARRAY:C226($PRJ_MMAR_Spent_ar; PRJ_MMAR_Spent_ar)  //sp_RTRV_MMARSSpent 
COPY ARRAY:C226($PRJ_EXPSCTotal_ar; PRJ_EXPSCTotal_ar)  //sp_RTRV_EXPSCTotal
COPY ARRAY:C226($PRJ_EXPSCSpent_ar; PRJ_EXPSCSpent_ar)  //sp_RTRV_EXPSCSpent
COPY ARRAY:C226($PRJ_MMAR_Accepted_ar; PRJ_MMAR_Accepted_ar)  //sp_RTRV_MMARSAccept
COPY ARRAY:C226($PRJ_MMAR_Payed_ar; PRJ_MMAR_Payed_ar)  //sp_RTRV_MMARSPay
COPY ARRAY:C226($PRJ_MMAR_BFY_ar; PRJ_MMAR_BFY_ar)  //sp_RTRV_MMARSBFYAMT
COPY ARRAY:C226($ContractIDs_aL; CTR_Contract_NO_ID_al)

$Result_txt:=ut_ArraysToText(","; \
->CTR_Contract_NO_ID_al; \
->PRJ_MMAR_Total_ar; \
->PRJ_MMAR_Spent_ar; \
->PRJ_EXPSCTotal_ar; \
->PRJ_EXPSCSpent_ar; \
->PRJ_MMAR_Accepted_ar; \
->PRJ_MMAR_Payed_ar; \
->PRJ_MMAR_BFY_ar)
C_TEXT:C284($Path_txt; $FileName_txt)
$Path_txt:=ut_PRJ_CreateFolderPath("CSV_OutPut")

C_TEXT:C284($FileName_txt)
$FileName_txt:="SP_MMARS_Retrieves-"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178; "A")+"_DC.csv"
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266($Path_txt+$FileName_txt)
CLOSE DOCUMENT:C267($Doc_tm)
TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Result_txt; UTF8 text without length:K22:17)

COPY ARRAY:C226($FedAidContractIDs_aL; CTR_Contract_NO_ID_al)
COPY ARRAY:C226($PRJ_RetrievedFedAids_atxt; PRJ_RetrievedFedAids_atxt)
$Result_txt:=ut_ArraysToText(","; \
->CTR_Contract_NO_ID_al; \
->PRJ_RetrievedFedAids_atxt)

C_TEXT:C284($FileName_txt)
$FileName_txt:="sp_RTRVDesCtrFedAid-"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178; "a")+"_DC.csv"
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266($Path_txt+$FileName_txt)
If (Size of array:C274($FedAidContractIDs_aL)>0)
	CLOSE DOCUMENT:C267($Doc_tm)
	TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Result_txt; UTF8 text without length:K22:17)
Else 
	SEND PACKET:C103($Doc_tm; "no data for this call")
	CLOSE DOCUMENT:C267($Doc_tm)
	
End if 
COPY ARRAY:C226($RETContractIDs_aL; CTR_Contract_NO_ID_al)
COPY ARRAY:C226($PRJ_RTRV_ContractNo_atxt; PRJ_RTRV_ContractNo_atxt)

$Result_txt:=ut_ArraysToText(","; \
->CTR_Contract_NO_ID_al; \
->PRJ_RTRV_ContractNo_atxt)

$FileName_txt:="sp_RTRVContractID-"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178; "a")+".csv"
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266($Path_txt+$FileName_txt)
If (Size of array:C274($RETContractIDs_aL)>0)
	CLOSE DOCUMENT:C267($Doc_tm)
	TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Result_txt; UTF8 text without length:K22:17)
Else 
	SEND PACKET:C103($Doc_tm; "no data for this call")
	CLOSE DOCUMENT:C267($Doc_tm)
End if 
//CLOSE WINDOW

//End ut_PRJRetrieveDCAmounts
