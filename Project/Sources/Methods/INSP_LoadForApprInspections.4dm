//%attributes = {"invisible":true}
//Method: INSP_LoadForApprInspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/04/21, 14:14:02
	// ----------------------------------------------------
	//Created : 
	//Mods_2021_03
	// Modified by: Costas Manousakis-(Designer)-(4/20/21 13:37:21)
	Mods_2021_04
	//  `use system parameter INSPENABLEPDFSTORE = "TRUE" to turn this feature on or off
	Mods_2022_04  //Change the way we identiify the Server IP address and whether we are in test or not
	//Modified by: Chuck Miller (4/5/22 12:23:05)
End if 
//
C_TEXT:C284($EnablePDf_txt)
$EnablePDf_txt:=ut_GetSysParameter("INSPENABLEPDFSTORE")
If ($EnablePDf_txt="TRUE")
	If (Size of array:C274(v_1_230_atxt)>0)
	Else 
		ARRAY TEXT:C222(v_1_230_atxt; 0)  // Let's use the UUID array for storing path to approved docs
		C_TEXT:C284($ServerMask_txt; $baseSpec_txt; $ServerToPing_txt; $MountVolume_txt; $FinalDirectory_txt; $TownPrefix_txt)
		$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")
		C_BOOLEAN:C305($InTest_B)
		C_LONGINT:C283($servdelim_L; $Loop_L; $StartLoop_L)
		$InTest_B:=(ut_ReturnServerIP#ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242"))
		If (False:C215)
			
			Case of 
				: (Not:C34(Is compiled mode:C492))
					$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_T"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Insp-Test/B-Inspection/ApprovedInspectionReportPDFs")
				: (Application type:C494=4D Volume desktop:K5:2) & ($InTest_B)
					$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_P"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/ApprovedInspectionReportPDFs")
				: (Application type:C494=4D Remote mode:K5:5) & ($InTest_B)
					$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_T"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Insp-Test/B-Inspection/ApprovedInspectionReportPDFs")
				Else 
					$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_P"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/ApprovedInspectionReportPDFs")
			End case 
		Else 
			$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_P"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/ApprovedInspectionReportPDFs")
		End if 
		$servdelim_L:=Position:C15("/"; $baseSpec_txt)
		$ServerToPing_txt:=Substring:C12($baseSpec_txt; 1; ($servdelim_L-1))
		OBJECT SET VISIBLE:C603(*; "ViewApprovedInspectionButton"; False:C215)
		
		
		If (SFA_SharedServerAvail($ServerToPing_txt))
			
			If (ut_isSharedFolderMounted($ServerMask_txt; $baseSpec_txt; ->$MountVolume_txt))
				C_BOOLEAN:C305($Proceed_B)
				C_TEXT:C284($Directory_txt; $MountLetter_txt)
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
						$Proceed_B:=False:C215
					End if 
				End for 
				
			End if 
			If ($Proceed_B)
				
				$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
				QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
				$FinalDirectory_txt:=$MountLetter_txt+$Directory_txt+Folder separator:K24:12+$TownPrefix_txt+" "+[Town Data:2]Town Name:1
				
				$FinalDirectory_txt:=$FinalDirectory_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
				If (Test path name:C476($FinalDirectory_txt)=Is a folder:K24:2)
					DOCUMENT LIST:C474($FinalDirectory_txt; v_1_230_atxt; Absolute path:K24:14+Recursive parsing:K24:13+Ignore invisible:K24:16)
				End if 
			End if 
			OBJECT SET VISIBLE:C603(*; "ApprovedInspectionButton"; Size of array:C274(v_1_230_atxt)>0)
		End if 
	End if 
	
End if 

//End INSP_LoadForApprInspections