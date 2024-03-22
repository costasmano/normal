//%attributes = {"invisible":true}
//Method: SFA_GetFolderListServer
//Description
//test method to test if folders under base path are named correctly
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/30/17, 13:54:34
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	Mods_2020_07  //Made change to allow for correct info for $ServerMask_txt and $baseSpec_txt
	//Modified by: CJ (7/28/20 11:42:22)
	// Modified by: Costas Manousakis-(Designer)-(8/12/20 18:39:33)
	Mods_2020_08
	//  `choose whether to use the "production" base path, or the base path in parameters - added better reporting
End if 
//
C_TEXT:C284($vbs_out_t; $Volume_txt; $VolumeName_txt; $basePath_txt; $BaseShare_txt; $targetspec_txt; $TrimPath_txt; $openFile_txt; $ServerVol_txt; $ServerMask_txt)
$basePath_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")  //ending slash

ARRAY TEXT:C222($Folders_atxt; 0)
CONFIRM:C162("Use the production path or the one from parameters table?"; "Production"; "Parameters")
If (ok=1)
	//use this to check
	$targetspec_txt:="mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present"
Else 
	$targetspec_txt:=$basePath_txt  //use the one from parameters 
End if 

$targetspec_txt:=Replace string:C233($targetspec_txt; $ServerMask_txt; "")

SFA_getServerFileList($targetspec_txt; ->$Folders_atxt)

If (Size of array:C274($Folders_atxt)>0)
	SHORT_MESSAGE("Checking "+String:C10(Size of array:C274($Folders_atxt))+" folders.")
	C_LONGINT:C283($loop_L)
	C_TEXT:C284($BdeptPrefix_txt; $Errors_txt)
	$Errors_txt:=""
	For ($loop_L; 1; Size of array:C274($Folders_atxt))
		$BdeptPrefix_txt:=Substring:C12($Folders_atxt{$loop_L}; 1; 3)
		
		Case of 
			: ($BdeptPrefix_txt=".@")  //hidden file
			: ($BdeptPrefix_txt=" @")  //starts with space
			Else 
				//check it
				QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$BdeptPrefix_txt)
				If (Records in selection:C76([Town Data:2])=1)
					//check the town name if it matches
					If (Replace string:C233(Substring:C12($Folders_atxt{$loop_L}; 5); "/"; "")=[Town Data:2]Town Name:1)
					Else 
						$Errors_txt:=$Errors_txt+"Town name in folder "+$Folders_atxt{$loop_L}+" does not match 4D data "+[Town Data:2]Town Name:1+"\n"
					End if 
				Else 
					$Errors_txt:=$Errors_txt+"Bad folder name "+$Folders_atxt{$loop_L}+"\n"
				End if 
		End case 
		
	End for 
	CLOSE WINDOW:C154
	If ($Errors_txt#"")
		$Errors_txt:="Checked "+String:C10(Size of array:C274($Folders_atxt))+" folders ! Found the following errors \n"+$Errors_txt
		ut_BigAlert($Errors_txt; "Errors in folder names")
	Else 
		ALERT:C41("No folder naming errors found in ["+$targetspec_txt+"] - Checked "+String:C10(Size of array:C274($Folders_atxt))+" folders !")
	End if 
Else 
	ALERT:C41("No folders found in ["+$targetspec_txt+"] !")
End if 
//End SFA_GetFolderListServer