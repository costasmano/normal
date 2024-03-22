//%attributes = {"invisible":true}
// Method: BrgRank_DoRankCalc
// Description
//  ` Do the setup and Run Calculations for the Bridge Rank
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/20/14, 12:19:58
	// ----------------------------------------------------
	// First Release
	Mods_2014_05
	// Modified by: Costas Manousakis-(Designer)-(12/1/17 14:21:39)
	Mods_2017_12_bug
	//  `added DOM tree BridgeRankHIChgByAvgCond_txt - used in PM_GetPctDeteriorationByRunDate 
	//  `to get an HI change when there are no data for the current bridge record.
	//  `the dom has pairs of avg bridge cond and avg HI change. the avg bridge cond is 0,1,2,3,4,5,6,7,8,9  
	//  `avg cond = 10 is the overall average of HI change
	//  `fixed bad calculation of the Bridge condition category - use the reported value
	// Modified by: Costas Manousakis-(Designer)-(2021-11-08 10:37:00)
	Mods_2021_11_bug
	//  `replaced FO column with FAIR (True|False)
	//  `Replaced old progress with the 4D progress.
	// Modified by: manousakisc-(Designer)-(11/28/2023 15:45:04)
	Mods_2023_11
	//  removed column in export line after 4dRank ; removed ending tab 
End if 

C_TIME:C306($st; $en)
C_POINTER:C301($sourceTable_ptr; $BinFld_ptr; $twnfld_ptr; $bdept_ptr; $item8_ptr; $distr_ptr; $legacy_ptr; $item7_ptr; $it6_ptr; $aashto_ptr; $sd_ptr; $fo_ptr)
C_POINTER:C301($postStat_ptr; $it22_ptr; $it113_ptr; $it58_ptr; $it59_ptr; $it60_ptr; $it62_ptr; $it29_ptr; $it19_ptr; $it26_ptr; $it100_ptr; $it67_ptr; $it68_ptr)
C_POINTER:C301($sourceTable_ptr; $BinFld_ptr; $twnfld_ptr; $bdept_ptr; $item8_ptr; $distr_ptr; $legacy_ptr; $item7_ptr; $it6_ptr; $aashto_ptr; $sd_ptr; $fo_ptr)
C_POINTER:C301($postStat_ptr; $it22_ptr; $it113_ptr; $it58_ptr; $it59_ptr; $it60_ptr; $it62_ptr; $it29_ptr; $it19_ptr; $it26_ptr; $it100_ptr; $it104_ptr; $it67_ptr)
C_POINTER:C301($it68_ptr; $it27_ptr; $it106_ptr; $it43_ptr; $it75a_ptr; $it96_ptr)

C_BOOLEAN:C305(BridgeRankUseArchive_b)
C_DATE:C307(BridgeRankArchiveDate_d)
C_DATE:C307(BridgeRankPontisMetricDate_d)
C_LONGINT:C283(BridgeRank4DValue_L)
C_TEXT:C284($archivePurpose_txt)
C_BOOLEAN:C305($proceed_b)
C_BOOLEAN:C305($saveResults_b)
C_LONGINT:C283($BridgeRankRunID_L)
ARRAY TEXT:C222($ReportLines_atxt; 0)
ARRAY TEXT:C222($ReportLineBIN_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NotRankReportLines_atxt; 0)
C_TEXT:C284($ReportLines_txt; $ReportHDR_txt)

If (False:C215)
	ARRAY TEXT:C222($RunChoises_atxt; 0)
	APPEND TO ARRAY:C911($RunChoises_atxt; "New Run - Generate Report only")
	APPEND TO ARRAY:C911($RunChoises_atxt; "New Run - Save results in db")
	APPEND TO ARRAY:C911($RunChoises_atxt; "Update existing set of results in db")
	C_LONGINT:C283($runChoise_L)
	$runChoise_L:=G_PickFromList(->$RunChoises_atxt; "Select option")
	$proceed_b:=False:C215
	Case of 
		: ($runChoise_L=1)
			$saveResults_b:=False:C215
			$proceed_b:=True:C214
			CONFIRM:C162("Use Current bridge data or Use data from archive table?"; "Current Data"; "From Archive table")
			$proceed_b:=False:C215
			If (OK=1)
				BridgeRankUseArchive_b:=False:C215
			Else 
				BridgeRankUseArchive_b:=True:C214
				CONFIRM:C162("Creeat new Set of archive records or use Existing?"; "New"; "Existing")
				
				If (OK=1)
					BridgeRankArchiveDate_d:=Current date:C33(*)
					$archivePurpose_txt:="BRIDGERANK"
					QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223="BRIDGERANK"; *)
					QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=BridgeRankArchiveDate_d)
					C_BOOLEAN:C305($DoArchive_b)
					$DoArchive_b:=True:C214
					If (Records in selection:C76([BridgeMHDNBISArchive:139])>0)
						CONFIRM:C162("BRIDGE RANK Archive Set Already exists!"; "Use it"; "Replace it")
						
						If (OK=1)
							$DoArchive_b:=False:C215
						Else 
							DELETE SELECTION:C66([BridgeMHDNBISArchive:139])
						End if 
						
					End if 
					If ($DoArchive_b)
						$st:=Current time:C178
						SHORT_MESSAGE("Creating bridge archive records.....")
						ARCHIVE_Store($archivePurpose_txt; BridgeRankArchiveDate_d; ->[Bridge MHD NBIS:1]; ->[BridgeMHDNBISArchive:139])
						$en:=Current time:C178
						CLOSE WINDOW:C154
						ALERT:C41("Creating bridge archive records Done; started "+String:C10($st)+" - ended "+String:C10($en)+Char:C90(13)+" - elapsed "+String:C10($en-$st))
						BridgeRankArchiveDate_d:=Current date:C33(*)
					End if 
				Else 
					ARRAY TEXT:C222($ArchReasons_as; 0)  //Command Replaced was o_ARRAY string length was 20
					ARRAY DATE:C224($archDates_ad; 0)
					ALL RECORDS:C47([BridgeMHDNBISArchive:139])
					DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveReason_s:223; $ArchReasons_as)
					C_LONGINT:C283($purpos_L; $date_L)
					$purpos_L:=G_PickFromList(->$ArchReasons_as; "Select Purpose")
					
					If ($purpos_L>0)
						$archivePurpose_txt:=$ArchReasons_as{$purpos_L}
						QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$ArchReasons_as{$purpos_L})
						DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveDate_d:224; $archDates_ad)
						SORT ARRAY:C229($archDates_ad; <)
						ARRAY TEXT:C222($archDates_as; Size of array:C274($archDates_ad))  //Command Replaced was o_ARRAY string length was 20
						C_LONGINT:C283($loop_L)
						For ($loop_L; 1; Size of array:C274($archDates_ad))
							$archDates_as{$loop_L}:=String:C10($archDates_ad{$loop_L})
						End for 
						
						$date_L:=G_PickFromList(->$archDates_as; "Select Archive Date")
						
						If ($date_L>0)
							BridgeRankArchiveDate_d:=$archDates_ad{$date_L}
							$proceed_b:=True:C214
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		: ($runChoise_L=2)
			$saveResults_b:=True:C214
			$proceed_b:=True:C214
		: ($runChoise_L=3)
			$saveResults_b:=True:C214
			$proceed_b:=True:C214
	End case 
	
	
