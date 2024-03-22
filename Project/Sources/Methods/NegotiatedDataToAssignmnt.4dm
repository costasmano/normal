//%attributes = {"invisible":true}
//Method: NegotiatedDataToAssignmnt
//Description
//Get negotiated cost data from pasteboard copied from Excel and update records in Cons insp or Cons rating
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/28/16, 17:38:32
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	// Modified by: Costas Manousakis-(Designer)-(1/26/17 16:06:07)
	Mods_2017_01
	//  `Tunnels_b set to False - everyone uses same template
	// Modified by: Costas Manousakis-(Designer)-(7/10/20 11:07:26)
	Mods_2020_07_bug
	//  `moved $columns_atxt{2}:=f_TrimStr inside if(Size of array($columns_atxt)>1)
	// Modified by: Costas Manousakis-(Designer)-(7/28/20 13:47:30)
	Mods_2020_07_bug
	//  `moved $columns_atxt{2}:=f_TrimStr at the start of the if() statement. Call Reference #735
End if 
//

C_TEXT:C284($fromExcel_txt)

$fromExcel_txt:=Get text from pasteboard:C524
ARRAY TEXT:C222($Lines_atxt; 0)
ut_TextToArray($fromExcel_txt; ->$Lines_atxt; Char:C90(13))
C_LONGINT:C283($loop_L; $Lines_L)
C_TEXT:C284($BIN_txt; $MiscData_txt; $BDEPT_txt)
C_REAL:C285($TotSal_r; $TotHrs_r; $TotDirExp_r; $MiscItemCost_r)
READ ONLY:C145([Bridge MHD NBIS:1])
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY REAL:C219($Hours_ar; 0)
ARRAY REAL:C219($Salary_ar; 0)
ARRAY REAL:C219($DirExp_ar; 0)
ARRAY REAL:C219($MiscItem_ar; 0)
ARRAY REAL:C219($DirExpItems_ar; 0; 0)
ARRAY TEXT:C222($Comments_atxt; 0)
C_BOOLEAN:C305($ErrorParsingPasteboard_b)
$ErrorParsingPasteboard_b:=False:C215
C_TEXT:C284($BDEPTBIN_Pattern_txt)
//zero or more spaces + one letter + zero or one minus + two numbers + zero or one minus + 3 numbers + zero or more spaces + three letters or numbers
$BDEPTBIN_Pattern_txt:="([A-Z,0-9]{3})"

ARRAY TEXT:C222($consNames_atxt; 0)
ARRAY LONGINT:C221($consLFCol_aL; 0)
ARRAY LONGINT:C221($consDCCol_aL; 0)
ARRAY LONGINT:C221($consHRSCol_aL; 0)
ARRAY TEXT:C222($MiscItem_atxt; 0)
ARRAY LONGINT:C221($MiscItemCol_aL; 0)
ARRAY TEXT:C222($Items_atxt; 0)
ARRAY LONGINT:C221($ItemColumns_aL; 0)
C_LONGINT:C283($startItems_L)
$startItems_L:=5
APPEND TO ARRAY:C911($Items_atxt; "RIGGING")
APPEND TO ARRAY:C911($Items_atxt; "LIFTS")
APPEND TO ARRAY:C911($Items_atxt; "TRAFFIC CONTROL")
APPEND TO ARRAY:C911($Items_atxt; "POLICE")
APPEND TO ARRAY:C911($Items_atxt; "PRINTING")
APPEND TO ARRAY:C911($Items_atxt; "MILEAGE")
APPEND TO ARRAY:C911($Items_atxt; "LODGING")
APPEND TO ARRAY:C911($Items_atxt; "POSTAGE")
APPEND TO ARRAY:C911($Items_atxt; "BARGE")
APPEND TO ARRAY:C911($Items_atxt; "SAFETY BOAT")
APPEND TO ARRAY:C911($Items_atxt; "SNOOPER")
APPEND TO ARRAY:C911($Items_atxt; "RR FLAGGING/PERMITS")

ARRAY LONGINT:C221($ItemColumns_aL; Size of array:C274($Items_atxt))
ARRAY POINTER:C280($ItemFields_aptr; Size of array:C274($Items_atxt))  //to be filled later depending on whether we are insp or rating

