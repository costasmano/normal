//Method: [Bridge MHD NBIS];"Bridge Input".OpenRatingFolder
//Description
// open the scanned rating folder for the current bridge
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12
	Mods_2020_05  // Make change so that only folks in (GRP_UserInGroup ("MoveRatingReports") can create folders
	//Modified by: CJ (5/7/20 14:21:11)
	Mods_2022_04  //Change the way we identiify the Server IP address and whether we are in test or not
	//Modified by: Chuck Miller (4/5/22 12:23:05)
End if 
//
C_BOOLEAN:C305($InTest_B)
C_TEXT:C284($MethodCalledOnError_txt; $ServerIP_txt; $ServerMask_txt; $baseSpec_txt; $baseSpec_txt; $TownPrefix_txt; $Townfolder_txt; $ServerToPing_txt)
C_LONGINT:C283($Loop_L; $servdelim_L; $Width_l; $Height_L)
$ServerIP_txt:=ut_ReturnServerIP
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")
$baseSpec_txt:=ut_GetSysParameter("SCRRPT_StartLocation"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Rating-Test/B-Inspection/RATING REPORTS/Ratings Scanned to Present")
$InTest_B:=($ServerIP_txt#ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242"))

C_BOOLEAN:C305($DriveAvailable_B)
$DriveAvailable_B:=True:C214
C_LONGINT:C283($Progress_L)
C_BOOLEAN:C305($InProduction_B; $ShowOnDisk_B)
$MethodCalledOnError_txt:=Method called on error:C704
C_BOOLEAN:C305(4DError_b)
4DError_b:=False:C215


$ShowOnDisk_B:=True:C214
If (ut_ReturnServerIP=ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242"))  //In production make sure we can ping
	$servdelim_L:=Position:C15("/"; $baseSpec_txt)
	$ServerToPing_txt:=Substring:C12($baseSpec_txt; 1; ($servdelim_L-1))
	$Progress_L:=Progress New
	Progress SET TITLE($Progress_L; "Searching for ratings")
	Progress SET PROGRESS($Progress_L; 0; "Checking Server")
	
	$DriveAvailable_B:=SFA_SharedServerAvail($ServerToPing_txt)
	Progress QUIT($Progress_L)
	
End if 
C_TEXT:C284($MountVolume_txt; $MountLetter_txt)
If (ut_isSharedFolderMounted($ServerMask_txt; $baseSpec_txt; ->$MountVolume_txt))
	ON ERR CALL:C155($MethodCalledOnError_txt)
	$MountLetter_txt:=""
	C_LONGINT:C283($StartLoop_L)
	If ($DriveAvailable_B)
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
		C_TEXT:C284($Townfolder_txt; RatingRPTBDEPTFolder_txt)
		$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
		QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
		
		$Townfolder_txt:=$MountLetter_txt+$Directory_txt+Folder separator:K24:12+$TownPrefix_txt+" "+[Town Data:2]Town Name:1
		
		If ((GRP_UserInGroup("MoveRatingReports")=1) | ($InTest_B & (Current user:C182="Designer")))
			$ShowOnDisk_B:=True:C214
			//make sure town folder exists for this bridge
			If (Test path name:C476($Townfolder_txt)=Is a folder:K24:2)
			Else 
				ON ERR CALL:C155("OpenRatingFolderError")
				CREATE FOLDER:C475($Townfolder_txt)
				CREATE FOLDER:C475($Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3)
				CREATE FOLDER:C475($Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+Folder separator:K24:12+"Other")
				ON ERR CALL:C155($MethodCalledOnError_txt)
			End if 
			
			RatingRPTBDEPTFolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
			
			If (Test path name:C476(RatingRPTBDEPTFolder_txt)=Is a folder:K24:2)
			Else 
				RatingRPTBDEPTFolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3
				If (Test path name:C476(RatingRPTBDEPTFolder_txt)=Is a folder:K24:2)
					ALERT:C41("You should rename folder "+RatingRPTBDEPTFolder_txt+" by replacing - with _")
				Else 
					RatingRPTBDEPTFolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
					ON ERR CALL:C155("OpenRatingFolderError")
					CREATE FOLDER:C475(RatingRPTBDEPTFolder_txt)
					ON ERR CALL:C155($MethodCalledOnError_txt)
				End if 
			End if 
			
			//If (Test path name(RatingRPTBDEPTFolder_txt+Folder separator+"Other")=Is a folder)
			//Else 
			//CREATE FOLDER($Townfolder_txt+Folder separator+[Bridge MHD NBIS]BDEPT+"_"+[Bridge MHD NBIS]BIN+Folder separator+"Other")
			//End if 
		Else 
			
			RatingRPTBDEPTFolder_txt:=$Townfolder_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
			
			$ShowOnDisk_B:=(Test path name:C476(RatingRPTBDEPTFolder_txt)=Is a folder:K24:2)
			
		End if 
		If (4DError_b) | (Not:C34($ShowOnDisk_B))
			If (4DError_b)
				ALERT:C41("Could not create part of rating report folder structure for "+[Bridge MHD NBIS:1]BDEPT:1+" and "+[Bridge MHD NBIS:1]BIN:3+". Make sure share is mounted using proper credentials")
			Else 
				ALERT:C41("Part of the folder path for "+[Bridge MHD NBIS:1]BDEPT:1+" and "+[Bridge MHD NBIS:1]BIN:3+" does not exist")
			End if 
		Else 
			SHOW ON DISK:C922(RatingRPTBDEPTFolder_txt; *)
		End if 
	End if 
	
	
Else 
	ALERT:C41("Could not mount the share so you can not open Rating folder for "+[Bridge MHD NBIS:1]BDEPT:1+" and "+[Bridge MHD NBIS:1]BIN:3)
End if 
ON ERR CALL:C155($MethodCalledOnError_txt)

//End [Bridge MHD NBIS].Bridge Input.OpenRatingFolder