End if 

CONFIRM:C162("Use Current bridge data or Use data from archive table?"; "Current Data"; "From Archive table")
$proceed_b:=False:C215
If (OK=1)
	BridgeRankUseArchive_b:=False:C215
	$proceed_b:=True:C214
Else 
	BridgeRankUseArchive_b:=True:C214
	CONFIRM:C162("Creeat new Set of archive records or use Existing?"; "New"; "Existing")
	
	If (OK=1)
		BridgeRankArchiveDate_d:=Current date:C33(*)
		$archivePurpose_txt:="BRIDGERANK"
		$st:=Current time:C178
		QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223="BRIDGERANK"; *)
		QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=BridgeRankArchiveDate_d)
		If ((Records in selection:C76([BridgeMHDNBISArchive:139])>0))
			ALERT:C41("BRIDGERANK archive dated "+String:C10(BridgeRankArchiveDate_d)+" already exists!")
		Else 
			SHORT_MESSAGE("Creating bridge archive records.....")
			ARCHIVE_Store($archivePurpose_txt; BridgeRankArchiveDate_d)
			$en:=Current time:C178
			CLOSE WINDOW:C154
			ALERT:C41("Creating bridge archive records Done; started "+String:C10($st)+" - ended "+String:C10($en)+Char:C90(13)+" - elapsed "+String:C10($en-$st))
			BridgeRankArchiveDate_d:=Current date:C33(*)
			$proceed_b:=True:C214
		End if 
		
	Else 
		ARRAY TEXT:C222($ArchReasons_as; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY DATE:C224($archDates_ad; 0)
		ALL RECORDS:C47([BridgeMHDNBISArchive:139])
		DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveReason_s:223; $ArchReasons_as)
		C_LONGINT:C283($purpos_L; $date_L)
		$purpos_L:=G_PickFromList(->$ArchReasons_as; "Select Purpose")
		
		If ($purpos_L>0)
			$archivePurpose_txt:=$ArchReasons_as{$purpos_L}
			QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$ArchReasons_as{$purpos_L})
			DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveDate_d:224; $archDates_ad)
			SORT ARRAY:C229($archDates_ad; <)
			ARRAY TEXT:C222($archDates_as; Size of array:C274($archDates_ad))  //Command Replaced was o_ARRAY string length was 20
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($archDates_ad))
				$archDates_as{$loop_L}:=String:C10($archDates_ad{$loop_L})
			End for 
			
			$date_L:=G_PickFromList(->$archDates_as; "Select Archive Date")
			
			If ($date_L>0)
				BridgeRankArchiveDate_d:=$archDates_ad{$date_L}
				$proceed_b:=True:C214
			Else 
				
				If ($archivePurpose_txt="NBI TAPE @")
					//only for NBI TAPE archives - confirm first
					CONFIRM:C162("Use all records of archiive data ["+$archivePurpose_txt+"] regardless of date?"; "Use all"; "Cancel")
					
					If (OK=1)
						$proceed_b:=True:C214
						BridgeRankArchiveDate_d:=!00-00-00!
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 

