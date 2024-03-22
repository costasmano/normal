//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/16/10, 12:00:35
	// ----------------------------------------------------
	// Method: Method: ut_PRJGetCPAmounts
	// Description
	//  ` Load the construction contract cost ammounts
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
	Mods_2011_01  //r001 CJ Miller`01/14/11, 11:28:21     
	//Add code to allow for retrieve of [PRJ_DesignContracts] amounts and
	//[PRJ_ConstructionProject] seperately
	Mods_2011_06  // CJ Miller`06/20/11, 10:23:11      ` Type all local variables for v11
	Mods_2019_06_bug  //Fix bug where [PRJ_ConstructionProject]CP_Encumbered_r not being filled
	//Modified by: Chuck Miller (6/6/19 11:11:44)
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/20/19 11:55:19)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 


C_BOOLEAN:C305($0)
$0:=True:C214
C_BOOLEAN:C305($RecordChanged_b)
READ WRITE:C146([PRJ_ConstructionProject:116])
ALL RECORDS:C47([PRJ_ConstructionProject:116])
QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_Awarded_d:4>Date:C102("1/1/"+String:C10(Year of:C25(Current date:C33(*))-5)))
C_LONGINT:C283($OuterLoop_l; $InnerLoop_l; $FiscalYear_l; $win; $NumberOfRecords_l)
FIRST RECORD:C50([PRJ_ConstructionProject:116])
C_REAL:C285($ExpiredTotal_r; $EncumberedTotal_r; $SpentTotal_r)
C_TEXT:C284($EOL)
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
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Construction Contract Amounts")
C_OBJECT:C1216($progressObj_o)

//$win:=Open window(50;50;550;250;4;"")

$NumberOfRecords_l:=Records in selection:C76([PRJ_ConstructionProject:116])
$progressObj_o:=ProgressNew("Updating Construction Contract Amounts"; $NumberOfRecords_l; False:C215; ""; 3)

C_TIME:C306($StartTime_tm; $RemainingTime_tm; $SQLDocument_tm)
$StartTime_tm:=Current time:C178(*)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Contruction contracts amounts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
C_LONGINT:C283($Counter_l; $Updated_l)
$Counter_l:=0
$Updated_l:=0
C_LONGINT:C283(MMARSTotal_l; MMARSSpent_l; EXPSCTotal_l; EXPSCSpent_l; MMARSAccept_l; MMARSPay_l; MMARSBFYAMT_l)
MMARSTotal_l:=0
MMARSSpent_l:=0
EXPSCTotal_l:=0
EXPSCSpent_l:=0
MMARSAccept_l:=0
MMARSPay_l:=0
MMARSBFYAMT_l:=0
ARRAY LONGINT:C221($ContractIDs_aL; 0)
ARRAY REAL:C219($PRJ_MMAR_Total_ar; 0)  //sp_RTRV_MMARSTotal
ARRAY REAL:C219($PRJ_MMAR_Spent_ar; 0)  //sp_RTRV_MMARSSpent
ARRAY REAL:C219($PRJ_EXPSCTotal_ar; 0)  //sp_RTRV_EXPSCTotal
ARRAY REAL:C219($PRJ_EXPSCSpent_ar; 0)  //sp_RTRV_EXPSCSpent
ARRAY REAL:C219($PRJ_MMAR_Accepted_ar; 0)  //sp_RTRV_MMARSAccept
ARRAY REAL:C219($PRJ_MMAR_Payed_ar; 0)  //sp_RTRV_MMARSPay
ARRAY REAL:C219($PRJ_MMAR_BFY_ar; 0)  //sp_RTRV_MMARSBFYAMT
ARRAY TEXT:C222($PRJ_RTRV_ContractNo_atxt; 0)

