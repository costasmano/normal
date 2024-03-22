//%attributes = {"invisible":true}
//Method: OM_ControlOpenandMoveRatingPDF
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 13:44:47
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/14/17 16:39:12)
	Mods_2020_05  // Make change as we assume $baseSpec_txt folders are always there
	Mods_2020_05  //Modified Ratings display so mount and movement can be from windows as well as macs
	//Modified by: Chuck Miller (05/11/20 16:22:20)
	Mods_2020_07  //Made change to allow for correct info for $ServerMask_txt and $baseSpec_txt
	//Modified by: CJ (7/28/20 11:42:22)
	Mods_2020_08  //Complete work on moving signed PDF inspection reports like we do with ratings
	//Modified by: CJ (8/11/20 12:41:29)
	// Modified by: Costas Manousakis-(Designer)-(8/28/20 12:28:23)
	Mods_2020_08_bug
	//  `use half width of form to open window
	Mods_2022_04  //Change the way we identiify the Server IP address and whether we are in test or not
	//Modified by: Chuck Miller (4/5/22 12:23:05)
End if 
//
MovePage_L:=1
C_BOOLEAN:C305($InTest_B)
C_TEXT:C284($MountLetter_txt; $ServerMask_txt; $baseSpec_txt; $baseSpec_txt; $TownPrefix_txt; $Townfolder_txt; $ServerToPing_txt)
C_LONGINT:C283($StartLoop_L; $Loop_L; $servdelim_L; $Width_l; $Height_L)
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")
$baseSpec_txt:=ut_GetSysParameter("SCRRPT_StartLocation"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Rating-Test/B-Inspection/RATING REPORTS/Ratings Scanned to Present")


C_BOOLEAN:C305($DriveAvailable_B)
$DriveAvailable_B:=True:C214
C_LONGINT:C283($Progress_L)
C_BOOLEAN:C305($InProduction_B)

If (ut_ReturnServerIP=ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242"))  //In production make sure we can ping
	$servdelim_L:=Position:C15("/"; $baseSpec_txt)
	$ServerToPing_txt:=Substring:C12($baseSpec_txt; 1; ($servdelim_L-1))
	$Progress_L:=Progress New
	Progress SET TITLE($Progress_L; "Searching for ratings")
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
				//If (Test path name($Directory_txt)=Is a folder)
				//Else 
				//CREATE FOLDER($Directory_txt)
				//End if 
			End for 
		End if 
		C_TEXT:C284($Townfolder_txt; RatingRPTBDEPTFolder_txt)
		$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
		QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
		$Townfolder_txt:=$MountLetter_txt+$Directory_txt+Folder separator:K24:12+$TownPrefix_txt+" "+[Town Data:2]Town Name:1
		
		//make sure town folder exists for this bridge
		If (Test path name:C476($Townfolder_txt)=Is a folder:K24:2)
		Else 
			CREATE FOLDER:C475($Townfolder_txt)
			CREATE FOLDER:C475($Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3)
			CREATE FOLDER:C475($Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+Folder separator:K24:12+"Other")
			
		End if 
		
		RatingRPTBDEPTFolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
		
		If (Test path name:C476(RatingRPTBDEPTFolder_txt)=Is a folder:K24:2)
		Else 
			RatingRPTBDEPTFolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3
			If (Test path name:C476(RatingRPTBDEPTFolder_txt)=Is a folder:K24:2)
				ALERT:C41("You should rename folder "+RatingRPTBDEPTFolder_txt+" by replacing - with _")
			Else 
				RatingRPTBDEPTFolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
				CREATE FOLDER:C475(RatingRPTBDEPTFolder_txt)
			End if 
		End if 
		
		If (Test path name:C476(RatingRPTBDEPTFolder_txt+Folder separator:K24:12+"Other")=Is a folder:K24:2)
		Else 
			CREATE FOLDER:C475($Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+Folder separator:K24:12+"Other")
		End if 
		
		ARRAY TEXT:C222($Documents_atxt; 0)
		
		RatingRPTBDEPTFolder_txt:=RatingRPTBDEPTFolder_txt+Folder separator:K24:12
		FORM GET PROPERTIES:C674("RatingReportDisplayandMove"; $Width_l; $Height_L)
		
		ut_OpenNewWindow(($Width_l/2); $Height_L; 0; Plain form window:K39:10; "Move/Copy Rating Report"; "ut_CloseCancel")
		DIALOG:C40("RatingReportDisplayandMove")
		PDFViewer_CleanAll  // clean up temp files after dialog closes - on windows the temp files are locked by Acrobat while dialog is open
	End if 
End if 
//End OM_ControlOpenandMoveRatingPDF