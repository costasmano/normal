//%attributes = {"invisible":true}
//Method: RTGReport_FindScanned
//Description
// Find a matching scanned report from a Bdept, bin and report date
// requires a prefilled process array of pdf files loaded - calls RTGReport_LoadPDFArray if array is not loaded
// Parameters
// $0 : FileSpecof report with base of system parameter "SCRRPT_BaseSpec"
// $1 : $BDEPT
// $2 : $BIN
// $3 : $RatingReportDate_d

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/19, 17:11:08
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
	
	C_TEXT:C284(RTGReport_FindScanned; $0)
	C_TEXT:C284(RTGReport_FindScanned; $1; $2)
	C_DATE:C307(RTGReport_FindScanned; $3)
	
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1; $2)
C_DATE:C307($3)

C_TEXT:C284($Bdept_txt; $BIN_txt; $matchReport_txt)
C_DATE:C307($ReportDate_d)

$Bdept_txt:=$1
$BIN_txt:=$2
$ReportDate_d:=$3

$matchReport_txt:=""

C_LONGINT:C283($loop_L; $BdeptIndx_L; $reportindx_L; $start_L; $folderPos_L)
C_TEXT:C284($BDept3_txt; $BdeptBIN_txt; $BdeptBIN_rpt_txt; $FileName_txt; $YYYY_txt; $YY_txt; $MM_txt)
C_BOOLEAN:C305($done_b)

$YYYY_txt:=String:C10(Year of:C25($ReportDate_d); "0000")
$YY_txt:=Substring:C12($YYYY_txt; 3; 2)
$MM_txt:=String:C10(Month of:C24($ReportDate_d); "00")

$BDept3_txt:=Substring:C12($Bdept_txt; 1; 3)
$BdeptBIN_txt:=$Bdept_txt+"_"+$BIN_txt
$BdeptBIN_rpt_txt:=$Bdept_txt+"@"+$BIN_txt
$done_b:=False:C215
If (Size of array:C274(v_65_035_atxt)=0)
	//load the array if its empty
	RTGReport_LoadPDFArray
End if 

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
				$matchReport_txt:=v_65_035_atxt{$BdeptIndx_L}
			: ($FileName_txt=($BdeptBIN_rpt_txt+"_@"+$MM_txt+$YY_txt+"@"))
				//matches this format
				$done_b:=True:C214
				$matchReport_txt:=v_65_035_atxt{$BdeptIndx_L}
			: ($FileName_txt=($BdeptBIN_rpt_txt+"-@"+$MM_txt+$YY_txt+"@"))
				//matches this format
				$done_b:=True:C214
				$matchReport_txt:=v_65_035_atxt{$BdeptIndx_L}
			: ($FileName_txt=($BdeptBIN_rpt_txt+" @"+$YYYY_txt+$MM_txt+"@"))
				$done_b:=True:C214
				$matchReport_txt:=v_65_035_atxt{$BdeptIndx_L}
			Else 
				//keep looking
				$start_L:=$BdeptIndx_L+1
		End case 
		
	Else 
		//$matchingScanned_atxt{$loop_L}:="Bridge folder not found"
		$done_b:=True:C214
	End if 
	
Until ($done_b)

$0:=$matchReport_txt
//End RTGReport_FindScanned