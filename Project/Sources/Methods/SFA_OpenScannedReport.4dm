//%attributes = {"invisible":true}
//Method: SFA_OpenScannedReport
//Description
// open a scanned rating report from mhd-shared for a bdept/BIN
// Parameters
// $1 : $BDEPT
// $2 : $BIN
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/17, 17:41:52
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	
	C_TEXT:C284(SFA_OpenScannedReport; $1)
	C_TEXT:C284(SFA_OpenScannedReport; $2)
	
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($ServerMask_txt; $targetspec_txt; $opentarget_txt; $baseSpec_txt; $PrevRtgFolder_txt)

//$ServerMask_txt:=  `ending slash
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")

ARRAY TEXT:C222($Folders_atxt; 0)
$baseSpec_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")

$PrevRtgFolder_txt:=ut_GetSysParameter("SCRRPT_PrevRtgFolder"; "Previous Rating Reports")
$targetspec_txt:=$baseSpec_txt
$targetspec_txt:=Replace string:C233($targetspec_txt; $ServerMask_txt; "")

C_TEXT:C284($bdept_txt; $Bin_txt)
$bdept_txt:=$1
$Bin_txt:=$2


READ ONLY:C145([RatingReports:65])
QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=$Bin_txt)
If (Records in selection:C76([RatingReports:65])>0)
	
	ARRAY TEXT:C222($BridgeFolders_atxt; 0)
	SFA_GetBridgeFolder($bdept_txt; $Bin_txt; ->$BridgeFolders_atxt)
	
	ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <)
	FIRST RECORD:C50([RatingReports:65])
	C_TEXT:C284($MMYY_txt)
	$MMYY_txt:=String:C10(Month of:C24([RatingReports:65]ReportDate:4); "00")+Substring:C12(String:C10(Year of:C25([RatingReports:65]ReportDate:4); "0000"); 3)
	C_LONGINT:C283($file_L)
	Case of 
		: (Size of array:C274($BridgeFolders_atxt)=2)
			$targetspec_txt:=$targetspec_txt+"/"+$BridgeFolders_atxt{1}
			SFA_getServerFileList($targetspec_txt; ->$Folders_atxt)
			$file_L:=Find in array:C230($Folders_atxt; ($bdept_txt+"@"+$Bin_txt+"@"+$MMYY_txt+"@"))
			If ($file_L>0)
				$opentarget_txt:=$baseSpec_txt+"/"+$BridgeFolders_atxt{1}+$Folders_atxt{$file_L}
				SFA_openRatingReport($opentarget_txt)
			Else 
				$targetspec_txt:=$targetspec_txt+$PrevRtgFolder_txt
				SFA_getServerFileList($targetspec_txt; ->$Folders_atxt)
				$file_L:=Find in array:C230($Folders_atxt; ($bdept_txt+"@"+$Bin_txt+"@"+$MMYY_txt+"@"))
				
				If ($file_L>0)
					$opentarget_txt:=$baseSpec_txt+"/"+$BridgeFolders_atxt{1}+$PrevRtgFolder_txt+"/"+$Folders_atxt{$file_L}
					SFA_openRatingReport($opentarget_txt)
				Else 
					ALERT:C41("No Rating report for "+$bdept_txt+"("+$Bin_txt+") dated "+String:C10([RatingReports:65]ReportDate:4)+" was found in folder "+$BridgeFolders_atxt{1}+" !!!")
				End if 
				
			End if 
		: (Size of array:C274($BridgeFolders_atxt)=1)
			$targetspec_txt:=$targetspec_txt+"/"+$BridgeFolders_atxt{1}
			SFA_getServerFileList($targetspec_txt; ->$Folders_atxt)
			$file_L:=Find in array:C230($Folders_atxt; ($bdept_txt+"@"+$Bin_txt+"@"+$MMYY_txt+"@"))
			If ($file_L>0)
				$opentarget_txt:=$baseSpec_txt+"/"+$BridgeFolders_atxt{1}+$Folders_atxt{$file_L}
				SFA_openRatingReport($opentarget_txt)
			Else 
				ALERT:C41("No Rating report for "+$bdept_txt+"("+$Bin_txt+") dated "+String:C10([RatingReports:65]ReportDate:4)+" was found in folder "+$BridgeFolders_atxt{1}+" !!!")
			End if 
		Else 
			ALERT:C41("No corresponding folder was found for "+$bdept_txt+"("+$Bin_txt+") !")
	End case 
	
Else 
	ALERT:C41("No Records of Rating reports found for "+$bdept_txt+"("+$Bin_txt+") !")
	
End if 

//End SFA_OpenScannedReport