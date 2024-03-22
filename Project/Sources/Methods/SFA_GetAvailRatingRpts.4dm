//%attributes = {"invisible":true}
// Method: SFA_GetAvailRatingRpts
// Description
// Get list of available ratings for a bridge and display a popup menu to pick one.
// Parameters
// $1 : $Bdept_txt
// $2 : $BIN_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/30/17, 10:01:27
	// ----------------------------------------------------
	// First Release
	Mods_2017_05
	
	C_TEXT:C284(SFA_GetAvailRatingRpts; $1)
	C_TEXT:C284(SFA_GetAvailRatingRpts; $2)
	// Modified by: Costas Manousakis-(Designer)-(11/13/17 16:42:01)
	Mods_2017_11
	//  `added a progress bar; use MENU_BuildMenuFromArrays to use a dynamic pop up menu
	// Modified by: Costas Manousakis-(Designer)-(1/3/18 17:15:16)
	Mods_2018_01
	//  `when searching in the "Other" folder use recursive search
	//  //also in "Other" folder replace "(" with  "[" to avoid problems in building the menu
	// Modified by: Costas Manousakis-(Designer)-(11/12/19 17:23:49)
	Mods_2019_11_bug
	//  `for standalone app try to mount volume using SFA_VerifyMountPoint before searching.
	// Modified by: Costas Manousakis-(Designer)-(12/4/19 15:44:36)
	Mods_2019_12
	//  `adjust the calculation of targetPath
	// Modified by: Costas Manousakis-(Designer)-(8/20/20 12:51:25)
	Mods_2020_08_bug
	//  `use the <>SCRRPT_SavedData_o for mouse coords
	// Modified by: Costas Manousakis-(Designer)-(3/16/21 15:31:05)
	Mods_2021_03
	//  `modified to do the search from the local machine, not from the server.
	// Modified by: Costas Manousakis-(Designer)-(2021-12-07T00:00:00 14:24:42)
	Mods_2021_12_bug
	//  `changed Open URL to use "file://" instead of "file:////" - fix problem opening on windows.
	// Modified by: Costas Manousakis-(Designer)-(2022-11-25 10:50:08)
	Mods_2022_11
	//  `changes to work with new results from ut_isSharedFolderMounted on mac and use Posix file path from document list
	// Modified by: manousakisc (3/8/2023)
	Mods_2023_03
	//  `clean up code of if(False)
	//  `set progress to -1 
	//  `added delay process (10) after progress quit , so that progress bar has time to close
	
	
End if 

C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($bdept_txt; $Bin_txt)
$bdept_txt:=$1
$Bin_txt:=$2

C_TEXT:C284($ServerMask_txt; $targetspec_txt; $opentarget_txt; $baseSpec_txt; $PrevRtgFolder_txt; $ServerToPing_txt; $MountVolume_txt)
C_TEXT:C284($FinalDirectory_txt; $TownPrefix_txt; $FinalDirectory_txt)
C_LONGINT:C283($MouseX_L; $mouseY_L; $MouseBtn_L)
C_OBJECT:C1216(<>SCRRPT_SavedData_o)
$MouseX_L:=OB Get:C1224(<>SCRRPT_SavedData_o; "mouseX"; Is longint:K8:6)
$mouseY_L:=OB Get:C1224(<>SCRRPT_SavedData_o; "mouseY"; Is longint:K8:6)
If ($MouseX_L>0)
	//get them only once - now clear the values
	OB SET:C1220(<>SCRRPT_SavedData_o; "mouseX"; 0)
	OB SET:C1220(<>SCRRPT_SavedData_o; "mouseY"; 0)
Else 
	GET MOUSE:C468($MouseX_L; $mouseY_L; $MouseBtn_L)
End if 

//$ServerMask_txt:=  `ending slash
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared/shareddata/")

ARRAY TEXT:C222($Folders_atxt; 0)
ARRAY TEXT:C222($ratingFiles_atxt; 0)
$baseSpec_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
C_LONGINT:C283($servdelim_L; $StartLoop_L; $progress_L)
$servdelim_L:=Position:C15("/"; $baseSpec_txt)

