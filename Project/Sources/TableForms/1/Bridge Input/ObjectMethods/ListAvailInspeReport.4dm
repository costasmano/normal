//Method: [Bridge MHD NBIS].Bridge Input.ListAvailInspeReport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/11/20, 12:39:54
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08  //Complete work on moving signed PDF inspection reports like we do with ratings
	//Modified by: CJ (8/11/20 12:41:29)
	
End if 
//


C_TEXT:C284($popupMenu_txt; $targetPath_txt; $PathToOpen_txt; $baseSpec_txt; $ServerMask_txt; $Townfolder_txt; MoveSignedInspFolder_txt; $Townfolder_txt; $MountLetter_txt)
C_TEXT:C284($MountVolume_txt; $TownPrefix_txt)
C_LONGINT:C283($Loop_L; $StartLoop_L)
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")
$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspStartLoc"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Insp-Test/B-Inspection/SignedInspections")
If (ut_isSharedFolderMounted($ServerMask_txt; $baseSpec_txt; ->$MountVolume_txt))
	
	C_BOOLEAN:C305($Proceed_B)
	C_TEXT:C284($Directory_txt)
	ARRAY TEXT:C222($DirectoryParts_atxt; 0)
	$Proceed_B:=True:C214
	ARRAY TEXT:C222($DirectoryParts_atxt; 0)
	ut_NewTextToArray($baseSpec_txt; ->$DirectoryParts_atxt; "/")
	If (Folder separator:K24:12=":")
		$StartLoop_L:=3
		$Directory_txt:=$DirectoryParts_atxt{2}
	Else 
		$Directory_txt:=""
		$StartLoop_L:=3
		$MountLetter_txt:=Substring:C12($MountVolume_txt; 1; 2)
	End if 
	For ($Loop_L; $StartLoop_L; Size of array:C274($DirectoryParts_atxt))
		$Directory_txt:=$Directory_txt+Folder separator:K24:12+$DirectoryParts_atxt{$Loop_L}
		If (Test path name:C476($Directory_txt)=Is a folder:K24:2)
		Else 
			ALERT:C41("There are no Inspection PDFs for this bridge")
			$Proceed_B:=False:C215
		End if 
	End for 
End if 
$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
$Townfolder_txt:=$MountLetter_txt+$Directory_txt+Folder separator:K24:12+$TownPrefix_txt+" "+[Town Data:2]Town Name:1

//make sure town folder exists for this bridge
If ($Proceed_B)
	If (Test path name:C476($Townfolder_txt)=Is a folder:K24:2)
		
	Else 
		ALERT:C41("There are no Inspection PDFs for this bridge")
		$Proceed_B:=False:C215
	End if 
End if 
If ($Proceed_B)
	$Townfolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
	If (Test path name:C476($Townfolder_txt)=Is a folder:K24:2)
	Else 
		ALERT:C41("There are no Inspection PDFs for this bridge")
		$Proceed_B:=False:C215
	End if 
End if 

If ($Proceed_B)
	ARRAY TEXT:C222($Documents_atxt; 0)
	DOCUMENT LIST:C474($Townfolder_txt; $Documents_atxt; Ignore invisible:K24:16)
	C_LONGINT:C283($Loop_L)
	ARRAY TEXT:C222($MenuSelected_atxt; 0)
	ARRAY TEXT:C222($MenuSelected_atxt; Size of array:C274($Documents_atxt))
	
	For ($loop_l; 1; Size of array:C274($Documents_atxt))
		$MenuSelected_atxt{$Loop_L}:=String:C10($Loop_L)
	End for 
	C_LONGINT:C283($MouseX_L; $mouseY_L; $MouseBtn_L)
	GET MOUSE:C468($MouseX_L; $mouseY_L; $MouseBtn_L)
	$popupMenu_txt:=MENU_BuildMenuFromArrays(->$Documents_atxt; ->$MenuSelected_atxt; "\\")
	C_TEXT:C284($filepicked_txt)
	$filepicked_txt:=Dynamic pop up menu:C1006($popupMenu_txt; ""; $MouseX_L; $mouseY_L)
	RELEASE MENU:C978($popupMenu_txt)
	C_TEXT:C284($SelectedDocument_txt)
	
	If (Num:C11($filepicked_txt)#0)
		$SelectedDocument_txt:=Convert path system to POSIX:C1106($Townfolder_txt+Folder separator:K24:12+$Documents_atxt{Num:C11($filepicked_txt)})
		OPEN URL:C673("file:////"+$SelectedDocument_txt)
	End if 
End if 


//End [Bridge MHD NBIS].Bridge Input.ListAvailInspeReport