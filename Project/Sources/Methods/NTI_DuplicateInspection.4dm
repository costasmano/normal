//%attributes = {"invisible":true}
//Method: NTI_DuplicateInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/27/16, 09:22:55
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	Mods_2018_04  //Make sure complete and approved stuff blanked out during duplicate
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 14:41:42)
End if 
//
//team leader members are links
//[NTI_ELEM_TIN_INSP]  //do it the same way as
//DUPLICATE RECORD([PON_ELEM_INSP]
//Look at Duplicate_Inspection
//tables to duplicate
//[TIN_Inspections]//done

ON ERR CALL:C155("SQL_ERROR")

//[TIN_Insp_Comments]//done
//[TIN_Insp_TmMembers]//done
//[TIN_Insp_Images]//done
//[NTI_ELEM_TIN_INSP]
C_LONGINT:C283($TotalRecordCount_L; $NumberProcessed_L; $Progress_L)
C_LONGINT:C283($Count_L)
C_BOOLEAN:C305(DupInsp_CopySketches_B; DupInsp_CopyPhotos_B; DupInsp_CopyCharts_B)
DupInsp_CopySpecMem_B:=False:C215
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([TIN_Insp_Images:186]; [TIN_Insp_Images:186]InspectionID:1=[TIN_Inspections:184]InspectionID:2; *)
QUERY:C277([TIN_Insp_Images:186];  & ; [TIN_Insp_Images:186]ImageType:5=BMS Photo)
$TotalRecordCount_L:=$TotalRecordCount_L+$Count_L
DupInsp_CopyPhotos_B:=($Count_L>0)
QUERY:C277([TIN_Insp_Images:186]; [TIN_Insp_Images:186]InspectionID:1=[TIN_Inspections:184]InspectionID:2; *)
QUERY:C277([TIN_Insp_Images:186];  & ; [TIN_Insp_Images:186]ImageType:5=BMS Chart)
$TotalRecordCount_L:=$TotalRecordCount_L+$Count_L
DupInsp_CopyCharts_B:=($Count_L>0)
QUERY:C277([TIN_Insp_Images:186]; [TIN_Insp_Images:186]InspectionID:1=[TIN_Inspections:184]InspectionID:2; *)
QUERY:C277([TIN_Insp_Images:186];  & ; [TIN_Insp_Images:186]ImageType:5=BMS Sketch)
$TotalRecordCount_L:=$TotalRecordCount_L+$Count_L
DupInsp_CopySketches_B:=($Count_L>0)
QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
$TotalRecordCount_L:=$TotalRecordCount_L+$Count_L
QUERY:C277([TIN_Insp_TmMembers:187]; [TIN_Insp_TmMembers:187]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
$TotalRecordCount_L:=$TotalRecordCount_L+$Count_L
QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
$TotalRecordCount_L:=$TotalRecordCount_L+$Count_L
$TotalRecordCount_L:=$TotalRecordCount_L+1
SET QUERY DESTINATION:C396(Into current selection:K19:1)

vTextMsg:="Do you wish to copy this "+[TIN_Inspections:184]InspType:21+" Inpsection dated: "+String:C10([TIN_Inspections:184]InspDate:3)
C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
$Title_txt:="Duplicate TIN_Inspections"
FORM GET PROPERTIES:C674([Dialogs:21]; "DuplicateInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
DIALOG:C40([Dialogs:21]; "DuplicateInsp")

CLOSE WINDOW:C154
If (OK=1)
	$NumberProcessed_L:=1
	C_OBJECT:C1216($progressObj_o)
	$progressObj_o:=ProgressNew("Duplicating TIN Inspection"; $TotalRecordCount_L; True:C214; ""; 3)
	//Duplicate [TIN_Inspections]
	ARRAY POINTER:C280(Ptr_changes; 0; 0)
	InitChangeStack(1)
	
	START TRANSACTION:C239
	C_LONGINT:C283($CurrentInspectionID_L; $NewInspectionID_L)
	$CurrentInspectionID_L:=[TIN_Inspections:184]InspectionID:2
	UpdateProgressNew($progressObj_o; $NumberProcessed_L)
	DUPLICATE RECORD:C225([TIN_Inspections:184])
	
	Inc_Sequence("TIN_Inspections"; ->[TIN_Inspections:184]InspectionID:2)
	$NewInspectionID_L:=[TIN_Inspections:184]InspectionID:2
	If (DupInsp_CopyAsIS_L=1)
		vsForward:=Synch_ReturnForward([NTI_TunnelInfo:181]NTI_i6_s:11; [NTI_TunnelInfo:181]NTI_InspResp:73; ""; [TIN_Inspections:184]TeamLeader:11)
		
	Else 
		[TIN_Inspections:184]InspApproval:6:=0
		[TIN_Inspections:184]Complete:4:=False:C215
		[TIN_Inspections:184]InspApproveComments:16:=""
		[TIN_Inspections:184]InspApproveDate:18:=!00-00-00!
		[TIN_Inspections:184]InspCompleteDate:15:=!00-00-00!
		[TIN_Inspections:184]InspReportComplete_d:51:=!00-00-00!
		[TIN_Inspections:184]InspReview:5:=0
		[TIN_Inspections:184]InspReviewComments:17:=""
		[TIN_Inspections:184]InspReviewDate:19:=!00-00-00!
		[TIN_Inspections:184]InspDate:3:=Current date:C33
		[TIN_Inspections:184]CreatedBy:8:=Current user:C182
		[TIN_Inspections:184]CreatedDateTimeStamp:7:=ISODateTime(Current date:C33(*); Current time:C178(*))
		[TIN_Inspections:184]TeamLeader:11:=0
		[TIN_Inspections:184]ProjManager:14:=0
		[TIN_Inspections:184]ModifiedBy:10:=""
		[TIN_Inspections:184]ModifiedTimeStamp:9:=""
		[TIN_Inspections:184]Weather:49:=""
		[TIN_Inspections:184]Temperature:50:=0
		
		If (<>CurrentUser_PID>0)
			
			READ ONLY:C145([Personnel:42])
			QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=<>CurrentUser_PID)
			If ([Personnel:42]Job Code:8=2)
				[TIN_Inspections:184]TeamLeader:11:=<>CurrentUser_PID
			End if 
			
		End if 
		C_TEXT:C284($tunnelGrpsuffix_txt)
		vsForward:=Synch_ReturnForward([NTI_TunnelInfo:181]NTI_i6_s:11; [NTI_TunnelInfo:181]NTI_InspResp:73; ""; [TIN_Inspections:184]TeamLeader:11)
		
		C_LONGINT:C283($DTIE_L)
		$tunnelGrpsuffix_txt:=NTI_GroupSuffix
		$DTIE_L:=GRP_GetGroupRepID("TunnelInspEng"+$tunnelGrpsuffix_txt)
		
		If ($DTIE_L>0)
			[TIN_Inspections:184]DistrTnlInspEng:22:=$DTIE_L
		End if 
		
		$DTIE_L:=GRP_GetGroupRepID("TunnelEngineer"+$tunnelGrpsuffix_txt)
		If ($DTIE_L>0)
			[TIN_Inspections:184]DistrInspEng:12:=$DTIE_L
		End if 
		[TIN_Inspections:184]Agency:13:=<>PERS_MyCompany_txt
	End if 
	LogNewRecordChanges(->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; "TIN_Inspections"; 1)
	If ([TIN_Inspections:184]TeamLeader:11#0)
		LogLink(->[TIN_Inspections:184]TeamLeader:11; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	End if 
	If ([TIN_Inspections:184]DistrInspEng:12#0)
		LogLink(->[TIN_Inspections:184]DistrInspEng:12; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	End if 
	If ([TIN_Inspections:184]DistrTnlInspEng:22#0)
		LogLink(->[TIN_Inspections:184]DistrTnlInspEng:22; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	End if 
	If ([TIN_Inspections:184]ProjManager:14#0)
		LogLink(->[TIN_Inspections:184]ProjManager:14; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
	End if 
	SAVE RECORD:C53([TIN_Inspections:184])
	
	//Duplicate [TIN_Insp_Comments]
	ARRAY POINTER:C280(Ptr_changes; 0; 0)
	InitChangeStack(1)
	QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]InspectionID:1=$CurrentInspectionID_L)
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([TIN_Insp_Comments:188]; $RecordNumbers_aL)
	
	
	//NOW DO [TIN_Insp_Comments]
	For ($Count_L; 1; Size of array:C274($RecordNumbers_aL))
		$NumberProcessed_L:=$NumberProcessed_L+1
		UpdateProgressNew($progressObj_o; $NumberProcessed_L)
		
		GOTO RECORD:C242([TIN_Insp_Comments:188]; $RecordNumbers_aL{$Count_L})
		ARRAY POINTER:C280(Ptr_changes; 0; 0)
		InitChangeStack(1)
		
		DUPLICATE RECORD:C225([TIN_Insp_Comments:188])
		Inc_Sequence("TIN_Insp_Comments"; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3)
		
		If (DupInsp_CopyAsIS_L=1)
			
		Else 
			[TIN_Insp_Comments:188]ModifiedBy_s:7:=Current user:C182
			[TIN_Insp_Comments:188]ISOModifiedDate_s:6:=ISODateTime(Current date:C33; Current time:C178)
			[TIN_Insp_Comments:188]CreatedBy_s:5:=Current user:C182
			[TIN_Insp_Comments:188]ISOCreatedDate_s:4:=ISODateTime(Current date:C33; Current time:C178)
		End if 
		
		[TIN_Insp_Comments:188]InspectionID:1:=$NewInspectionID_L
		
		
		LogNewRecordChanges(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_Comments:188]InspectionID:1; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3; 2; "TIN_Insp_Comments"; 1; ->[TIN_Insp_Comments:188]TIN_InspCommentID_L:3; ->[TIN_Insp_Comments:188]InspectionID:1; ->[TIN_Insp_Comments:188]TIN_INSP_CommentsUUIDKey_S:2)
		
		
		SAVE RECORD:C53([TIN_Insp_Comments:188])
		UNLOAD RECORD:C212([TIN_Insp_Comments:188])
		
		
	End for 
	//Now do [TIN_Insp_TmMembers]
	If (DupInsp_CopyAsIS_L=1)
		
		ARRAY POINTER:C280(Ptr_changes; 0; 0)
		InitChangeStack(1)
		QUERY:C277([TIN_Insp_TmMembers:187]; [TIN_Insp_TmMembers:187]InspectionID:1=$CurrentInspectionID_L)
		ARRAY LONGINT:C221($RecordNumbers_aL; 0)
		LONGINT ARRAY FROM SELECTION:C647([TIN_Insp_TmMembers:187]; $RecordNumbers_aL)
		For ($Count_L; 1; Size of array:C274($RecordNumbers_aL))
			$NumberProcessed_L:=$NumberProcessed_L+1
			UpdateProgressNew($progressObj_o; $NumberProcessed_L)
			
			GOTO RECORD:C242([TIN_Insp_TmMembers:187]; $RecordNumbers_aL{$Count_L})
			DUPLICATE RECORD:C225([TIN_Insp_TmMembers:187])
			[TIN_Insp_TmMembers:187]InspectionID:1:=$NewInspectionID_L
			LogNewRecord(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_TmMembers:187]InspectionID:1; ->[TIN_Insp_TmMembers:187]PersonID:2; 3; ""; ->[Personnel:42]Person ID:1)
			SAVE RECORD:C53([TIN_Insp_TmMembers:187])
			UNLOAD RECORD:C212([TIN_Insp_TmMembers:187])
		End for 
	End if 
	//Dupliacte [TIN_Insp_Images]
	QUERY:C277([TIN_Insp_Images:186]; [TIN_Insp_Images:186]InspectionID:1=$CurrentInspectionID_L)
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	LONGINT ARRAY FROM SELECTION:C647([TIN_Insp_Images:186]; $RecordNumbers_aL)
	For ($Count_L; 1; Size of array:C274($RecordNumbers_aL))
		$NumberProcessed_L:=$NumberProcessed_L+1
		UpdateProgressNew($progressObj_o; $NumberProcessed_L)
		
		ARRAY POINTER:C280(Ptr_changes; 0; 0)
		InitChangeStack(1)
		
		GOTO RECORD:C242([TIN_Insp_Images:186]; $RecordNumbers_aL{$Count_L})
		Case of 
			: (([TIN_Insp_Images:186]ImageType:5=BMS Photo) & (DupInsp_CopyPhotos_L=0))
			: (([TIN_Insp_Images:186]ImageType:5=BMS Sketch) & (DupInsp_CopySketches_L=0))
			: (([TIN_Insp_Images:186]ImageType:5=BMS Chart) & (DupInsp_CopyCharts_L=0))
			Else 
				
				DUPLICATE RECORD:C225([TIN_Insp_Images:186])
				[TIN_Insp_Images:186]ImageID:2:=0
				Inc_Sequence("TIN_Insp_Images"; ->[TIN_Insp_Images:186]ImageID:2)
				[TIN_Insp_Images:186]InspectionID:1:=$NewInspectionID_L
				
				LogNewRecordChanges(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_Images:186]InspectionID:1; ->[TIN_Insp_Images:186]ImageID:2; 2; "TIN_Insp_Images"; 1; ->[TIN_Insp_Images:186]InspectionID:1; ->[TIN_Insp_Images:186]ImageID:2)
				
				
				SAVE RECORD:C53([TIN_Insp_Images:186])
				UNLOAD RECORD:C212([TIN_Insp_Images:186])
		End case 
	End for 
	
	
	//Duplicate [NTI_ELEM_TIN_INSP]
	NTI_DuplicateElements($CurrentInspectionID_L; $NewInspectionID_L; $NumberProcessed_L; $progressObj_o)
	
	
	VALIDATE TRANSACTION:C240
	
	ON ERR CALL:C155("")
	
End if 



//End NTI_DuplicateInspection