Case of 
	: ($servdelim_L>1)
		$ServerToPing_txt:=Substring:C12($baseSpec_txt; 1; ($servdelim_L-1))
		$progress_L:=Progress New
		Progress SET TITLE($progress_L; "Searching for ratings")
		Progress SET PROGRESS($progress_L; -1; "Checking Server")
		
		If (SFA_SharedServerAvail($ServerToPing_txt))
			Progress SET PROGRESS($progress_L; -1; "Checking mount point")
			C_BOOLEAN:C305($Proceed_B)
			$Proceed_B:=False:C215
			If (ut_isSharedFolderMounted($ServerMask_txt; $baseSpec_txt; ->$MountVolume_txt; "x"))
				C_TEXT:C284($Directory_txt; $MountLetter_txt)
				$Proceed_B:=True:C214
				ARRAY TEXT:C222($DirectoryParts_atxt; 0)
				ut_NewTextToArray($baseSpec_txt; ->$DirectoryParts_atxt; "/")
				If (Folder separator:K24:12=":")
					$StartLoop_L:=3
					
					$Directory_txt:=$DirectoryParts_atxt{2}
					$Directory_txt:="/Volumes/"+$MountVolume_txt
				Else 
					$Directory_txt:=""
					$StartLoop_L:=3
					$MountLetter_txt:=Substring:C12($MountVolume_txt; 1; 2)
				End if 
				For ($Loop_L; $StartLoop_L; Size of array:C274($DirectoryParts_atxt))
					$Directory_txt:=$Directory_txt+Folder separator:K24:12+$DirectoryParts_atxt{$Loop_L}
					If (Test path name:C476($MountLetter_txt+$Directory_txt)=Is a folder:K24:2)
					Else 
						$Proceed_B:=False:C215
					End if 
				End for 
			Else 
				Progress QUIT($progress_L)
				DELAY PROCESS:C323(Current process:C322; 10)
				ALERT:C41("Could not connect to required folder\r"+$baseSpec_txt+"\rOn\r"+$ServerMask_txt)
			End if 
			If ($Proceed_B)
				
				$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
				QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
				$FinalDirectory_txt:=$MountLetter_txt+$Directory_txt+Folder separator:K24:12+$TownPrefix_txt+" "+[Town Data:2]Town Name:1
				
				$FinalDirectory_txt:=$FinalDirectory_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
				
				If (Test path name:C476($FinalDirectory_txt)=Is a folder:K24:2)
					Progress SET PROGRESS($progress_L; -1; "Getting file list for "+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3)
					
					DOCUMENT LIST:C474($FinalDirectory_txt; $ratingFiles_atxt; Absolute path:K24:14+Posix path:K24:15+Recursive parsing:K24:13+Ignore invisible:K24:16)
					
					If (Size of array:C274($ratingFiles_atxt)>0)
						
						ARRAY TEXT:C222($ratings_atxt; Size of array:C274($ratingFiles_atxt))
						C_LONGINT:C283($loop_L)
						For ($loop_L; 1; Size of array:C274($ratingFiles_atxt))
							$ratings_atxt{$Loop_L}:=Replace string:C233($ratingFiles_atxt{$Loop_L}; Replace string:C233($FinalDirectory_txt; Folder separator:K24:12; "/"); "")
							If (Substring:C12($ratings_atxt{$Loop_L}; 1; 1)="/")
								$ratings_atxt{$Loop_L}:=Substring:C12($ratings_atxt{$Loop_L}; 2)
							End if 
						End for 
						
						Progress QUIT($progress_L)
						DELAY PROCESS:C323(Current process:C322; 10)
						C_TEXT:C284($popupMenu_txt)
						$popupMenu_txt:=MENU_BuildMenuFromArrays(->$ratings_atxt; ->$ratingFiles_atxt; "/")
						C_TEXT:C284($filepicked_txt)
						$filepicked_txt:=Dynamic pop up menu:C1006($popupMenu_txt; ""; $MouseX_L; $mouseY_L)
						RELEASE MENU:C978($popupMenu_txt)
						
						If (Length:C16($filepicked_txt)>1)
							//SFA_openRatingReport ($filepicked_txt)
							//$filepicked_txt:=Convert path system to POSIX($filepicked_txt)
							OPEN URL:C673("file://"+$filepicked_txt)
						End if 
						
					Else 
						Progress QUIT($progress_L)
						DELAY PROCESS:C323(Current process:C322; 10)
						ALERT:C41("There were no scanned ratings found for "+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3)
					End if 
				Else 
					Progress QUIT($progress_L)
					DELAY PROCESS:C323(Current process:C322; 10)
					ALERT:C41("Scanned ratings folder for "+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+" was not found!")
				End if 
				
			Else 
				
				Progress QUIT($progress_L)
				DELAY PROCESS:C323(Current process:C322; 10)
				ALERT:C41("Could not find Base ratings folder from parameter SCRRPT_BaseSpec!")
			End if 
			
		Else 
			
			Progress QUIT($progress_L)
			ALERT:C41("You are not in the MassDOT network to access scanned Rating reports!")
			
		End if 
	Else 
		ALERT:C41("Badly formed Shared Folder specification <"+$baseSpec_txt+"> !!!")
		
End case 