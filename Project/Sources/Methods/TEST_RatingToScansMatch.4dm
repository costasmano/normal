//%attributes = {"invisible":true}
//Method: TEST_RatingToScansMatch
//Description
// test matching of rating report records to scanned ratings
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/30/19, 17:48:46
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
End if 
//

C_TEXT:C284($vbs_out_t; $Volume_txt; $VolumeName_txt; $basePath_txt; $BaseShare_txt; $targetspec_txt; $TrimPath_txt; $openFile_txt; $ServerVol_txt; $ServerMask_txt)
$basePath_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")  //ending slash

ARRAY TEXT:C222($Folders_atxt; 0)

$targetspec_txt:="mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present"

$targetspec_txt:=Replace string:C233($targetspec_txt; $ServerMask_txt; "")
C_LONGINT:C283($startT_L; $endT_L; $this)
CONFIRM:C162("Load Pdfs from disk")
C_TEXT:C284($tofile_txt; $docName_txt)
C_TIME:C306($doc_t)
C_LONGINT:C283($loop_L)
ARRAY TEXT:C222(v_65_035_atxt; 0)  //RatingReports_UUIDKey_s

If (Ok=1)
	$doc_t:=Open document:C264(""; ".txt"; Read mode:K24:5)
	CLOSE DOCUMENT:C267($doc_t)
	$tofile_txt:=Document to text:C1236(Document)
	ut_TextToArray($tofile_txt; ->v_65_035_atxt; Char:C90(Carriage return:K15:38))
