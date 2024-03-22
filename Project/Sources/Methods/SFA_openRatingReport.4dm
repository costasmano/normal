//%attributes = {"invisible":true}
//Method: SFA_openRatingReport
//Description
// test method to open a rating report or show a folder for a bridge/bin scanned by WRG saved to the shared drive
// Parameters
// $1 : $FileToOpen_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/23/17, 13:40:07
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	C_TEXT:C284(SFA_openRatingReport; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(7/12/18 11:45:02)
	Mods_2018_07
	//  `modified method of checking for mounted volumes on OSX - use regex matching.
	// Modified by: Costas Manousakis-(Designer)-(11/8/19 17:11:27)
	Mods_2019_11_bug
	//  `use method SFA_VerifyMountPoint to verify if the needed share is available.
	Mods_2020_07  //Made change to allow for correct info for $ServerMask_txt and $baseSpec_txt
	//Modified by: CJ (7/28/20 11:42:22)
End if 
//
C_TEXT:C284($1)
$targetFile_txt:=$1

If (Folder separator:K24:12=":")  //Mac OS
	C_TEXT:C284($ExtraFile_txt)
	C_TEXT:C284($basePath_txt; $targetFile_txt; $targetPath_txt)
	$basePath_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
	
	$ExtraFile_txt:=Replace string:C233($targetFile_txt; $basePath_txt; "")
	
	$targetPath_txt:=SFA_VerifyMountPoint($basePath_txt)
	
	If ($targetPath_txt#"")
		$targetPath_txt:=$targetPath_txt+$ExtraFile_txt
		OPEN URL:C673("file:///"+$targetPath_txt)
		
	Else 
		ALERT:C41("Required shared drive could not be mounted on your computer. Cannot open selected Rating report.")
	End if 
	
Else 
	$targetFile_txt:=Replace string:C233($targetFile_txt; "/"; "\\")  //change forward slash to backslash for Windows
	OPEN URL:C673("file:////"+$targetFile_txt)
End if 

//End SFA_openRatingReport