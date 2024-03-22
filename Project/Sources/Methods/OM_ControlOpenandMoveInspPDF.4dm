//%attributes = {"invisible":true}
//Method: OM_ControlOpenandMoveInspPDF
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/23/20, 
	// ----------------------------------------------------
	//Created : 
	//Notes based upon OM_ControlOpenandMoveRatingPDF
	Mods_2020_08  //Complete work on moving signed PDF inspection reports like we do with ratings
	//Modified by: CJ (8/11/20 12:41:29)
	Mods_2022_04  //Change the way we identiify the Server IP address and whether we are in test or not
	//Modified by: Chuck Miller (4/5/22 12:23:05)
End if 
//
MovePage_L:=2
C_BOOLEAN:C305($InTest_B)
C_TEXT:C284($MountLetter_txt; $ServerMask_txt; $baseSpec_txt; $baseSpec_txt; $TownPrefix_txt; $Townfolder_txt; $ServerToPing_txt)
C_LONGINT:C283($StartLoop_L; $Loop_L; $servdelim_L; $Width_l; $Height_L)
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")
$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspStartLoc"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Insp-Test/B-Inspection/SignedInspections")


C_BOOLEAN:C305($DriveAvailable_B)
$DriveAvailable_B:=True:C214
C_LONGINT:C283($Progress_L)
C_BOOLEAN:C305($InProduction_B)

If (ut_ReturnServerIP=ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242"))  //In production make sure we can ping
	$servdelim_L:=Position:C15("/"; $baseSpec_txt)
	$ServerToPing_txt:=Substring:C12($baseSpec_txt; 1; ($servdelim_L-1))
	$Progress_L:=Progress New
	Progress SET TITLE($Progress_L; "Searching for Inspection Reports")
	Progress SET PROGRESS($Progress_L; 0; "Checking Server")
	
	$DriveAvailable_B:=SFA_SharedServerAvail($ServerToPing_txt)
	Progress QUIT($Progress_L)
	
End if 
C_TEXT:C284($MountVolume_txt)
If (ut_isSharedFolderMounted($ServerMask_txt; $baseSpec_txt; ->$MountVolume_txt))
	
	If ($DriveAvailable_B)
		C_TEXT:C284($Directory_txt)
		If (False:C215)
			ARRAY TEXT:C222($DirectoryParts_atxt; 0)
			ut_NewTextToArray($baseSpec_txt; ->$DirectoryParts_atxt; "/")
			$Directory_txt:=$DirectoryParts_atxt{2}
			For ($Loop_L; 3; Size of array:C274($DirectoryParts_atxt))
				$Directory_txt:=$Directory_txt+Folder separator:K24:12+$DirectoryParts_atxt{$Loop_L}
				//If (Test path name($Directory_txt)=Is a folder)
				//Else 
				//CREATE FOLDER($Directory_txt)
				//End if 
			End for 
		Else 
			C_TEXT:C284($Directory_txt)
			
			
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
					CREATE FOLDER:C475($Directory_txt)
				End if 
			End for 
		End if 
		C_TEXT:C284($Townfolder_txt; MoveSignedInspFolder_txt)
		$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
		QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
		$Townfolder_txt:=$MountLetter_txt+$Directory_txt+Folder separator:K24:12+$TownPrefix_txt+" "+[Town Data:2]Town Name:1
		
		//make sure town folder exists for this bridge
		If (Test path name:C476($Townfolder_txt)=Is a folder:K24:2)
			
		Else 
			CREATE FOLDER:C475($Townfolder_txt)
			CREATE FOLDER:C475($Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3)
			
		End if 
		$Townfolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
		If (Test path name:C476($Townfolder_txt)=Is a folder:K24:2)
		Else 
			CREATE FOLDER:C475($Townfolder_txt)
			
		End if 
		
		
		ARRAY TEXT:C222($Documents_atxt; 0)
		
		MoveSignedInspFolder_txt:=$Townfolder_txt+Folder separator:K24:12
		FORM GET PROPERTIES:C674("RatingReportDisplayandMove"; $Width_l; $Height_L)
		
		ut_OpenNewWindow(670; $Height_L; 0; Plain form window:K39:10; "Move/Copy Signed Inspection Report"; "ut_CloseCancel")
		DIALOG:C40("RatingReportDisplayandMove")
		//PDFViewer_CleanAll  // clean up temp files after dialog closes - on windows the temp files are locked by Acrobat while dialog is open
	End if 
End if 
//End OM_ControlOpenandMoveInspPDF