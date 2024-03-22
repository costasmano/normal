//%attributes = {"invisible":true}
//Method: RTGReport_LoadPDFArray
//Description
// Load the array of scanned pdf files.
// loads the array in process array v_65_035_atxt - reserved for the UUID field of Ratingreports

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/19, 17:22:0
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
	Mods_2020_07  //Made change to allow for correct info for $ServerMask_txt and $baseSpec_txt
	//Modified by: CJ (7/28/20 11:42:22)
End if 
//

C_TEXT:C284($targetspec_txt; $ServerMask_txt)
//$targetspec_txt:="mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present"
$targetspec_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")  //ending slash

ARRAY TEXT:C222(v_65_035_atxt; 0)  //RatingReports_UUIDKey_s

$targetspec_txt:=Replace string:C233($targetspec_txt; $ServerMask_txt; "")
C_LONGINT:C283($startT_L; $endT_L; $loop_L)

$startT_L:=Milliseconds:C459
SFA_getServerFileList($targetspec_txt; ->v_65_035_atxt; Ignore invisible:K24:16+Recursive parsing:K24:13)
$endT_L:=Milliseconds:C459

C_TEXT:C284($tofile_txt)
C_TIME:C306($doc_t)

If (False:C215)
	//$this:=G_PickFromList (->v_65_035_atxt;"Found these")
	CONFIRM:C162("saving all files to disk")
	
	If (OK=1)
		$tofile_txt:=ut_ArrayToText(->v_65_035_atxt)
		$doc_t:=Create document:C266(""; ".txt")
		CLOSE DOCUMENT:C267($doc_t)
		TEXT TO DOCUMENT:C1237(Document; $tofile_txt)
		
	End if 
	
End if 

For ($loop_L; Size of array:C274(v_65_035_atxt); 1; -1)
	If (v_65_035_atxt{$loop_L}#"@.pdf")
		DELETE FROM ARRAY:C228(v_65_035_atxt; $loop_L; 1)
	End if 
End for 

SORT ARRAY:C229(v_65_035_atxt)

If (False:C215)
	CONFIRM:C162("Saving pdf files to disk")
	
	If (OK=1)
		
		$tofile_txt:=ut_ArrayToText(->v_65_035_atxt)
		$doc_t:=Create document:C266(""; ".txt")
		CLOSE DOCUMENT:C267($doc_t)
		TEXT TO DOCUMENT:C1237(Document; $tofile_txt)
		
	End if 
	
End if 


//End RTGReport_LoadPDFArray