ARRAY LONGINT:C221($ContractIDs_aL; $NumberOfRecords_l)
ARRAY REAL:C219($PRJ_MMAR_Total_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSTotal
ARRAY REAL:C219($PRJ_MMAR_Spent_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSSpent
ARRAY REAL:C219($PRJ_EXPSCTotal_ar; $NumberOfRecords_l)  //sp_RTRV_EXPSCTotal
ARRAY REAL:C219($PRJ_EXPSCSpent_ar; $NumberOfRecords_l)  //sp_RTRV_EXPSCSpent
ARRAY REAL:C219($PRJ_MMAR_Accepted_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSAccept
ARRAY REAL:C219($PRJ_MMAR_Payed_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSPay
ARRAY REAL:C219($PRJ_MMAR_BFY_ar; $NumberOfRecords_l)  //sp_RTRV_MMARSBFYAMT
ARRAY TEXT:C222($PRJ_RTRV_ContractNo_atxt; $NumberOfRecords_l)
ARRAY TEXT:C222(v_116_005_atxt; $NumberOfRecords_l)
For ($OuterLoop_l; 1; $NumberOfRecords_l)
	UpdateProgressNew($progressObj_o; $OuterLoop_l)
	
	$RecordChanged_b:=False:C215
	//GOTO XY(5;2)
	//MESSAGE("Retrieving "+String($OuterLoop_l)+" out of "+String($NumberOfRecords_l))
	//GOTO XY(5;5)
	//$RemainingTime_tm:=(($NumberOfRecords_l/$OuterLoop_l)-1)*(Current time(*)-$StartTime_tm)
	//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
	//GOTO XY(5;7)
	//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
	
	ut_LoadRecord(->[PRJ_ConstructionProject:116])
	C_TEXT:C284($XMLData_txt)
	C_BOOLEAN:C305($Continue_b)
	$Continue_b:=False:C215
	C_LONGINT:C283(PRJ_RTRV_ContractID_L)
	C_TEXT:C284(PRJ_RTRV_ContractNo_txt)
	PRJ_RTRV_ContractNo_txt:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
	
	v_116_005_atxt{$OuterLoop_L}:=PRJ_RTRV_ContractNo_txt
	
	Case of 
		: (SQL_Direct("sp_RTRVContractID"))
			If (Size of array:C274(CTR_Contract_NO_ID_al)>0)
				If (CTR_Contract_NO_ID_al{1}>0)
					PRJ_RTRV_ContractID_L:=CTR_Contract_NO_ID_al{1}
					$ContractIDs_aL{$OuterLoop_l}:=PRJ_RTRV_ContractID_L
					$Continue_b:=True:C214
					v_116_005_atxt{$OuterLoop_l}:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
				Else 
					$ContractIDs_aL{$OuterLoop_l}:=PRJ_RTRV_ContractID_L
					$Continue_b:=True:C214
					v_116_005_atxt{$OuterLoop_l}:="Non retrieved"
					
				End if 
				
			Else 
				v_116_005_atxt{$OuterLoop_l}:="No Contract returned for "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
				PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"No row returned for contract  "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+$eol
				$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
				SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
				CLOSE DOCUMENT:C267($SQLDocument_tm)
				PRJ_SQLRetrieveStats_txt:=""
			End if 
		Else 
			PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVContractID Failed for "+"[PRJ_ConstructionProject]CP_ConstructionContractNo_s  "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+$eol
			PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	End case 
	//PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String([PRJ_ConstructionProject]DC  `_DesignContractNumber_l)  `DEBUG
	If ($Continue_b)
		//PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+Char(9)+String(CTR_Contract_NO  `_ID_al{1})  `DEBUG
		$Counter_l:=$Counter_l+1
		
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
			$PRJ_MMAR_Total_ar{$OuterLoop_L}:=PRJ_MMAR_Total_ar{1}  //sp_RTRV_MMARSTotal
			$PRJ_MMAR_Spent_ar{$OuterLoop_L}:=PRJ_MMAR_Spent_ar{1}  //sp_RTRV_MMARSSpent 
			$PRJ_EXPSCTotal_ar{$OuterLoop_L}:=PRJ_EXPSCTotal_ar{1}  //sp_RTRV_EXPSCTotal
			$PRJ_EXPSCSpent_ar{$OuterLoop_L}:=PRJ_EXPSCSpent_ar{1}  //sp_RTRV_EXPSCSpent
			$PRJ_MMAR_Accepted_ar{$OuterLoop_L}:=PRJ_MMAR_Accepted_ar{1}  //sp_RTRV_MMARSAccept
			$PRJ_MMAR_Payed_ar{$OuterLoop_L}:=PRJ_MMAR_Payed_ar{1}  //sp_RTRV_MMARSPay
			$PRJ_MMAR_BFY_ar{$OuterLoop_L}:=PRJ_MMAR_BFY_ar{1}  //sp_RTRV_MMARSBFYAMT
			
			If (Round:C94([PRJ_ConstructionProject:116]CP_Spent_r:26; 2)#Round:C94($ActualAmt_r; 2))
				[PRJ_ConstructionProject:116]CP_Spent_r:26:=Round:C94($ActualAmt_r; 2)
				$RecordChanged_b:=True:C214
			End if 
			If (Round:C94([PRJ_ConstructionProject:116]CP_Encumbered_r:25; 2)#Round:C94($TotalAmt_r; 2))
				[PRJ_ConstructionProject:116]CP_Encumbered_r:25:=Round:C94($TotalAmt_r; 2)  // [PRJ_DesignContracts]DC_ESTContractAmt_r
				$RecordChanged_b:=True:C214
			End if 
			If (Round:C94([PRJ_ConstructionProject:116]CP_Remaining_r:27; 2)#Round:C94($RemainAmt_r; 2))
				[PRJ_ConstructionProject:116]CP_Remaining_r:27:=Round:C94($RemainAmt_r; 2)
				$RecordChanged_b:=True:C214
			End if 
			
			
			
		Else 
			PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Error calling "+$Failure_txt+SQL_ReturnErrorDescriptions+" occurred on contract  "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+" ID is "+String:C10([PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)+$eol
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		//End if 
	End if 
	//PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+$Eol  `DEBUG
	If ($RecordChanged_b)
		SAVE RECORD:C53([PRJ_ConstructionProject:116])
		$Updated_l:=$Updated_l+1
	End if 
	UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
	
	NEXT RECORD:C51([PRJ_ConstructionProject:116])
	
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

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($Counter_l)+" Construction contracts records processed "+$Eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($Updated_l)+" Construction contracts records changed "+$Eol


PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Construction contracts amounts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
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
->v_116_005_atxt; \
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
$FileName_txt:="SP_MMARS_Retrieves-"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178; "A")+"_CP.csv"
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266($Path_txt+$FileName_txt)
CLOSE DOCUMENT:C267($Doc_tm)
TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Result_txt; UTF8 text without length:K22:17)

//CLOSE WINDOW

//End ut_PRJRetrieveCPAmounts