Else 
	
	If (False:C215)
		$startT_L:=Milliseconds:C459
		SFA_getServerFileList($targetspec_txt; ->v_65_035_atxt; Ignore invisible:K24:16+Recursive parsing:K24:13)
		$endT_L:=Milliseconds:C459
		
		//$this:=G_PickFromList (->$Folders_atxt;"Found these")
		CONFIRM:C162("saving all files to disk")
		
		If (OK=1)
			$tofile_txt:=ut_ArrayToText(->$Folders_atxt)
			$doc_t:=Create document:C266(""; ".txt")
			CLOSE DOCUMENT:C267($doc_t)
			TEXT TO DOCUMENT:C1237(Document; $tofile_txt)
			
		End if 
		
		For ($loop_L; Size of array:C274($Folders_atxt); 1; -1)
			If ($Folders_atxt{$loop_L}#"@.pdf")
				DELETE FROM ARRAY:C228($Folders_atxt; $loop_L; 1)
			End if 
		End for 
		
		SORT ARRAY:C229($Folders_atxt)
		CONFIRM:C162("Saving pdf files to disk")
		
		If (OK=1)
			
			$tofile_txt:=ut_ArrayToText(->$Folders_atxt)
			$doc_t:=Create document:C266(""; ".txt")
			CLOSE DOCUMENT:C267($doc_t)
			TEXT TO DOCUMENT:C1237(Document; $tofile_txt)
			
		End if 
	Else 
		RTGReport_LoadPDFArray
	End if 
	
End if 

ALL RECORDS:C47([RatingReports:65])

QUERY:C277([RatingReports:65])

ARRAY DATE:C224($ReportDates_ad; 0)
ARRAY TEXT:C222($BDEPTS_atxt; 0)
ARRAY TEXT:C222($BINS_atxt; 0)

SELECTION TO ARRAY:C260([RatingReports:65]ReportDate:4; $ReportDates_ad; [RatingReports:65]BIN:1; $BINS_atxt; [Bridge MHD NBIS:1]BDEPT:1; $BDEPTS_atxt)

C_LONGINT:C283($loop_L; $BdeptIndx_L; $reportindx_L; $start_L; $folderPos_L)
C_TEXT:C284($BDept3_txt; $BdeptBIN_txt; $BdeptBIN_rpt_txt; $FileName_txt; $YYYY_txt; $YY_txt; $MM_txt; $results_txt)
C_BOOLEAN:C305($done_b)
ARRAY TEXT:C222($matchingScanned_atxt; Size of array:C274($ReportDates_ad))
$results_txt:=""
For ($loop_L; 1; Size of array:C274($ReportDates_ad))
	
	If (False:C215)
		$YYYY_txt:=String:C10(Year of:C25($ReportDates_ad{$loop_L}); "0000")
		$YY_txt:=Substring:C12($YYYY_txt; 3; 2)
		$MM_txt:=String:C10(Month of:C24($ReportDates_ad{$loop_L}); "00")
		
		$BDept3_txt:=Substring:C12($BDEPTS_atxt{$loop_L}; 1; 3)
		$BdeptBIN_txt:=$BDEPTS_atxt{$loop_L}+"_"+$BINS_atxt{$loop_L}
		$BdeptBIN_rpt_txt:=$BDEPTS_atxt{$loop_L}+"@"+$BINS_atxt{$loop_L}
		$done_b:=False:C215
		$start_L:=1
		Repeat 
			$BdeptIndx_L:=Find in array:C230(v_65_035_atxt; $BDept3_txt+"@/"+$BdeptBIN_txt+"@"; $start_L)
			If ($BdeptIndx_L>0)
				$FileName_txt:=v_65_035_atxt{$BdeptIndx_L}
				$folderPos_L:=Position:C15("/"; $FileName_txt)
				Repeat 
					$FileName_txt:=Substring:C12($FileName_txt; $folderPos_L+1)
					$folderPos_L:=Position:C15("/"; $FileName_txt)
				Until ($folderPos_L<=0)
				
				Case of 
					: ($FileName_txt=($BdeptBIN_rpt_txt+" @"+$MM_txt+$YY_txt+"@"))
						//matches this format
						$done_b:=True:C214
						$matchingScanned_atxt{$loop_L}:=$Folders_atxt{$BdeptIndx_L}
					: ($FileName_txt=($BdeptBIN_rpt_txt+"_@"+$MM_txt+$YY_txt+"@"))
						//matches this format
						$done_b:=True:C214
						$matchingScanned_atxt{$loop_L}:=$Folders_atxt{$BdeptIndx_L}
					: ($FileName_txt=($BdeptBIN_rpt_txt+"-@"+$MM_txt+$YY_txt+"@"))
						//matches this format
						$done_b:=True:C214
						$matchingScanned_atxt{$loop_L}:=$Folders_atxt{$BdeptIndx_L}
					: ($FileName_txt=($BdeptBIN_rpt_txt+" @"+$YYYY_txt+$MM_txt+"@"))
						$done_b:=True:C214
						$matchingScanned_atxt{$loop_L}:=$Folders_atxt{$BdeptIndx_L}
					Else 
						//keep looking
						$start_L:=$BdeptIndx_L+1
				End case 
				
			Else 
				//$matchingScanned_atxt{$loop_L}:="Bridge folder not found"
				$done_b:=True:C214
			End if 
			
		Until ($done_b)
		
	End if 
	
	$matchingScanned_atxt{$loop_L}:=RTGReport_FindScanned($BDEPTS_atxt{$loop_L}; $BINS_atxt{$loop_L}; $ReportDates_ad{$loop_L})
	
	$results_txt:=$results_txt+$BDEPTS_atxt{$loop_L}+"\t"+$BINS_atxt{$loop_L}+"\t"+String:C10($ReportDates_ad{$loop_L})+"\t"+$matchingScanned_atxt{$loop_L}+"\n"
End for 

CONFIRM:C162("Saving results files to disk")

If (OK=1)
	
	C_TIME:C306($doc_t)
	$doc_t:=Create document:C266(""; ".txt")
	CLOSE DOCUMENT:C267($doc_t)
	TEXT TO DOCUMENT:C1237(Document; $results_txt)
	
End if 


//End TEST_RatingToScansMatch