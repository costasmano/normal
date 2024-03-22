//%attributes = {"invisible":true}
//Method: ActualDataToAssignmnt
//Description
//Get actual data from pasteboard copied from Excel and update records in Cons insp or Cons rating
// Excel data have 10 columns . total salary to date, total hours to date and direct expense are used.

//BRIDGE          | SALARY MAX | SALARY       | TOTAL SALARY | TOTAL SALARY | HOURS MAX | HOURS         | TOTAL HOURS | TOTAL HOURS | DIRECT
//NUMBER         | ALLOWED     | PREVIOUSLY | THIS PERIOD     | TO DATE           | ALLOWED    | PREVIOUSLY | THIS PERIOD    | TO DATE         | EXPENSE
//         
//B-16-281 3BM $8,260.47      $7,532.06      $0.00               $7,532.06         176.00         161.00             0.00                161.00             8238.97
//B-16-281 3BP $6,427.87       $4,654.40      $0.00               $4,654.40         136.00          95.50              0.00                 95.50              3594.8 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/23/16, 15:13:43
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	// Modified by: Costas Manousakis-(Designer)-(8/30/16 16:28:21)
	Mods_2016_08
	//  `added ability to scan and then combine costs from subconsultants into the comments field.
	// Modified by: Costas Manousakis-(Designer)-(9/8/16 14:17:56)
	Mods_2016_09
	//  `calculate Indirect cost 1st and then NetFee; Added special case to distinguish between Tunnel column setup and Bridge;  make sure a Header row was read
	// Modified by: Costas Manousakis-(Designer)-(11/7/16 16:35:22)
	Mods_2016_11
	//  `changed the BDEPTBIN_Pattern to accound for  bdept -BIN entered as B-16-281 (3BP)
	// Modified by: Costas Manousakis-(Designer)-(1/26/17 16:06:07)
	Mods_2017_01
	//  `Tunnels_b set to False - everyone uses same template
	// Modified by: Costas Manousakis-(Designer)-(12/6/17 17:39:41)
	Mods_2017_12
	//  `adjusted logic to better handle cases where the BDEPT BIN is not properly entered.
End if 
//

C_TEXT:C284($fromExcel_txt)

$fromExcel_txt:=Get text from pasteboard:C524
ARRAY TEXT:C222($Lines_atxt; 0)
ut_TextToArray($fromExcel_txt; ->$Lines_atxt; Char:C90(13))
C_LONGINT:C283($loop_L; $Lines_L)
C_TEXT:C284($BIN_txt)
C_REAL:C285($TotSal_r; $TotHrs_r; $TotDirExp_r)
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY REAL:C219($Hours_ar; 0)
ARRAY REAL:C219($Salary_ar; 0)
ARRAY REAL:C219($DirExp_ar; 0)
ARRAY TEXT:C222($Comments_atxt; 0)
C_BOOLEAN:C305($ErrorParsingPasteboard_b)
$ErrorParsingPasteboard_b:=False:C215
C_TEXT:C284($BDEPTBIN_Pattern_txt)
//zero or more spaces + one letter + zero or one minus + two numbers + zero or one minus + 3 numbers + zero or more spaces + three letters or numbers
$BDEPTBIN_Pattern_txt:="[ ]*([A-Z])[-]?([0-9]{2})[-]?([0-9]{3})[ ,\\(]*([A-Z,0-9]{3})"

ARRAY TEXT:C222($consNames_atxt; 0)
ARRAY LONGINT:C221($consLFCol_aL; 0)
ARRAY LONGINT:C221($consDCCol_aL; 0)
ARRAY LONGINT:C221($consHRSCol_aL; 0)
C_LONGINT:C283($TotSalCol_L; $TotHrsCol_L; $TotalDirExpCol_L; $StartSubsCol_L)
C_TEXT:C284($SubLFPattern_txt; $SubDCPattern_txt; $SubHrsPattern_txt)
$TotSalCol_L:=5
$TotHrsCol_L:=9
$TotalDirExpCol_L:=10
$StartSubsCol_L:=15
$SubLFPattern_txt:="@ LF"
$SubDCPattern_txt:="@ DC"
$SubHrsPattern_txt:="@ Hours"
C_BOOLEAN:C305($Tunnels_b)
$Tunnels_b:=False:C215
If (Current user:C182="Paige Parker")
	$Tunnels_b:=True:C214
