//%attributes = {"invisible":true}
//Method: SFA_GetBridgeFolder
//Description
// get the base bridge/bin folder. load the data in text array passed as pointer in $3
// Parameters
// $1 : $BDEPT
// $2 : $BIN
// $3 : $FolderList_ptr  {1} = Bridge Folder ; {2} =Town Folder
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/17, 11:31:04
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	
	C_TEXT:C284(SFA_GetBridgeFolder; $1)
	C_TEXT:C284(SFA_GetBridgeFolder; $2)
	C_POINTER:C301(SFA_GetBridgeFolder; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(6/30/17 14:53:37)
	Mods_2017_06_bug
	//  `added wildcard at the end when searching for BDEPT-BIN folder name
	// Modified by: Costas Manousakis-(Designer)-(12/4/19 15:45:30)
	Mods_2019_12
	//  `use special case for standalone desktop app
	// Modified by: Costas Manousakis-(Designer)-(8/19/20 18:49:37)
	Mods_2020_08_bug
	//  `added interprocess object to save time searching.
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3)

C_TEXT:C284($BDept_txt; $BDEPTPrefix_txt)
C_TEXT:C284($BIN_txt)
C_POINTER:C301($FolderList_ptr)

$BDept_txt:=$1
$BIN_txt:=$2
$FolderList_ptr:=$3

C_TEXT:C284($vbs_out_t; $Volume_txt; $VolumeName_txt; $basePath_txt; $BaseShare_txt; $targetspec_txt; $TrimPath_txt; $openFile_txt; $ServerVol_txt; $ServerMask_txt; $TownFolder)
$basePath_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared/shareddata/")  //ending slash

ARRAY TEXT:C222($Folders_atxt; 0)

$targetspec_txt:=$basePath_txt
$targetspec_txt:=Replace string:C233($targetspec_txt; $ServerMask_txt; "")

If ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1))
	//only for standalone desktop apps
	$targetspec_txt:=SFA_VerifyMountPoint($basePath_txt)
	$targetspec_txt:=Replace string:C233($targetspec_txt; "/Volumes/"; "")  //remove the Volumes that comes from SFA_VerifyMountPoint
End if 
C_OBJECT:C1216(<>SCRRPT_SavedData_o)
C_BOOLEAN:C305($ResetArrays)
$ResetArrays:=OB Get:C1224(<>SCRRPT_SavedData_o; "refresh"; Is boolean:K8:9)
//once we get the Reset flag - clear it
OB SET:C1220(<>SCRRPT_SavedData_o; "refresh"; False:C215)
ARRAY TEXT:C222($SCRRPT_TownFolders_atxt; 0)
ARRAY TEXT:C222($SCRRPT_BDEPTBINFolders_atxt; 0)
If ($ResetArrays)
Else 
	OB GET ARRAY:C1229(<>SCRRPT_SavedData_o; "townfolders"; $SCRRPT_TownFolders_atxt)
	OB GET ARRAY:C1229(<>SCRRPT_SavedData_o; "bdeptbinfolders"; $SCRRPT_BDEPTBINFolders_atxt)
End if 
//Finding TownFolders
//get town folders
If (Size of array:C274($SCRRPT_TownFolders_atxt)>0)
	COPY ARRAY:C226($SCRRPT_TownFolders_atxt; $Folders_atxt)
Else 
	SFA_getServerFileList($targetspec_txt; ->$Folders_atxt)
	COPY ARRAY:C226($Folders_atxt; $SCRRPT_TownFolders_atxt)
	OB SET ARRAY:C1227(<>SCRRPT_SavedData_o; "townfolders"; $SCRRPT_TownFolders_atxt)
End if 

$BDEPTPrefix_txt:=Substring:C12($BDept_txt; 1; 3)

ARRAY TEXT:C222($FolderList_ptr->; 0)
$FolderList_ptr->{0}:=""
C_LONGINT:C283($loop_L)

Case of 
	: (Size of array:C274($Folders_atxt)=0)
		$FolderList_ptr->{0}:=$Folders_atxt{0}
	Else 
		//check if we have scanned the t
		$loop_L:=Find in array:C230($Folders_atxt; ($BDEPTPrefix_txt+" @"))
		
		If ($loop_L>0)
			$TownFolder:=$Folders_atxt{$loop_L}
			//now search for BDEPT_BIN
			C_BOOLEAN:C305($searchTown_b)
			$searchTown_b:=True:C214
			If (Size of array:C274($SCRRPT_BDEPTBINFolders_atxt)>0) & Not:C34($ResetArrays)
				//have we searched this town yet? - there should be Bdepts with the BDEPTprefix
				$loop_L:=Find in array:C230($SCRRPT_BDEPTBINFolders_atxt; ($BDEPTPrefix_txt+"@/"))
				
				If ($loop_L>0)
					COPY ARRAY:C226($SCRRPT_BDEPTBINFolders_atxt; $Folders_atxt)
					$searchTown_b:=False:C215
				End if 
				
			End if 
			If ($searchTown_b)
				$targetspec_txt:=$targetspec_txt+"/"+$TownFolder
				SFA_getServerFileList($targetspec_txt; ->$Folders_atxt)
				C_LONGINT:C283($folder_L)
				For ($folder_L; 1; Size of array:C274($Folders_atxt))
					APPEND TO ARRAY:C911($SCRRPT_BDEPTBINFolders_atxt; $Folders_atxt{$folder_L})
				End for 
				OB SET ARRAY:C1227(<>SCRRPT_SavedData_o; "bdeptbinfolders"; $SCRRPT_BDEPTBINFolders_atxt)  // save the new array
				
			End if 
			
			$loop_L:=Find in array:C230($Folders_atxt; ($BDept_txt+"_"+$BIN_txt+"@/"))
			
			If ($loop_L>0)
				APPEND TO ARRAY:C911($FolderList_ptr->; $TownFolder+$Folders_atxt{$loop_L})
				APPEND TO ARRAY:C911($FolderList_ptr->; $TownFolder)
			Else 
				//check if it is with a "-"
				$loop_L:=Find in array:C230($Folders_atxt; ($BDept_txt+"-"+$BIN_txt+"@/"))
				
				If ($loop_L>0)
					APPEND TO ARRAY:C911($FolderList_ptr->; $TownFolder+$Folders_atxt{$loop_L})
					APPEND TO ARRAY:C911($FolderList_ptr->; $TownFolder)
				Else 
					APPEND TO ARRAY:C911($FolderList_ptr->; $TownFolder)
					$FolderList_ptr->{0}:="BDEPT_BIN or BDEPT-BIN folder not Found <"+$BDept_txt+"_|- "+$BIN_txt+" >  !"
				End if 
			End if 
			
		Else 
			$FolderList_ptr->{0}:="Folder starting with <"+$BDEPTPrefix_txt+" >  NOT Found!"
		End if 
		
End case 

//End SFA_GetBridgeFolder