C_LONGINT:C283($TotSalCol_L; $TotHrsCol_L; $TotalDirExpCol_L; $StartSubsCol_L)
C_TEXT:C284($SubLFPattern_txt; $SubDCPattern_txt; $SubHrsPattern_txt)
$TotSalCol_L:=3
$TotHrsCol_L:=4
//$TotalDirExpCol_L:=10
$StartSubsCol_L:=17
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
	//$TotalDirExpCol_L:=13
	$StartSubsCol_L:=18
	$SubLFPattern_txt:="LF @"
	$SubDCPattern_txt:="DC @"
	$SubHrsPattern_txt:="Hours @"
End if 
$Lines_L:=0
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
		C_BOOLEAN:C305($FoundBDEPTBIN_b; $FoundHeader_b; $IgnoreBridge_b)
		ARRAY LONGINT:C221($pos_aL; 0)
		ARRAY LONGINT:C221($Len_aL; 0)
		If (Size of array:C274($columns_atxt)>1)
			$columns_atxt{2}:=f_TrimStr($columns_atxt{2}; True:C214; True:C214)
			$FoundBDEPTBIN_b:=(Match regex:C1019($BDEPTBIN_Pattern_txt; $columns_atxt{2}; 1; $pos_aL; $Len_aL) & (Length:C16($columns_atxt{2})=3))
			$FoundHeader_b:=(Position:C15("BRIDGE NUMBER"; $columns_atxt{1})>0) | $FoundHeader_b
			$IgnoreBridge_b:=(Length:C16($columns_atxt{2})=0)
		End if 
		Case of 
			: (Size of array:C274($columns_atxt)<16)
				$ErrorParsingPasteboard_b:=True:C214
				ALERT:C41("Error Parsing line number "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\rFound less than 16 columns!")
				$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
			: ($IgnoreBridge_b)
				//nothing to do here
			: ((Not:C34($FoundBDEPTBIN_b)) & Not:C34($FoundHeader_b))
				$ErrorParsingPasteboard_b:=True:C214
				ALERT:C41("Error Parsing line number "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\\Second Column is not a BIN or first column not a HEADER line !")
				$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
			: ($FoundBDEPTBIN_b & Not:C34($FoundHeader_b))
				$ErrorParsingPasteboard_b:=True:C214
				ALERT:C41("Error Parsing line number "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\rFound a BridgeNumber BIN Line but have not found a HEADER line!")
				$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
				
			: ($FoundBDEPTBIN_b)
				//get BIN it is the second column
				$BIN_txt:=$columns_atxt{2}
				$BDEPT_txt:=$columns_atxt{1}
				$BDEPT_txt:=f_TrimStr($BDEPT_txt; True:C214; True:C214)
				$BDEPT_txt:=Replace string:C233($BDEPT_txt; "-"; "")
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_txt; *)
				QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]BDEPT:1=$BDEPT_txt)
				If (Records in selection:C76([Bridge MHD NBIS:1])=0)
					$ErrorParsingPasteboard_b:=True:C214
					ALERT:C41("Error Parsing line number "+String:C10($loop_L)+" :\rBrdige Number "+$columns_atxt{1}+" does not match BIN "+$BIN_txt+"! Import aborted!")
					$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
				End if 
				
				$TotSal_r:=Num:C11($columns_atxt{$TotSalCol_L})
				$TotHrs_r:=Num:C11($columns_atxt{$TotHrsCol_L})
				$TotDirExp_r:=0
				$MiscItemCost_r:=0
				APPEND TO ARRAY:C911($Bins_atxt; $BIN_txt)
				APPEND TO ARRAY:C911($Hours_ar; $TotHrs_r)
				APPEND TO ARRAY:C911($Salary_ar; $TotSal_r)
				$MiscData_txt:=""
				//Pre-defined Item data
				C_LONGINT:C283($BinRow_L)
				$BinRow_L:=Size of array:C274($DirExpItems_ar)+1
				INSERT IN ARRAY:C227($DirExpItems_ar; $BinRow_L; 1)
				ARRAY REAL:C219($DirExpItems_ar{$BinRow_L}; Size of array:C274($Items_atxt))
				C_LONGINT:C283($Itemloop_L)
				C_REAL:C285($ItemCost_r)
				For ($Itemloop_L; 1; Size of array:C274($Items_atxt))
					If ($ItemColumns_aL{$Itemloop_L}>0)
						$ItemCost_r:=Num:C11($columns_atxt{$ItemColumns_aL{$Itemloop_L}})
						$DirExpItems_ar{$BinRow_L}{$Itemloop_L}:=$ItemCost_r
						$TotDirExp_r:=$TotDirExp_r+$ItemCost_r
					End if 
				End for 
				
				//Misc Item data
				C_LONGINT:C283($Cloop_L)
				For ($Cloop_L; 1; Size of array:C274($MiscItem_atxt))
					If ($MiscItemCol_aL{$Cloop_L}>0)
						$ItemCost_r:=Num:C11($columns_atxt{$MiscItemCol_aL{$Cloop_L}})
						If ($ItemCost_r>0)
							$MiscItemCost_r:=$MiscItemCost_r+$ItemCost_r
							
							If ($MiscData_txt="")
								$MiscData_txt:=$MiscData_txt+$MiscItem_atxt{$Cloop_L}+": "+String:C10($ItemCost_r; "$ ###,###,###,###.00;;0")
							Else 
								$MiscData_txt:=$MiscData_txt+Char:C90(13)+$MiscItem_atxt{$Cloop_L}+": "+String:C10($ItemCost_r; "$ ###,###,###,###.00;;0")
							End if 
							
						End if 
						
					End if 
					
				End for 
				
				//Consultant data
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
							$MiscItemCost_r:=$MiscItemCost_r+$LF_r
						End if 
					End if 
					If ($consDCCol_aL{$Cloop_L}>0)
						$DC_r:=Num:C11($columns_atxt{$consDCCol_aL{$Cloop_L}})
						If ($DC_r>0)
							$ConsData_txt:=$ConsData_txt+String:C10($DC_r; "$ ###,###,###,###.00;;0")+" DC"
							$MiscItemCost_r:=$MiscItemCost_r+$DC_r
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
				C_TEXT:C284($comnts_txt)
				$comnts_txt:=""
				If ($ConsCmts_txt#"") | ($MiscData_txt#"")
					$comnts_txt:="Misc :"
					If ($ConsCmts_txt#"")
						$comnts_txt:=$comnts_txt+Char:C90(13)+$ConsCmts_txt
					End if 
					If ($MiscData_txt#"")
						$comnts_txt:=$comnts_txt+Char:C90(13)+$MiscData_txt
					End if 
				End if 
				APPEND TO ARRAY:C911($MiscItem_ar; $MiscItemCost_r)
				$TotDirExp_r:=$TotDirExp_r+$MiscItemCost_r
				APPEND TO ARRAY:C911($DirExp_ar; $TotDirExp_r)
				APPEND TO ARRAY:C911($Comments_atxt; $comnts_txt)
				
			: ($FoundHeader_b)
				//verify column numbers of direct cost items -start from column 5
				C_LONGINT:C283($Cloop_L; $consInx_L; $itmIndex_L)
				C_TEXT:C284($columnName_txt)
				For ($Cloop_L; 5; Size of array:C274($columns_atxt))
					$columns_atxt{$Cloop_L}:=f_TrimStr($columns_atxt{$Cloop_L}; True:C214; True:C214)
				End for 
				C_LONGINT:C283($lastCol_L; $firstCol_L; $numItems_L)
				$lastCol_L:=0  //last column where standard items are
				$firstCol_L:=Size of array:C274($columns_atxt)+1
				$numItems_L:=0
				C_TEXT:C284($MatchedItems_txt; $UnknownItems_txt; $DuplicateItems_txt)
				$UnknownItems_txt:=""
				$MatchedItems_txt:=""
				$DuplicateItems_txt:=""
				For ($Cloop_L; 1; Size of array:C274($Items_atxt))
					$itmIndex_L:=Find in array:C230($columns_atxt; $Items_atxt{$Cloop_L})
					
					$ItemColumns_aL{$Cloop_L}:=$itmIndex_L
					
					If ($itmIndex_L>0)
						$numItems_L:=$numItems_L+1
						If ($itmIndex_L>$lastCol_L)
							$lastCol_L:=$itmIndex_L
						End if 
						If ($itmIndex_L<$firstCol_L)
							$firstCol_L:=$itmIndex_L
						End if 
						
						If ($MatchedItems_txt="")
							$MatchedItems_txt:=$MatchedItems_txt+$Items_atxt{$Cloop_L}
						Else 
							$MatchedItems_txt:=$MatchedItems_txt+", "+$Items_atxt{$Cloop_L}
						End if 
						$itmIndex_L:=Find in array:C230($columns_atxt; $Items_atxt{$Cloop_L}; ($itmIndex_L+1))
						If ($itmIndex_L>0)
							//we found this one multiple times
							
							If ($DuplicateItems_txt="")
								$DuplicateItems_txt:=$Items_atxt{$Cloop_L}
							Else 
								$DuplicateItems_txt:=$DuplicateItems_txt+", "+$Items_atxt{$Cloop_L}
							End if 
							
						End if 
					End if 
				End for 
				
				Case of 
					: ($numItems_L=0)
						//did not find any of the standard direct cost items
						$ErrorParsingPasteboard_b:=True:C214
						ALERT:C41("Error Parsing Header "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\rThere are NO standard Direct Cost Items (Rigging, Lifts, etc.) in the header! Import aborted!")
						$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
					: ($DuplicateItems_txt#"")
						//some standard items were duplicated in the header
						$ErrorParsingPasteboard_b:=True:C214
						ALERT:C41("Error Parsing Header "+String:C10($loop_L)+" :\r"+$Lines_atxt{$loop_L}+"\r\rThe following standard direct cost items were duplicated : "+$DuplicateItems_txt+"! Import aborted!")
						$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
					Else 
						//find if there are any unmatched items in between the first and last column
						$UnknownItems_txt:=""
						For ($Cloop_L; $firstCol_L; $lastCol_L)
							If (Find in array:C230($Items_atxt; $columns_atxt{$Cloop_L})>0)
							Else 
								
								If ($UnknownItems_txt="")
									$UnknownItems_txt:=$columns_atxt{$Cloop_L}
								Else 
									$UnknownItems_txt:=$UnknownItems_txt+", "+$columns_atxt{$Cloop_L}
								End if 
								
							End if 
							
						End for 
						
						$StartSubsCol_L:=$lastCol_L+1
						//handle header for misc items and  sub consultants - they start from column "Q" = 17
						C_TEXT:C284($consname_txt; $MiscItems_txt; $consNames_txt)
						C_LONGINT:C283($lastConsColumn_L)
						C_BOOLEAN:C305($foundCons_b)
						$consname_txt:=""
						$MiscItems_txt:=""
						$consNames_txt:=""
						$lastConsColumn_L:=0
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
									$lastConsColumn_L:=$Cloop_L
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
									$lastConsColumn_L:=$Cloop_L
									
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
									$lastConsColumn_L:=$Cloop_L
									If ($consInx_L>0)
										$consHRSCol_aL{$consInx_L}:=$Cloop_L
									Else 
										APPEND TO ARRAY:C911($consNames_atxt; $consname_txt)
										APPEND TO ARRAY:C911($consLFCol_aL; 0)
										APPEND TO ARRAY:C911($consDCCol_aL; 0)
										APPEND TO ARRAY:C911($consHRSCol_aL; $Cloop_L)
									End if 
								Else 
									//misc item
									If (($columns_atxt{$Cloop_L}#"") & ($lastConsColumn_L=0))
										APPEND TO ARRAY:C911($MiscItem_atxt; $columns_atxt{$Cloop_L})
										APPEND TO ARRAY:C911($MiscItemCol_aL; $Cloop_L)
										
										If ($MiscItems_txt="")
											$MiscItems_txt:=$columns_atxt{$Cloop_L}
										Else 
											$MiscItems_txt:=$MiscItems_txt+", "+$columns_atxt{$Cloop_L}
										End if 
										
									End if 
							End case 
							
						End for 
						
						//Bring up results of parsing the header and ask confirmation
						C_TEXT:C284($Msg_txt)
						If ($numItems_L#Size of array:C274($Items_atxt))
							$Msg_txt:=Uppercase:C13("ALERT!!! NOT ALL Standard direct cost items found in the header!")+Char:C90(13)+Char:C90(13)
						End if 
						$Msg_txt:=$Msg_txt+"Found the following standard direct cost items : "+$MatchedItems_txt+Char:C90(13)+Char:C90(13)
						If ($UnknownItems_txt#"")
							$Msg_txt:=$Msg_txt+"Found the following unknown items among the standard cost items : "+$UnknownItems_txt+Char:C90(13)+Char:C90(13)
						End if 
						If ($MiscItems_txt#"")
							$Msg_txt:=$Msg_txt+"The following items will be included under Miscellaneous : "+$MiscItems_txt+Char:C90(13)+Char:C90(13)
						End if 
						If (Size of array:C274($consNames_atxt)>0)
							C_LONGINT:C283($consloop_L)
							$consNames_txt:=$consNames_atxt{1}
							For ($consloop_L; 2; Size of array:C274($consNames_atxt))
								$consNames_txt:=$consNames_txt+", "+$consNames_atxt{$consloop_L}
							End for 
							$Msg_txt:=$Msg_txt+"Found the following Consultants : "+$consNames_txt+"   Note: Only columns with data will be used."
						End if 
						
						G_MyConfirm($Msg_txt; "Continue with Import"; "Cancel")
						
						If (OK=1)
							
						Else 
							$ErrorParsingPasteboard_b:=True:C214
							$loop_L:=Size of array:C274($Lines_atxt)+1  //exit parsing
							
						End if 
						
				End case 
				
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
		ALERT:C41("No data found in paste buffer")
	Else 
		//find where we are (raitng or inspection)
		C_POINTER:C301($HoursFld_ptr; $SalaryFld_ptr; $DirCostFld_ptr; $FinalCost_ptr; $IndirCost_ptr; $netFee_ptr; $totLimFee_ptr; $TotCost_ptr; $FinalMark_ptr)
		C_POINTER:C301($Table_ptr; $CostTbl_ptr; $BIN_ptr; $AssignNo_ptr; $ContrNo_ptr; $CostRecID_ptr; $RecID_ptr; $Cmts_ptr; $MiscItem_ptr)
		Case of 
			: (Current form table:C627=(->[Conslt Rating:63]))
				$Table_ptr:=->[Conslt Rating:63]
				$CostTbl_ptr:=->[Conslt Rating Cost:74]
				$BIN_ptr:=->[Conslt Rating:63]BIN:1
				$RecID_ptr:=->[Conslt Rating:63]ConsltRatingID:42
				$AssignNo_ptr:=->[Conslt Rating:63]AssignNoRat:12
				$ContrNo_ptr:=->[Conslt Rating:63]ContractNoRat:14
				$CostRecID_ptr:=->[Conslt Rating Cost:74]ConsltRatingID:1
				
				$HoursFld_ptr:=->[Conslt Rating Cost:74]Neg WorkHours:2
				$SalaryFld_ptr:=->[Conslt Rating Cost:74]Neg Salary:3
				$DirCostFld_ptr:=->[Conslt Rating Cost:74]Neg TotalDirectCost:17
				$IndirCost_ptr:=->[Conslt Rating Cost:74]Neg IndirectCost:4
				$netFee_ptr:=->[Conslt Rating Cost:74]Neg NetFee:5
				$totLimFee_ptr:=->[Conslt Rating Cost:74]Neg TotalLimitFee:6
				$TotCost_ptr:=->[Conslt Rating Cost:74]Neg TotalCost:18
				$FinalMark_ptr:=->[Conslt Rating Cost:74]FinalCost_B:41
				$Cmts_ptr:=->[Conslt Rating Cost:74]Neg Comments:19
				$ItemFields_aptr{1}:=->[Conslt Rating Cost:74]Neg Rigging:8
				$ItemFields_aptr{2}:=->[Conslt Rating Cost:74]Neg Lifts:9
				$ItemFields_aptr{3}:=->[Conslt Rating Cost:74]Neg TrafficControl:10
				$ItemFields_aptr{4}:=->[Conslt Rating Cost:74]Neg Police:11
				$ItemFields_aptr{5}:=->[Conslt Rating Cost:74]Neg Printing:12
				$ItemFields_aptr{6}:=->[Conslt Rating Cost:74]Neg Mileage:13
				$ItemFields_aptr{7}:=->[Conslt Rating Cost:74]Neg Lodging:14
				$ItemFields_aptr{8}:=->[Conslt Rating Cost:74]Neg Postage:15
				$ItemFields_aptr{9}:=->[Conslt Rating Cost:74]Neg Barge:42
				$ItemFields_aptr{10}:=->[Conslt Rating Cost:74]Neg SafetyBoat:43
				$ItemFields_aptr{11}:=->[Conslt Rating Cost:74]Neg Snooper:44
				$ItemFields_aptr{12}:=->[Conslt Rating Cost:74]Neg RRflagging:45
				$miscItem_ptr:=->[Conslt Rating Cost:74]Neg Misc:37
				//$FinalMark_ptr
			: (Current form table:C627=(->[Cons Inspection:64]))
				$Table_ptr:=->[Cons Inspection:64]
				$CostTbl_ptr:=->[Cons Inspection Cost:76]
				$BIN_ptr:=->[Cons Inspection:64]BIN:1
				$RecID_ptr:=->[Cons Inspection:64]ConsInspectionID:32
				$AssignNo_ptr:=->[Cons Inspection:64]AssignConNumber:6
				$ContrNo_ptr:=->[Cons Inspection:64]ConContractNo:7
				$CostRecID_ptr:=->[Cons Inspection Cost:76]ConsInspectionID:1
				
				$HoursFld_ptr:=->[Cons Inspection Cost:76]Neg WorkHours:2
				$SalaryFld_ptr:=->[Cons Inspection Cost:76]Neg Salary:3
				$DirCostFld_ptr:=->[Cons Inspection Cost:76]Neg TotalDirectCost:18
				$IndirCost_ptr:=->[Cons Inspection Cost:76]Neg IndirectCost:4
				$netFee_ptr:=->[Cons Inspection Cost:76]Neg NetFee:5
				$totLimFee_ptr:=->[Cons Inspection Cost:76]Neg TotalLimitFee:6
				$TotCost_ptr:=->[Cons Inspection Cost:76]Neg TotalCost:19
				$Cmts_ptr:=->[Cons Inspection Cost:76]Neg Comments:20
				$ItemFields_aptr{1}:=->[Cons Inspection Cost:76]Neg Rigging:8
				$ItemFields_aptr{2}:=->[Cons Inspection Cost:76]Neg Lifts:9
				$ItemFields_aptr{3}:=->[Cons Inspection Cost:76]Neg TrafficControl:10
				$ItemFields_aptr{4}:=->[Cons Inspection Cost:76]Neg Police:11
				$ItemFields_aptr{5}:=->[Cons Inspection Cost:76]Neg Printing:12
				$ItemFields_aptr{6}:=->[Cons Inspection Cost:76]Neg Mileage:13
				$ItemFields_aptr{7}:=->[Cons Inspection Cost:76]Neg Lodging:14
				$ItemFields_aptr{8}:=->[Cons Inspection Cost:76]Neg Postage:15
				$ItemFields_aptr{9}:=->[Cons Inspection Cost:76]Neg Barge:41
				$ItemFields_aptr{10}:=->[Cons Inspection Cost:76]Neg SafetyBoat:42
				$ItemFields_aptr{11}:=->[Cons Inspection Cost:76]Neg Snooper:43
				$ItemFields_aptr{12}:=->[Cons Inspection Cost:76]Neg RRflagging:44
				$miscItem_ptr:=->[Cons Inspection Cost:76]Neg Misc:17
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
				C_REAL:C285(netFeeRate; overheadRate)
				CIR_GetRates($ContractNos_atxt{1}; $AssignNos_aL{1})
				
				Case of 
					: ((netFeeRate=0) & (overheadRate=0))
						ALERT:C41("NetFee Rate ("+String:C10(netFeeRate)+") and Overhead Rate ("+String:C10(overheadRate)+") are zero! Indirect Cost and Net Fee will not be updated!")
					: (netFeeRate=0)
						ALERT:C41("NetFee Rate ("+String:C10(netFeeRate)+") is zero! Net Fee will not be updated!")
					: (overheadRate=0)
						ALERT:C41("Overhead Rate ("+String:C10(overheadRate)+") is zero! Indirect Cost will not be updated!")
				End case 
				C_TEXT:C284($Msg_txt)
				$Msg_txt:="Ready to update actual costs for Contract no "+$ContractNos_atxt{1}+", Assignment "+String:C10($AssignNos_aL{1})+" in "+String:C10(Size of array:C274($ListedBINs_atxt))+" bridges?"
				$Msg_txt:=$Msg_txt+" Please note that for this assignment, current OH rate = "+String:C10(overheadRate; "#,###.00 %")+" and Net Fee rate = "+String:C10(netFeeRate; "#,###.00 %")
				CONFIRM:C162($Msg_txt; "Update"; "Cancel")
				If (OK=1)
					
					C_LONGINT:C283($PasteBufferIndex_L; $UpdatedRecs_L)
					C_BOOLEAN:C305($updateCost_b; $SaveTransaction_b)
					$UpdatedRecs_L:=0
					$SaveTransaction_b:=True:C214
					START TRANSACTION:C239
					SHORT_MESSAGE("Updating....")
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
							$miscItem_ptr->:=$MiscItem_ar{$PasteBufferIndex_L}
							//do each item
							C_LONGINT:C283($Itemloop_L)
							For ($Itemloop_L; 1; Size of array:C274($ItemFields_aptr))
								$ItemFields_aptr{$Itemloop_L}->:=$DirExpItems_ar{$PasteBufferIndex_L}{$Itemloop_L}
							End for 
							
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
					CLOSE WINDOW:C154
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

//End NegotiatedDataToAssignmnt