If ($proceed_b)
	ALL RECORDS:C47([Pontis_Metrics:41])
	ARRAY DATE:C224($PMDates_ad; 0)
	DISTINCT VALUES:C339([Pontis_Metrics:41]PM_ImportDate_d:4; $PMDates_ad)
	SORT ARRAY:C229($PMDates_ad; <)
	ARRAY TEXT:C222($PMDates_atxt; Size of array:C274($PMDates_ad))
	C_LONGINT:C283($loop_L; $pmdate_L)
	For ($loop_L; 1; Size of array:C274($PMDates_atxt))
		$PMDates_atxt{$loop_L}:=String:C10($PMDates_ad{$loop_L})
	End for 
	$pmdate_L:=G_PickFromList(->$PMDates_atxt; "Select Pontis Import date. Cancel Selects the latest date.")
	If ($pmdate_L>0)
		BridgeRankPontisMetricDate_d:=$PMDates_ad{$pmdate_L}
	Else 
		BridgeRankPontisMetricDate_d:=$PMDates_ad{1}  //latest one
	End if 
	
	If (Not:C34(BridgeRankUseArchive_b))
		$sourceTable_ptr:=->[Bridge MHD NBIS:1]
		$BinFld_ptr:=->[Bridge MHD NBIS:1]BIN:3
		$twnfld_ptr:=->[Bridge MHD NBIS:1]Town Name:175
		$bdept_ptr:=->[Bridge MHD NBIS:1]BDEPT:1
		$item8_ptr:=->[Bridge MHD NBIS:1]Item8:206
		$distr_ptr:=->[Bridge MHD NBIS:1]Item2:60
		$legacy_ptr:=->[Bridge MHD NBIS:1]LegacyOwner:226
		$item7_ptr:=->[Bridge MHD NBIS:1]Item7:65
		$it6_ptr:=->[Bridge MHD NBIS:1]Item6A:63
		$aashto_ptr:=->[Bridge MHD NBIS:1]AASHTO:5
		$sd_ptr:=->[Bridge MHD NBIS:1]StructDef:103
		$fo_ptr:=->[Bridge MHD NBIS:1]FunctObs:106
		$postStat_ptr:=->[Bridge MHD NBIS:1]PostingStatus:8
		$it22_ptr:=->[Bridge MHD NBIS:1]Item22:128
		$it113_ptr:=->[Bridge MHD NBIS:1]Item113:151
		$it58_ptr:=->[Bridge MHD NBIS:1]Item58:130
		$it59_ptr:=->[Bridge MHD NBIS:1]Item59:131
		$it60_ptr:=->[Bridge MHD NBIS:1]Item60:132
		$it62_ptr:=->[Bridge MHD NBIS:1]Item62:134
		$it29_ptr:=->[Bridge MHD NBIS:1]Item29:88
		$it19_ptr:=->[Bridge MHD NBIS:1]Item19:91
		$it26_ptr:=->[Bridge MHD NBIS:1]Item26:120
		$it100_ptr:=->[Bridge MHD NBIS:1]Item100:121
		$it104_ptr:=->[Bridge MHD NBIS:1]Item104:119
		$it67_ptr:=->[Bridge MHD NBIS:1]Item67:142
		$it68_ptr:=->[Bridge MHD NBIS:1]Item68:143
		$it27_ptr:=->[Bridge MHD NBIS:1]Item27:83
		$it106_ptr:=->[Bridge MHD NBIS:1]Item106:84
		$it43_ptr:=->[Bridge MHD NBIS:1]Item43:75
		$it75a_ptr:=->[Bridge MHD NBIS:1]Item75A:152
		$it96_ptr:=->[Bridge MHD NBIS:1]Item96:157
		
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	Else 
		$sourceTable_ptr:=->[BridgeMHDNBISArchive:139]
		$BinFld_ptr:=->[BridgeMHDNBISArchive:139]BIN:3
		$twnfld_ptr:=->[BridgeMHDNBISArchive:139]Town Name:174
		$bdept_ptr:=->[BridgeMHDNBISArchive:139]BDEPT:1
		$item8_ptr:=->[BridgeMHDNBISArchive:139]Item8:203
		$distr_ptr:=->[BridgeMHDNBISArchive:139]Item2:59
		$legacy_ptr:=->[BridgeMHDNBISArchive:139]LegacyOwner:225
		$item7_ptr:=->[BridgeMHDNBISArchive:139]Item7:64
		$it6_ptr:=->[BridgeMHDNBISArchive:139]Item6A:62
		$aashto_ptr:=->[BridgeMHDNBISArchive:139]AASHTO:5
		$sd_ptr:=->[BridgeMHDNBISArchive:139]StructDef:102
		$fo_ptr:=->[BridgeMHDNBISArchive:139]FunctObs:105
		$postStat_ptr:=->[BridgeMHDNBISArchive:139]PostingStatus:8
		$it22_ptr:=->[BridgeMHDNBISArchive:139]Item22:127
		$it113_ptr:=->[BridgeMHDNBISArchive:139]Item113:150
		$it58_ptr:=->[BridgeMHDNBISArchive:139]Item58:129
		$it59_ptr:=->[BridgeMHDNBISArchive:139]Item59:130
		$it60_ptr:=->[BridgeMHDNBISArchive:139]Item60:131
		$it62_ptr:=->[BridgeMHDNBISArchive:139]Item62:133
		$it29_ptr:=->[BridgeMHDNBISArchive:139]Item29:87
		$it19_ptr:=->[BridgeMHDNBISArchive:139]Item19:90
		$it26_ptr:=->[BridgeMHDNBISArchive:139]Item26:119
		$it100_ptr:=->[BridgeMHDNBISArchive:139]Item100:120
		$it104_ptr:=->[BridgeMHDNBISArchive:139]Item104:118
		$it67_ptr:=->[BridgeMHDNBISArchive:139]Item67:141
		$it68_ptr:=->[BridgeMHDNBISArchive:139]Item68:142
		$it27_ptr:=->[BridgeMHDNBISArchive:139]Item27:82
		$it106_ptr:=->[BridgeMHDNBISArchive:139]Item106:83
		$it43_ptr:=->[BridgeMHDNBISArchive:139]Item43:74
		$it75a_ptr:=->[BridgeMHDNBISArchive:139]Item75A:151
		$it96_ptr:=->[BridgeMHDNBISArchive:139]Item96:156
		QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$archivePurpose_txt; *)
		If (BridgeRankArchiveDate_d#!00-00-00!)
			QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=BridgeRankArchiveDate_d; *)
		End if 
		QUERY:C277([BridgeMHDNBISArchive:139])
		
		QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]FHWARecord:173=True:C214)
	End if 
	
	$st:=Current time:C178
	
	$ReportHDR_txt:=""
	$ReportHDR_txt:=$ReportHDR_txt+"Town"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"BDEPT"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"BIN"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 8"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"District"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Legacy Owner"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Facility Carried"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Facility Under"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"AASHTO"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Struct Def"+Char:C90(9)
	//$ReportHDR_txt:=$ReportHDR_txt+"Funct Obs"+Char(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Fair"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Posting Status"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 22"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 113"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 58"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 59"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 60"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 62"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"AverageCondition"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"ConditionLost"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"HIChange"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"ScourCriticalCode"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"AdjustedHIChange"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 29"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"ADT Value"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 19"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Detour Value"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 26"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Class Value"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"OnOff"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 100"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 104"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 67"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"StructEvalValue"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 68"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Deck Value"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"HWYEval"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"HWY Eval Factor"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Rank Factor"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"4D FinalRank"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"FinalRank"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"District Rank"+Char:C90(9)
	
	$ReportHDR_txt:=$ReportHDR_txt+"Item 27"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 106"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 43A"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Constr Contract"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Completion"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 75A"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Item 96"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Paint"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Paint Description"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Rating"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Year Painted"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Condition Category"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Bridge Age"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Age Group"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Proj Info num"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Proj Info link"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Description"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Sched Ad Date"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Ad Date"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"TIP"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"PRC Appr Date"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Consultant"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Office Estimate"+Char:C90(9)
	$ReportHDR_txt:=$ReportHDR_txt+"Program"  // of Mods_2023_11
	
	$ReportHDR_txt:=$ReportHDR_txt+Char:C90(13)
	
	CONFIRM:C162("Save Calculations to tables?"; "Save"; "Create Report Only")
	$saveResults_b:=(OK=1)
	$ReportLines_txt:="Bridge Rank Calc date :"+Char:C90(9)+String:C10(Current date:C33(*))+Char:C90(13)
	If (Not:C34(BridgeRankUseArchive_b))
		$ReportLines_txt:=$ReportLines_txt+"Data source :"+Char:C90(9)+"BRIDGE table"+Char:C90(13)
	Else 
		$ReportLines_txt:=$ReportLines_txt+"Data source :"+Char:C90(9)+"BRIDGE ARCHIVE table"+Char:C90(13)
		$ReportLines_txt:=$ReportLines_txt+"ARCHIVE Date :"+Char:C90(9)+String:C10(BridgeRankArchiveDate_d)+Char:C90(13)
		$ReportLines_txt:=$ReportLines_txt+"ARCHIVE Purpose :"+Char:C90(9)+$archivePurpose_txt+Char:C90(13)
	End if 
	
	$ReportLines_txt:=$ReportLines_txt+"PONTIS METRIC Date  "+String:C10(BridgeRankPontisMetricDate_d)+Char:C90(13)
	
	If ($saveResults_b)
		C_BOOLEAN:C305($new_b)
		If (Records in table:C83([BridgeRankCalc:156])>0)
			CONFIRM:C162("Do a new Bridge Calc Run or update existing"; "New"; "Update Existing")
			$new_b:=(OK=1)
		Else 
			$new_b:=True:C214
		End if 
		If (Not:C34($new_b))
			//pick the run to update
			ALL RECORDS:C47([BridgeRankCalc:156])
			ARRAY DATE:C224($brgrundates_ad; 0)
			ARRAY LONGINT:C221($brgrunIds_aL; 0)
			SELECTION TO ARRAY:C260([BridgeRankCalc:156]RunDate_d:2; $brgrundates_ad; [BridgeRankCalc:156]RunID_L:1; $brgrunIds_aL)
			ARRAY TEXT:C222($brgrundates_atxt; Size of array:C274($brgrundates_ad))
			SORT ARRAY:C229($brgrundates_ad; $brgrunIds_aL; <)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($brgrundates_atxt))
				$brgrundates_atxt{$loop_L}:=String:C10($brgrundates_ad{$loop_L})
			End for 
			
			C_LONGINT:C283($runpick_L)
			$runpick_L:=G_PickFromList(->$brgrundates_atxt; "Select Date of Rank Calc to update (Cancel will create a new run)")
			
			If ($runpick_L>0)
				QUERY:C277([BridgeRankCalc:156]; [BridgeRankCalc:156]RunID_L:1=$brgrunIds_aL{$runpick_L})
				
				If (ut_LoadRecordInteractive(->[BridgeRankCalc:156]))
					$BridgeRankRunID_L:=$brgrunIds_aL{$runpick_L}
				Else 
					ALERT:C41("Could not load Requested set of calculations to update it. A new set will be created !")
					$new_b:=True:C214
				End if 
				
			End if 
			
		End if 
		
		If ($new_b)
			Inc_Sequence("BridgeRankCalc"; ->$BridgeRankRunID_L)
			
			CREATE RECORD:C68([BridgeRankCalc:156])
			[BridgeRankCalc:156]RunDate_d:2:=Current date:C33(*)
			[BridgeRankCalc:156]RunID_L:1:=$BridgeRankRunID_L
			
		End if 
		
		If (Not:C34(BridgeRankUseArchive_b))
			[BridgeRankCalc:156]DataSource_s:3:="BRIDGE"
		Else 
			[BridgeRankCalc:156]DataSource_s:3:="ARCHIVE"
			[BridgeRankCalc:156]ArchiveDate_d:4:=BridgeRankArchiveDate_d
			[BridgeRankCalc:156]ArchivePurpose_s:5:=$archivePurpose_txt
		End if 
		
		[BridgeRankCalc:156]PontisMetricDate_d:6:=BridgeRankPontisMetricDate_d
		SAVE RECORD:C53([BridgeRankCalc:156])
		UNLOAD RECORD:C212([BridgeRankCalc:156])
		READ WRITE:C146([BridgeRankResult:157])
		
	End if 
	
	ARRAY REAL:C219($rankfactor; 0)
	ARRAY TEXT:C222($bins; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($binsnotRanked; 0)  //Command Replaced was o_ARRAY string length was 3
	$ReportHDR_txt:=$ReportLines_txt+$ReportHDR_txt
	//APPEND TO ARRAY($ReportLines_atxt;$ReportLines_txt)
	$ReportLines_txt:=""
	FIRST RECORD:C50($sourceTable_ptr->)
	ut_StartMessage(1; "Bridge Rank Calculations"; 450; 300)
	
	If ($saveResults_b)
		ut_Message("Calculating factors and saving to database....."+Char:C90(13))
	Else 
		ut_Message("Calculating factors....."+Char:C90(13))
	End if 
	
	C_TEXT:C284($uniqueKey_s)
	C_TEXT:C284(BridgeRankHIChgByAvgCond_txt)
	BridgeRankHIChgByAvgCond_txt:=""
	C_TEXT:C284($Tree_txt)
	$Tree_txt:=ut_GetSysParameter("PM_AvgHIChgbyCond")
	If ($Tree_txt="")
		ALERT:C41("Parameter PM_AvgHIChgbyCond not Found!")
	Else 
		ON ERR CALL:C155("4D_Errors")
		4DError_b:=False:C215
		BridgeRankHIChgByAvgCond_txt:=DOM Parse XML variable:C720($Tree_txt)
		If (4DError_b)
			ALERT:C41("Error Parsing parameter PM_AvgHIChgbyCond")
			BridgeRankHIChgByAvgCond_txt:=""  //make sure Dom tree is blank if there is an error
		End if 
		ON ERR CALL:C155("")
		4DError_b:=False:C215
		
	End if 
	
	C_LONGINT:C283($brgAge_L)
	ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
	ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)
	READ ONLY:C145([Conslt_Name:127])
	ALL RECORDS:C47([Conslt_Name:127])
	SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; PRJ_ConsultantID_al; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsultantName_atxt)
	
	C_LONGINT:C283(<>ProgressPID)
	If (False:C215)
		//for testing purposes - put a trace marker in here
		QUERY SELECTION:C341($sourceTable_ptr->)
	End if 
	
	DELAY PROCESS:C323(Current process:C322; 10)
	
	//start the bar
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Calculating Total Bridge record count "+String:C10(Records in selection:C76($sourceTable_ptr->)); \
		Records in selection:C76($sourceTable_ptr->); False:C215; " Bridge rec"; 3)
	
	//<>ProgressPID:=StartProgress ("Calculating";"NONE";"Total Bridge record count "+String(Records in selection($sourceTable_ptr->));"Remaining Bridge records:")
	//  //initialize the bar
	//UpdateProgress (1;Records in selection($sourceTable_ptr->))
	C_LONGINT:C283($bridgecount_L)
	$bridgecount_L:=1
	While (Not:C34(End selection:C36($sourceTable_ptr->)))
		BridgeRankingCalculation
		
		$uniqueKey_s:=$BinFld_ptr->+String:C10($BridgeRankRunID_L; (11*"0"))
		
		If ($saveResults_b)
			QUERY:C277([BridgeRankResult:157]; [BridgeRankResult:157]UniqueKey_s:2=$uniqueKey_s)
			If (Records in selection:C76([BridgeRankResult:157])=0)
				CREATE RECORD:C68([BridgeRankResult:157])
				[BridgeRankResult:157]RunID_L:1:=$BridgeRankRunID_L
				[BridgeRankResult:157]UniqueKey_s:2:=$uniqueKey_s
				[BridgeRankResult:157]BIN:3:=$BinFld_ptr->
			Else 
				LOAD RECORD:C52([BridgeRankResult:157])
			End if 
			[BridgeRankResult:157]RankFactor_r:5:=BridgeRankingRankFactor
			[BridgeRankResult:157]HIChangePct_r:6:=BridgeRankingHealthIndexChange
			[BridgeRankResult:157]HWYEvalFactor_r:7:=BridgeRankingHWYEvalValue
			[BridgeRankResult:157]BridgeEvalFactor_r:8:=BridgeRankingEvalFactor
			[BridgeRankResult:157]ConditionLost_r:9:=BridgeRankingConditionLost
			[BridgeRankResult:157]AdjHIChange_r:10:=BridgeRankingAdHealthIndChange
			[BridgeRankResult:157]ADTValue_r:11:=BridgeRankingADTValue
			[BridgeRankResult:157]DetourValue_r:12:=BridgeRankingDetourValue
			[BridgeRankResult:157]ClassValue_r:13:=BridgeRankingClassValue
			[BridgeRankResult:157]StructEvalValue_r:14:=BridgeRankingStrucEvalValue
			[BridgeRankResult:157]DeckValue_r:15:=BridgeRankingDeckValue
			[BridgeRankResult:157]ScourCritical_s:16:=BridgerankingScourCritical
			[BridgeRankResult:157]AvgCondition_r:17:=BridgeRankingAvgCondition
			
			SAVE RECORD:C53([BridgeRankResult:157])
			UNLOAD RECORD:C212([BridgeRankCalc:156])
		End if 
		//export Results
		$ReportLines_txt:=$ReportLines_txt+$twnfld_ptr->+Char:C90(9)  //town
		$ReportLines_txt:=$ReportLines_txt+$bdept_ptr->+Char:C90(9)  //bdept
		$ReportLines_txt:=$ReportLines_txt+$BinFld_ptr->+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+$item8_ptr->+Char:C90(9)  //item 8
		$ReportLines_txt:=$ReportLines_txt+$distr_ptr->+Char:C90(9)  //district
		$ReportLines_txt:=$ReportLines_txt+$legacy_ptr->+Char:C90(9)  //legacy
		$ReportLines_txt:=$ReportLines_txt+$item7_ptr->+Char:C90(9)  //faci carr
		$ReportLines_txt:=$ReportLines_txt+$it6_ptr->+Char:C90(9)  //fac under
		$ReportLines_txt:=$ReportLines_txt+String:C10($aashto_ptr->)+Char:C90(9)  //aashto
		$ReportLines_txt:=$ReportLines_txt+Choose:C955($sd_ptr->; "TRUE"; "FALSE")+Char:C90(9)  //sd
		//$ReportLines_txt:=$ReportLines_txt+FN_IFF ($fo_ptr->;"TRUE";"FALSE")+Char(9)  //fo
		$ReportLines_txt:=$ReportLines_txt+Choose:C955((SIA_BridgeCondRating="FAIR@"); "TRUE"; "FALSE")+Char:C90(9)  //fair
		$ReportLines_txt:=$ReportLines_txt+$postStat_ptr->+Char:C90(9)  //postingstatus
		$ReportLines_txt:=$ReportLines_txt+$it22_ptr->+Char:C90(9)  //item22
		$ReportLines_txt:=$ReportLines_txt+$it113_ptr->+Char:C90(9)  //item113
		$ReportLines_txt:=$ReportLines_txt+$it58_ptr->+Char:C90(9)  //item58
		$ReportLines_txt:=$ReportLines_txt+$it59_ptr->+Char:C90(9)  //59
		$ReportLines_txt:=$ReportLines_txt+$it60_ptr->+Char:C90(9)  //60
		$ReportLines_txt:=$ReportLines_txt+$it62_ptr->+Char:C90(9)  //62
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingAvgCondition)+Char:C90(9)  //[BridgeRankResult]AvgCondition_r
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingConditionLost)+Char:C90(9)  //[BridgeRankResult]ConditionLost_r
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingHealthIndexChange)+Char:C90(9)  //[BridgeRankResult]HIChangePct_r
		$ReportLines_txt:=$ReportLines_txt+BridgerankingScourCritical+Char:C90(9)  //[BridgeRankResult]ScourCritical_s
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingAdHealthIndChange)+Char:C90(9)  //[BridgeRankResult]AdjHIChange_r
		$ReportLines_txt:=$ReportLines_txt+String:C10($it29_ptr->)+Char:C90(9)  //29
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingADTValue)+Char:C90(9)  //[BridgeRankResult]ADTValue_r
		$ReportLines_txt:=$ReportLines_txt+String:C10($it19_ptr->)+Char:C90(9)  //19
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingDetourValue)+Char:C90(9)  //[BridgeRankResult]DetourValue_r
		$ReportLines_txt:=$ReportLines_txt+$it26_ptr->+Char:C90(9)  //26
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingClassValue)+Char:C90(9)  //[BridgeRankResult]ClassValue_r
		$ReportLines_txt:=$ReportLines_txt+QR_Item26OnOff($it26_ptr->)+Char:C90(9)  //100
		$ReportLines_txt:=$ReportLines_txt+$it100_ptr->+Char:C90(9)  //100
		$ReportLines_txt:=$ReportLines_txt+FN_IFF($it104_ptr->; "TRUE"; "FALSE")+Char:C90(9)  //104
		$ReportLines_txt:=$ReportLines_txt+$it67_ptr->+Char:C90(9)  //67
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingStrucEvalValue)+Char:C90(9)  //[BridgeRankResult]StructEvalValue_r
		$ReportLines_txt:=$ReportLines_txt+$it68_ptr->+Char:C90(9)  //68
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingDeckValue)+Char:C90(9)  //[BridgeRankResult]DeckValue_r
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingHWYEvalValue)+Char:C90(9)  //[BridgeRankResult]HWYEvalFactor_r
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingEvalFactor)+Char:C90(9)  //[BridgeRankResult]BridgeEvalFactor_r
		$ReportLines_txt:=$ReportLines_txt+String:C10(BridgeRankingRankFactor)+Char:C90(9)  //[BridgeRankResult]RankFactor_r
		$ReportLines_txt:=$ReportLines_txt+"<!--#4DVAR BridgeRank4DValue_L-->"+Char:C90(9)  //[BridgeRankResult]Rank_L
		//start of Mods_2023_11
		//$ReportLines_txt:=$ReportLines_txt+Char(9)+Char(9)+String($it27_ptr->)+Char(9)  //add two columns for modified rank and district rank
		$ReportLines_txt:=$ReportLines_txt+Char:C90(9)+String:C10($it27_ptr->)+Char:C90(9)  //add one columns for district rank
		//end of Mods_2023_11
		$ReportLines_txt:=$ReportLines_txt+String:C10($it106_ptr->)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+QR_Item43A($it43_ptr->)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+QR_GetConstrContrInfo($BinFld_ptr->)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ConstructionProject:116]CP_Completion_d:8; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+$it75a_ptr->+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10($it96_ptr->)+Char:C90(9)
		//QUERY([Bridge MHD NBIS];[Bridge MHD NBIS]BIN=$BinFld_ptr->)
		$ReportLines_txt:=$ReportLines_txt+QR_SearchElements("paint@"; "RTN,RTA,CMI"; 1; $BinFld_ptr->)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+[ElementsSafety:29]Description:22+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+[ElementsSafety:29]Rating:2+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10([Inspections:27]YrPainted:157; "####;;")+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+QR_BridgeCondCategory(BridgeRankingAvgCondition)+Char:C90(9)
		$brgAge_L:=QR_BridgeAge($it27_ptr->; $it106_ptr->)
		$ReportLines_txt:=$ReportLines_txt+String:C10($brgAge_L)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10(QR_Floor($brgAge_L; 10))+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10(QR_GetProjInfoNo($BinFld_ptr->))+Char:C90(9)+Char:C90(9)  //add column for hyperlink
		$ReportLines_txt:=$ReportLines_txt+Replace string:C233([PRJ_ProjectFile:117]PF_Description_txt:16; Char:C90(13); " ")+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_Advertised_d:14; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+[PRJ_ProjectFile:117]PF_TIP_s:7+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_PRCApprDate_d:20; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+PRJ_QR_ReturnConsultant+Char:C90(9)
		$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_OfficeEstimate_r:13; "#################.###;;")+Char:C90(9)
		//$ReportLines_txt:=$ReportLines_txt+PRJ_QR_ReturnAttributes +Char(9)
		$ReportLines_txt:=$ReportLines_txt+PRJ_QR_ReturnAttributes  // Mods_2023_11
		
		Case of 
			: (BridgeRankingHealthIndexChange=0)
				APPEND TO ARRAY:C911($NotRankReportLines_atxt; $ReportLines_txt)
				APPEND TO ARRAY:C911($binsnotRanked; $BinFld_ptr->)
			: (BridgeRankingAvgCondition<0)
				APPEND TO ARRAY:C911($NotRankReportLines_atxt; $ReportLines_txt)
				APPEND TO ARRAY:C911($binsnotRanked; $BinFld_ptr->)
			Else 
				APPEND TO ARRAY:C911($rankfactor; BridgeRankingRankFactor)
				APPEND TO ARRAY:C911($bins; $BinFld_ptr->)
				APPEND TO ARRAY:C911($ReportLines_atxt; $ReportLines_txt)
				APPEND TO ARRAY:C911($ReportLineBIN_as; $BinFld_ptr->)
		End case 
		
		$ReportLines_txt:=""
		
		If ($bridgecount_L%20=0)
			//update the bar
			//update progress
			UpdateProgressNew($progress_o; $bridgecount_L)
			//UpdateProgress ($bridgecount_L;Records in selection($sourceTable_ptr->))
		End if 
		
		NEXT RECORD:C51($sourceTable_ptr->)
		$bridgecount_L:=$bridgecount_L+1
	End while 
	$en:=Current time:C178
	//CLOSE WINDOW
	ARRAY LONGINT:C221($Ranks_aL; 0)
	SORT ARRAY:C229($rankfactor; $bins; <)
	//stop the progress bar
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	//CALL PROCESS(<>ProgressPID)
	
	//clear the DOM tree
	If (BridgeRankHIChgByAvgCond_txt#"")
		DOM CLOSE XML:C722(BridgeRankHIChgByAvgCond_txt)
	End if 
	
	ut_Message("Ranking bridges ...."+Char:C90(13))
	
	ut_Rank(->$rankfactor; ->$Ranks_aL)
	
	ut_Message("Calculation Done; started "+String:C10($st)+" - ended "+String:C10($en)+Char:C90(13)+" - elapsed "+String:C10($en-$st)+Char:C90(13))
	
	$st:=Current time:C178
	
	If ($saveResults_b)
		ut_Message("Saving final rank to Results table database and to report data ....."+Char:C90(13))
	Else 
		ut_Message("Saving final rank to report data ...."+Char:C90(13))
	End if 
	
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($bins))
		$uniqueKey_s:=$bins{$loop_L}+String:C10($BridgeRankRunID_L; (11*"0"))
		If ($saveResults_b)
			QUERY:C277([BridgeRankResult:157]; [BridgeRankResult:157]UniqueKey_s:2=$uniqueKey_s)
			LOAD RECORD:C52([BridgeRankResult:157])
			[BridgeRankResult:157]Rank_L:4:=$Ranks_aL{$loop_L}
			SAVE RECORD:C53([BridgeRankResult:157])
			
		End if 
		C_LONGINT:C283($arrayIndex_L)
		$arrayIndex_L:=Find in array:C230($ReportLineBIN_as; $bins{$loop_L})
		
		If ($arrayIndex_L>0)
			BridgeRank4DValue_L:=$Ranks_aL{$loop_L}
			$ReportLines_txt:=$ReportLines_atxt{$arrayIndex_L}
			PROCESS 4D TAGS:C816($ReportLines_txt; $ReportLines_txt)
			If (False:C215)
				$ReportLines_atxt{$arrayIndex_L}:=$ReportLines_atxt{$arrayIndex_L}+Char:C90(9)+String:C10($Ranks_aL{$loop_L})
			Else 
				$ReportLines_atxt{$arrayIndex_L}:=$ReportLines_txt
			End if 
			
		End if 
		
	End for 
	
	For ($loop_L; 1; Size of array:C274($binsnotRanked))
		$uniqueKey_s:=$binsnotRanked{$loop_L}+String:C10($BridgeRankRunID_L; (11*"0"))
		If ($saveResults_b)
			QUERY:C277([BridgeRankResult:157]; [BridgeRankResult:157]UniqueKey_s:2=$uniqueKey_s)
			LOAD RECORD:C52([BridgeRankResult:157])
			[BridgeRankResult:157]Rank_L:4:=999999
			SAVE RECORD:C53([BridgeRankResult:157])
		End if 
		
	End for 
	$en:=Current time:C178
	
	ut_Message("Saving Final Rank  Done; started "+String:C10($st)+" - ended "+String:C10($en)+Char:C90(13)+" - elapsed "+String:C10($en-$st)+Char:C90(13))
	
	//store results to file
	C_TIME:C306($reportFile_t)
	ut_Message("Saving Ranked bridges report and getting additional data ("+String:C10(Size of array:C274($ReportLines_atxt))+" bridges)"+Char:C90(13))
	//start the bar
	
	$reportFile_t:=Create document:C266(""; "TEXT")
	
	If (OK=1)
		
		DELAY PROCESS:C323(Current process:C322; 30)
		
		//start the bar
		C_OBJECT:C1216($progress_o)
		$progress_o:=ProgressNew("Ranked Bridges Report"; Size of array:C274($bins); False:C215; " Bridge Recs"; 3)
		
		//<>ProgressPID:=StartProgress ("Ranked Bridges Report";"NONE";"Total Ranked bridges "+String(Size of array($bins));"Bridges remaining")
		//  //initialize the bar
		//UpdateProgress (1;Size of array($bins))
		
		SEND PACKET:C103($reportFile_t; $ReportHDR_txt)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($ReportLines_atxt))
			SEND PACKET:C103($reportFile_t; $ReportLines_atxt{$loop_L}+Char:C90(13))
			
			If (False:C215)
				If (Not:C34(BridgeRankUseArchive_b))
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$bins{$loop_L})
				Else 
					QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]BIN:3=$bins{$loop_L}; *)
					QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=BridgeRankArchiveDate_d; *)
					QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$archivePurpose_txt)
				End if 
				
				$ReportLines_txt:=Char:C90(9)+Char:C90(9)+String:C10($it27_ptr->)+Char:C90(9)  //add two columns for modified rank and district rank
				$ReportLines_txt:=$ReportLines_txt+String:C10($it106_ptr->)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+QR_Item43A($it43_ptr->)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+QR_GetConstrContrInfo($BinFld_ptr->)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ConstructionProject:116]CP_Completion_d:8; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+$it75a_ptr->+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10($it96_ptr->)+Char:C90(9)
				//QUERY([Bridge MHD NBIS];[Bridge MHD NBIS]BIN=$BinFld_ptr->)
				$ReportLines_txt:=$ReportLines_txt+QR_SearchElements("paint@"; "RTN,RTA,CMI"; 1; $BinFld_ptr->)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+[ElementsSafety:29]Description:22+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+[ElementsSafety:29]Rating:2+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10([Inspections:27]YrPainted:157; "####;;")+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+QR_BridgeCondCategory(QR_AverageBridgeCondition)+Char:C90(9)
				$brgAge_L:=QR_BridgeAge($it27_ptr->; $it106_ptr->)
				$ReportLines_txt:=$ReportLines_txt+String:C10($brgAge_L)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10(QR_Floor($brgAge_L; 10))+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10(QR_GetProjInfoNo($BinFld_ptr->))+Char:C90(9)+Char:C90(9)  //add column for hyperlink
				$ReportLines_txt:=$ReportLines_txt+Replace string:C233([PRJ_ProjectFile:117]PF_Description_txt:16; Char:C90(13); " ")+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_Advertised_d:14; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+[PRJ_ProjectFile:117]PF_TIP_s:7+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_PRCApprDate_d:20; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+PRJ_QR_ReturnConsultant+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_OfficeEstimate_r:13; "#################.###;;")+Char:C90(9)
				$ReportLines_txt:=$ReportLines_txt+PRJ_QR_ReturnAttributes+Char:C90(9)
				
				SEND PACKET:C103($reportFile_t; Char:C90(9)+$ReportLines_txt)
				SEND PACKET:C103($reportFile_t; Char:C90(13))
				
			End if 
			//update the bar
			
			If ($loop_L%20=0)
				//update progress
				UpdateProgressNew($progress_o; $loop_L)
				//UpdateProgress ($loop_L;Size of array($bins))
			End if 
			
		End for 
		
		ARRAY TEXT:C222($ReportLines_atxt; 0)
		
		CLOSE DOCUMENT:C267($reportFile_t)
		
		//quit progress
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		//CALL PROCESS(<>ProgressPID)
	End if 
	//stop the progress bar
	
	If (Size of array:C274($NotRankReportLines_atxt)>0)
		ALERT:C41("Saving bridges that were not ranked report and getting additional data ("+String:C10(Size of array:C274($NotRankReportLines_atxt))+" bridges)")
		$reportFile_t:=Create document:C266(""; "TEXT")
		If (OK=1)
			DELAY PROCESS:C323(Current process:C322; 30)
			
			//start the bar
			C_OBJECT:C1216($progress_o)
			$progress_o:=ProgressNew("UnRanked Bridges Report"; Size of array:C274($NotRankReportLines_atxt); False:C215; " Unraked Bridge"; 3)
			
			//  //start the bar
			//<>ProgressPID:=StartProgress ("UnRanked Bridges Report";"NONE";"Total UnRanked bridges "+String(Size of array($NotRankReportLines_atxt));"Bridges remaining")
			//  //initialize the bar
			//UpdateProgress (1;Size of array($NotRankReportLines_atxt))
			
			SEND PACKET:C103($reportFile_t; $ReportHDR_txt)
			
			C_LONGINT:C283($loop_L)
			BridgeRank4DValue_L:=999999
			
			For ($loop_L; 1; Size of array:C274($NotRankReportLines_atxt))
				$ReportLines_txt:=$NotRankReportLines_atxt{$loop_L}
				PROCESS 4D TAGS:C816($ReportLines_txt; $ReportLines_txt)
				SEND PACKET:C103($reportFile_t; $NotRankReportLines_atxt{$loop_L}+Char:C90(13))
				
				If (False:C215)
					If (Not:C34(BridgeRankUseArchive_b))
						QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$binsnotRanked{$loop_L})
					Else 
						QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]BIN:3=$binsnotRanked{$loop_L}; *)
						QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=BridgeRankArchiveDate_d; *)
						QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$archivePurpose_txt)
					End if 
					
					$ReportLines_txt:=Char:C90(9)+Char:C90(9)+String:C10($it27_ptr->)+Char:C90(9)  //add two columns for modified rank and district rank
					$ReportLines_txt:=$ReportLines_txt+String:C10($it106_ptr->)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+QR_Item43A($it43_ptr->)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+QR_GetConstrContrInfo($BinFld_ptr->)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ConstructionProject:116]CP_Completion_d:8; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+$it75a_ptr->+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10($it96_ptr->)+Char:C90(9)
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BinFld_ptr->)
					$ReportLines_txt:=$ReportLines_txt+QR_SearchElements("paint@"; "RTN,RTA,CMI"; 1)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+[ElementsSafety:29]Description:22+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+[ElementsSafety:29]Rating:2+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10([Inspections:27]YrPainted:157)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+QR_BridgeCondCategory(QR_AverageBridgeCondition)+Char:C90(9)
					$brgAge_L:=QR_BridgeAge($it27_ptr->; $it106_ptr->)
					$ReportLines_txt:=$ReportLines_txt+String:C10($brgAge_L)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10(QR_Floor($brgAge_L; 10))+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10(QR_GetProjInfoNo($BinFld_ptr->))+Char:C90(9)+Char:C90(9)  //add column for hyperlink
					$ReportLines_txt:=$ReportLines_txt+Replace string:C233([PRJ_ProjectFile:117]PF_Description_txt:16; Char:C90(13); " ")+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_Advertised_d:14; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+[PRJ_ProjectFile:117]PF_TIP_s:7+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_PRCApprDate_d:20; Internal date short:K1:7+Blank if null date:K1:9)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+PRJ_QR_ReturnConsultant+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+String:C10([PRJ_ProjectFile:117]PF_OfficeEstimate_r:13)+Char:C90(9)
					$ReportLines_txt:=$ReportLines_txt+PRJ_QR_ReturnAttributes+Char:C90(9)
					
					SEND PACKET:C103($reportFile_t; $ReportLines_txt)
					SEND PACKET:C103($reportFile_t; Char:C90(13))
					
				End if 
				If ($loop_L%20=0)
					//update progress
					UpdateProgressNew($progress_o; $loop_L)
					//UpdateProgress ($loop_L;Size of array($NotRankReportLines_atxt))
				End if 
				
			End for 
			
			ARRAY TEXT:C222($NotRankReportLines_atxt; 0)
			
			CLOSE DOCUMENT:C267($reportFile_t)
			//stop the progress bar
			//quit progress
			Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
			//CALL PROCESS(<>ProgressPID)
			
		End if 
		
	End if 
	
	ALERT:C41("Rank Calculations Completed")
	
	ut_CloseMessage
	
End if 