End if 

$Tunnels_b:=False:C215

If (User in group:C338(Current user:C182; "Design Access Group"))
	CONFIRM:C162("Use column settings for Bridge (I. Barsky) or Tunnel (P.Parker)?"; "Bridge"; "Tunnel")
	$Tunnels_b:=(OK=0)
End if 
If ($Tunnels_b)
	$TotSalCol_L:=5
	$TotHrsCol_L:=9
	$TotalDirExpCol_L:=13
	$StartSubsCol_L:=18
	$SubLFPattern_txt:="LF @"
	$SubDCPattern_txt:="DC @"
	$SubHrsPattern_txt:="Hours @"
End if 
$Lines_L:=0
C_BOOLEAN:C305($FoundBDEPTBIN_b; $FoundHeader_b; $IgnoreBridge_b; $HeaderDefined_b)
For ($loop_L; 1; Size of array:C274($Lines_atxt))
	ARRAY TEXT:C222($columns_atxt; 0)
	//ARRAY LONGINT($tabpos_aL;0)
	//ARRAY LONGINT($tabLen_aL;0)
	If ($Lines_atxt{$loop_L}=(Char:C90(Tab:K15:37)+"@"))
		//starts with tab -- ignore the line
	Else 
		$Lines_L:=$Lines_L+1
		//add a space AFTER every tab so all columns have a value. ut_TextToArray counts consecutive tabs as a single column
		$Lines_atxt{$loop_L}:=Replace string:C233($Lines_atxt{$loop_L}; Char:C90(Tab:K15:37); (Char:C90(Tab:K15:37)+" "))
		ut_TextToArray($Lines_atxt{$loop_L}; ->$columns_atxt; Char:C90(Tab:K15:37))
		ARRAY LONGINT:C221($pos_aL; 0)
		ARRAY LONGINT:C221($Len_aL; 0)
		If (Size of array:C274($columns_atxt)>1)
			$FoundBDEPTBIN_b:=Match regex:C1019($BDEPTBIN_Pattern_txt; $columns_atxt{1}; 1; $pos_aL; $Len_aL)
			$FoundHeader_b:=(Position:C15("NUMBER"; $columns_atxt{1})>0)  //| $FoundHeader_b
			$HeaderDefined_b:=$HeaderDefined_b | $FoundHeader_b
			$IgnoreBridge_b:=(Position:C15("BRIDGE"; $columns_atxt{1})>0)
		End if 
		Case of 
			: (Size of array:C274($columns_atxt)<10)
				$ErrorParsingPasteboard_b:=True:C214
				ALERT:C41("Error Parsing line number "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\rFound less than 10 columns!")
				$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
			: ($IgnoreBridge_b)
				//nothing to do here
			: ((Not:C34($FoundBDEPTBIN_b)) & Not:C34($FoundHeader_b))
				$ErrorParsingPasteboard_b:=True:C214
				ALERT:C41("Error Parsing line number "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\rFirst Column is not a [BridgeNumber BIN] or a [HEADER] line !")
				$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
			: ($FoundBDEPTBIN_b & Not:C34($HeaderDefined_b))
				//: ($FoundBDEPTBIN_b & Not($FoundHeader_b))
				$ErrorParsingPasteboard_b:=True:C214
				ALERT:C41("Error Parsing line number "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\rFound a BridgeNumber BIN Line but have not found a HEADER line!")
				$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
				
			: ($FoundBDEPTBIN_b)
				//get BIN it is the fourth element of the regex pattern
				$BIN_txt:=Substring:C12($columns_atxt{1}; $pos_aL{4}; $Len_aL{4})
				$TotSal_r:=Num:C11($columns_atxt{$TotSalCol_L})
				$TotHrs_r:=Num:C11($columns_atxt{$TotHrsCol_L})
				$TotDirExp_r:=Num:C11($columns_atxt{$TotalDirExpCol_L})
				APPEND TO ARRAY:C911($Bins_atxt; $BIN_txt)
				APPEND TO ARRAY:C911($Hours_ar; $TotHrs_r)
				APPEND TO ARRAY:C911($Salary_ar; $TotSal_r)
				APPEND TO ARRAY:C911($DirExp_ar; $TotDirExp_r)
				C_LONGINT:C283($Cloop_L)
				C_TEXT:C284($ConsCmts_txt; $ConsData_txt)
				$ConsCmts_txt:=""
				C_REAL:C285($LF_r; $DC_r; $Hrs_r)
				For ($Cloop_L; 1; Size of array:C274($consNames_atxt))
					$ConsData_txt:=""
					If ($consHRSCol_aL{$Cloop_L}>0)
						$Hrs_r:=Num:C11($columns_atxt{$consHRSCol_aL{$Cloop_L}})
						If ($Hrs_r>0)
							$ConsData_txt:=String:C10($Hrs_r; "###,###,###,###hrs;;0")+" ; "
						End if 
					End if 
					If ($consLFCol_aL{$Cloop_L}>0)
						$LF_r:=Num:C11($columns_atxt{$consLFCol_aL{$Cloop_L}})
						If ($LF_r>0)
							$ConsData_txt:=$ConsData_txt+String:C10($LF_r; "$ ###,###,###,###.00;;0")+" LF ; "
						End if 
					End if 
					If ($consDCCol_aL{$Cloop_L}>0)
						$DC_r:=Num:C11($columns_atxt{$consDCCol_aL{$Cloop_L}})
						If ($DC_r>0)
							$ConsData_txt:=$ConsData_txt+String:C10($DC_r; "$ ###,###,###,###.00;;0")+" DC"
						End if 
					End if 
					If ($ConsData_txt#"")
						If ($ConsData_txt="@ ; ")
							$ConsData_txt:=Substring:C12($ConsData_txt; 1; (Length:C16($ConsData_txt)-3))
						End if 
						$ConsData_txt:=$consNames_atxt{$Cloop_L}+" (SUB) : "+$ConsData_txt
						If ($ConsCmts_txt#"")
							$ConsCmts_txt:=$ConsCmts_txt+Char:C90(13)+$ConsData_txt
						Else 
							$ConsCmts_txt:=$ConsData_txt
						End if 
					End if 
				End for 
				APPEND TO ARRAY:C911($Comments_atxt; $ConsCmts_txt)
				
			: ($FoundHeader_b)
				//handle header and  sub consultants - they start from column "O" = 15
				C_LONGINT:C283($Cloop_L; $consInx_L)
				C_TEXT:C284($consname_txt)
				C_BOOLEAN:C305($foundCons_b)
				$consname_txt:=""
				For ($Cloop_L; $StartSubsCol_L; Size of array:C274($columns_atxt))
					$columns_atxt{$Cloop_L}:=f_TrimStr($columns_atxt{$Cloop_L}; True:C214; True:C214)
					
					Case of 
						: ($columns_atxt{$Cloop_L}=$SubLFPattern_txt)
							//limit fee
							$consname_txt:=Replace string:C233($columns_atxt{$Cloop_L}; Replace string:C233($SubLFPattern_txt; "@"; ""); "")
							$consname_txt:=Replace string:C233($consname_txt; ")"; "")
							$consname_txt:=Replace string:C233($consname_txt; "("; "")
							$consname_txt:=Replace string:C233($consname_txt; "="; "")
							$consname_txt:=f_TrimStr($consname_txt; True:C214; True:C214)
							$consInx_L:=Find in array:C230($consNames_atxt; $consname_txt)
							
							If ($consInx_L>0)
								$consLFCol_aL{$consInx_L}:=$Cloop_L
							Else 
								APPEND TO ARRAY:C911($consNames_atxt; $consname_txt)
								APPEND TO ARRAY:C911($consLFCol_aL; $Cloop_L)
								APPEND TO ARRAY:C911($consDCCol_aL; 0)
								APPEND TO ARRAY:C911($consHRSCol_aL; 0)
								
							End if 
							
						: ($columns_atxt{$Cloop_L}=$SubDCPattern_txt)
							//direct cost
							$consname_txt:=Replace string:C233($columns_atxt{$Cloop_L}; Replace string:C233($SubDCPattern_txt; "@"; ""); "")
							$consname_txt:=Replace string:C233($consname_txt; ")"; "")
							$consname_txt:=Replace string:C233($consname_txt; "("; "")
							$consname_txt:=Replace string:C233($consname_txt; "="; "")
							$consname_txt:=f_TrimStr($consname_txt; True:C214; True:C214)
							$consInx_L:=Find in array:C230($consNames_atxt; $consname_txt)
							
							If ($consInx_L>0)
								$consDCCol_aL{$consInx_L}:=$Cloop_L
							Else 
								APPEND TO ARRAY:C911($consNames_atxt; $consname_txt)
								APPEND TO ARRAY:C911($consLFCol_aL; 0)
								APPEND TO ARRAY:C911($consDCCol_aL; $Cloop_L)
								APPEND TO ARRAY:C911($consHRSCol_aL; 0)
							End if 
							
						: ($columns_atxt{$Cloop_L}=$SubHrsPattern_txt)
							//hours
							$consname_txt:=Replace string:C233($columns_atxt{$Cloop_L}; Replace string:C233($SubHrsPattern_txt; "@"; ""); "")
							$consname_txt:=Replace string:C233($consname_txt; ")"; "")
							$consname_txt:=Replace string:C233($consname_txt; "("; "")
							$consname_txt:=Replace string:C233($consname_txt; "="; "")
							$consname_txt:=f_TrimStr($consname_txt; True:C214; True:C214)
							$consInx_L:=Find in array:C230($consNames_atxt; $consname_txt)
							If ($consInx_L>0)
								$consHRSCol_aL{$consInx_L}:=$Cloop_L
							Else 
								APPEND TO ARRAY:C911($consNames_atxt; $consname_txt)
								APPEND TO ARRAY:C911($consLFCol_aL; 0)
								APPEND TO ARRAY:C911($consDCCol_aL; 0)
								APPEND TO ARRAY:C911($consHRSCol_aL; $Cloop_L)
							End if 
							
					End case 
					
				End for 
				
			Else 
				//unknown case
		End case 
		
	End if 
	
End for 

Case of 
	: ($ErrorParsingPasteboard_b)
		//done here
	: (Size of array:C274($Bins_atxt)=0)
		//nothing usefull found
		ALERT:C41("No data found in paste buffer! Please make sure that the")
	Else 
		//find where we are (raitng or inspection)
		C_POINTER:C301($HoursFld_ptr; $SalaryFld_ptr; $DirCostFld_ptr; $FinalCost_ptr; $IndirCost_ptr; $netFee_ptr; $totLimFee_ptr; $TotCost_ptr; $FinalMark_ptr)
		C_POINTER:C301($Table_ptr; $CostTbl_ptr; $BIN_ptr; $AssignNo_ptr; $ContrNo_ptr; $CostRecID_ptr; $RecID_ptr; $Cmts_ptr)
		Case of 
			: (Current form table:C627=(->[Conslt Rating:63]))
				$Table_ptr:=->[Conslt Rating:63]
				$CostTbl_ptr:=->[Conslt Rating Cost:74]
				$BIN_ptr:=->[Conslt Rating:63]BIN:1
				$RecID_ptr:=->[Conslt Rating:63]ConsltRatingID:42
				$AssignNo_ptr:=->[Conslt Rating:63]AssignNoRat:12
				$ContrNo_ptr:=->[Conslt Rating:63]ContractNoRat:14
				$CostRecID_ptr:=->[Conslt Rating Cost:74]ConsltRatingID:1
				$HoursFld_ptr:=->[Conslt Rating Cost:74]Act WorkHours:20
				$SalaryFld_ptr:=->[Conslt Rating Cost:74]Act Salary:21
				$DirCostFld_ptr:=->[Conslt Rating Cost:74]Act TotalDirectCost:34
				$IndirCost_ptr:=->[Conslt Rating Cost:74]Act IndirectCost:39
				$netFee_ptr:=->[Conslt Rating Cost:74]Act NetFee:22
				$totLimFee_ptr:=->[Conslt Rating Cost:74]Act TotalLimitFee:23
				$TotCost_ptr:=->[Conslt Rating Cost:74]Act TotalCost:35
				$FinalMark_ptr:=->[Conslt Rating Cost:74]FinalCost_B:41
				$Cmts_ptr:=->[Conslt Rating Cost:74]Act Comments:36
				//$FinalMark_ptr
			: (Current form table:C627=(->[Cons Inspection:64]))
				$Table_ptr:=->[Cons Inspection:64]
				$CostTbl_ptr:=->[Cons Inspection Cost:76]
				$BIN_ptr:=->[Cons Inspection:64]BIN:1
				$RecID_ptr:=->[Cons Inspection:64]ConsInspectionID:32
				$AssignNo_ptr:=->[Cons Inspection:64]AssignConNumber:6
				$ContrNo_ptr:=->[Cons Inspection:64]ConContractNo:7
				$CostRecID_ptr:=->[Cons Inspection Cost:76]ConsInspectionID:1
				
				$HoursFld_ptr:=->[Cons Inspection Cost:76]Act WorkHours:21
				$SalaryFld_ptr:=->[Cons Inspection Cost:76]Act Salary:22
				$DirCostFld_ptr:=->[Cons Inspection Cost:76]Act TotalDirectCost:37
				$IndirCost_ptr:=->[Cons Inspection Cost:76]Act IndirectCost:23
				$netFee_ptr:=->[Cons Inspection Cost:76]Act NetFee:24
				$totLimFee_ptr:=->[Cons Inspection Cost:76]Act TotalLimitFee:25
				$TotCost_ptr:=->[Cons Inspection Cost:76]Act TotalCost:38
				$FinalMark_ptr:=->[Cons Inspection Cost:76]FinalCost_B:49
				$Cmts_ptr:=->[Cons Inspection Cost:76]Act Comments:39
			Else 
				//not correct table!!!!
		End case 
		ARRAY TEXT:C222($ContractNos_atxt; 0)
		ARRAY TEXT:C222($ListedBINs_atxt; 0)
		ARRAY LONGINT:C221($AssignNos_aL; 0)
		ARRAY LONGINT:C221($RecIDS_aL; 0)
		//%W-518.10
		DISTINCT VALUES:C339($ContrNo_ptr->; $ContractNos_atxt)
		DISTINCT VALUES:C339($AssignNo_ptr->; $AssignNos_aL)
		//%W+518.10
		SELECTION TO ARRAY:C260($BIN_ptr->; $ListedBINs_atxt; $RecID_ptr->; $RecIDS_aL)
		C_LONGINT:C283($checkSize_L)
		$checkSize_L:=MinNum(Size of array:C274($ListedBINs_atxt); Size of array:C274($Bins_atxt))
		C_LONGINT:C283($loop_L)
		C_BOOLEAN:C305($BINmisMatch_b)
		C_TEXT:C284($MissingBIN_txt)
		$BINmisMatch_b:=False:C215
		$MissingBIN_txt:=""
		For ($loop_L; 1; $checkSize_L)
			If (Find in array:C230($Bins_atxt; $ListedBINs_atxt{$loop_L})<0)
				$BINmisMatch_b:=True:C214
				$MissingBIN_txt:=$MissingBIN_txt+" "+$ListedBINs_atxt{$loop_L}
			End if 
		End for 
		
		Case of 
			: (Records in selection:C76($Table_ptr->)=0)
				ALERT:C41("There are no records listed!")
			: (Size of array:C274($ContractNos_atxt)>1)
				ALERT:C41("There are multiple Contract numbers listed!")
			: (Size of array:C274($AssignNos_aL)>1)
				ALERT:C41("There are multiple assignments listed!!")
			: (Size of array:C274($ListedBINs_atxt)#Size of array:C274($Bins_atxt))
				ALERT:C41("Number of records listed ("+String:C10(Size of array:C274($ListedBINs_atxt))+") not equal to the number of records found in the paste buffer ("+String:C10(Size of array:C274($Bins_atxt))+")!")
			: ($BINmisMatch_b)
				ALERT:C41("Some of the BINs listed not found in the paste buffer :"+$MissingBIN_txt)
			Else 
				//looks ok - verify now
				CIR_GetRates($ContractNos_atxt{1}; $AssignNos_aL{1})
				
				Case of 
					: ((netFeeRate=0) & (overheadRate=0))
						ALERT:C41("NetFee Rate ("+String:C10(netFeeRate)+") and Overhead Rate ("+String:C10(overheadRate)+") are zero! Indirect Cost and Net Fee will not be updated!")
					: (netFeeRate=0)
						ALERT:C41("NetFee Rate ("+String:C10(netFeeRate)+") is zero! Net Fee will not be updated!")
					: (overheadRate=0)
						ALERT:C41("Overhead Rate ("+String:C10(overheadRate)+") is zero! Indirect Cost will not be updated!")
				End case 
				CONFIRM:C162("Ready to update actual costs for Contract no "+$ContractNos_atxt{1}+", Assignment "+String:C10($AssignNos_aL{1})+" in "+String:C10(Size of array:C274($ListedBINs_atxt))+" bridges?")
				If (OK=1)
					C_REAL:C285(netFeeRate; overheadRate)
					CONFIRM:C162("Add the checkmark indicating costs entered are final?")
					C_BOOLEAN:C305($mark_b)
					$mark_b:=(OK=1)
					
					C_LONGINT:C283($PasteBufferIndex_L; $UpdatedRecs_L)
					C_BOOLEAN:C305($updateCost_b; $SaveTransaction_b)
					$UpdatedRecs_L:=0
					$SaveTransaction_b:=True:C214
					START TRANSACTION:C239
					For ($loop_L; 1; Size of array:C274($ListedBINs_atxt))
						$PasteBufferIndex_L:=Find in array:C230($Bins_atxt; $ListedBINs_atxt{$loop_L})
						QUERY:C277($CostTbl_ptr->; $CostRecID_ptr->=$RecIDS_aL{$loop_L})
						If (Records in selection:C76($CostTbl_ptr->)=1)
							$updateCost_b:=ut_LoadRecordInteractive($CostTbl_ptr)
						Else 
							CREATE RECORD:C68($CostTbl_ptr->)
							$CostRecID_ptr->:=$RecIDS_aL{$loop_L}
							$updateCost_b:=True:C214
						End if 
						If ($updateCost_b)
							$UpdatedRecs_L:=$UpdatedRecs_L+1
							$HoursFld_ptr->:=$Hours_ar{$PasteBufferIndex_L}
							$SalaryFld_ptr->:=$Salary_ar{$PasteBufferIndex_L}
							$DirCostFld_ptr->:=$DirExp_ar{$PasteBufferIndex_L}
							If (overheadRate#0)
								$IndirCost_ptr->:=$SalaryFld_ptr->*overheadRate/100
							End if 
							If (netFeeRate#0)
								$netFee_ptr->:=($SalaryFld_ptr->+$IndirCost_ptr->)*netFeeRate/100
							End if 
							$Cmts_ptr->:=$Comments_atxt{$PasteBufferIndex_L}
							$totLimFee_ptr->:=$SalaryFld_ptr->+$IndirCost_ptr->+$netFee_ptr->
							$TotCost_ptr->:=$totLimFee_ptr->+$DirCostFld_ptr->
							
							If ($mark_b)
								$FinalMark_ptr->:=True:C214
							End if 
							SAVE RECORD:C53($CostTbl_ptr->)
						Else 
							//should we cancel everything or continue?
							C_TEXT:C284($msg_txt)
							$msg_txt:="Record for BIN "+$ListedBINs_atxt{$loop_L}+" will not be updated! Continue updating remaining records, or Cancel the update?"
							If ($UpdatedRecs_L>0)
								$msg_txt:=$msg_txt+" If you Cancel the update changes made to previous "+String:C10($UpdatedRecs_L)+" records will be undone."
							End if 
							$msg_txt:=$msg_txt+" You can always execute this later, or enter the data manually for this record."
							G_MyConfirm($msg_txt; "Continue"; "Cancel")
							If (OK=1)
							Else 
								//exit loop and cancel transaction
								$loop_L:=Size of array:C274($ListedBINs_atxt)+1
								$SaveTransaction_b:=False:C215
							End if 
						End if 
					End for 
					If ($SaveTransaction_b)
						VALIDATE TRANSACTION:C240
						ALERT:C41("Updated "+String:C10($UpdatedRecs_L)+" records!")
					Else 
						CANCEL TRANSACTION:C241
						ALERT:C41("Updates Canceled!")
					End if 
				End if 
		End case 
		
End case 

//End ActualDataToAssignmnt