//%attributes = {"invisible":true}
//Method: FM_InspectionInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 06/11/15, 15:43:59
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/11/15 15:44:00)
	Mods_2015_07_bug  // `Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
	Mods_2015_08_bug  //Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 16:00:19)
	Mods_2015_11  // Add ability to approve or reject  LSS inspections
	//Modified by: administrator (11/12/15 16:57:01)
	Mods_2015_12_bug  // Fix bug where deletion of picture records not recorded correctly
	//Modified by: administrator (12/24/15 11:13:41)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 11:16:14)
	Mods_2016_05_bug
	//  `sort order for Dmeter should be by location
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 12:45:20)
	Mods_2016_05_bug
	//  `sort Sign panels, Vert Clr by Panel_s , and Towerdist by TowerPost and Panel
	//  `ORDER BY([LSS_DMeter];[LSS_DMeter]LSS_DMeterDate_d;>;[LSS_DMeter]LSS_Location_s;>)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	Mods_2018_09  //Modify so that input forms show inspection type in heading
	//Modified by: Chuck Miller (9/27/18 14:08:52)
End if 

C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259>1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
	: ($FormEvent_L=On Data Change:K2:15)
		
		C_POINTER:C301($Focus_ptr)
		C_TEXT:C284($FocusObject_txt)
		C_LONGINT:C283($TableNumber_L; $FieldNumber_L)
		$Focus_ptr:=Focus object:C278
		RESOLVE POINTER:C394($Focus_ptr; $FocusObject_txt; $TableNumber_L; $FieldNumber_L)
		
		Case of 
			: (Position:C15("LSS_AccessibilityNeed"; $FocusObject_txt)>0)
				LSS_UpdateAccessibility_B:=True:C214
			: (Position:C15("LSS_AccessibilityUsed"; $FocusObject_txt)>0)
				LSS_UpdateAccessibility_B:=True:C214
			: (Position:C15("LSSOtherDescription_s"; $FocusObject_txt)>0)
				LSS_UpdateAccessibility_B:=True:C214
			Else 
		End case 
		
	: ($FormEvent_L=On Load:K2:1)
		
		LSS_EditDamageOnly_B:=False:C215
		InDoubleClick_B:=False:C215
		LSS_DuplicateRecordError_B:=False:C215
		LSS_Error_B:=False:C215
		LSS_UpdateMany_B:=False:C215
		ARRAY TEXT:C222(v_166_001_atxt; 0)  //[LSS_Photos]LSS_PhotoId_s
		ARRAY TEXT:C222(v_166_003_atxt; 0)  //[LSS_Photos]LSS_PhotoType_s
		ARRAY LONGINT:C221(v_166_006_aL; 0)  //[LSS_Photos]LSS_PhotoSequence_L
		LSS_UpdateAccessibility_B:=False:C215
		LSS_PhotoUpdateSeq_b:=False:C215
		START TRANSACTION:C239
		InitChangeStack(1)  //[LSS_Inspection]
		
		CLEAR VARIABLE:C89(LSS_AccessibilityNeed2_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityUsed2_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityNeed3_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityUsed3_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityNeed4_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityUsed4_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityNeed5_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityUsed5_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityNeed6_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityUsed6_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityNeed7_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityUsed7_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityNeed8_s)
		CLEAR VARIABLE:C89(LSS_AccessibilityUsed8_s)
		CLEAR VARIABLE:C89(LSSOtherDescription_s)
		CLEAR VARIABLE:C89(LSS_MassDOTRep_s)
		CLEAR VARIABLE:C89(LSS_ProjectManager_s)
		CLEAR VARIABLE:C89(LSS_TeamLeader_s)
		CLEAR VARIABLE:C89(LSS_TeamMembers_txt)
		
		
		OBJECT SET VISIBLE:C603(*; "bDelete"; LSS_AllowInspectionDelete_B)
		
		C_TEXT:C284($Category_txt)
		
		
		OBJECT SET VISIBLE:C603(*; "SequenceNumberUpdate"; False:C215)
		
		If (Type:C295(LSS_RatingChoices_as)=Is undefined:K8:13)
			ARRAY TEXT:C222(LSS_RatingChoices_as; 0)  //Command Replaced was o_ARRAY string length was 1
		End if 
		If (Type:C295(LSS_Deficiency_as)=Is undefined:K8:13)
			ARRAY TEXT:C222(LSS_Deficiency_as; 0)  //Command Replaced was o_ARRAY string length was 5
		End if 
		If (Type:C295(LSS_Urgency_as)=Is undefined:K8:13)
			ARRAY TEXT:C222(LSS_Urgency_as; 0)  //Command Replaced was o_ARRAY string length was 1
		End if 
		If (Size of array:C274(LSS_Deficiency_as)=0)
			ARRAY TEXT:C222(LSS_Deficiency_as; 5)  //Command Replaced was o_ARRAY string length was 5
			LSS_Deficiency_as{1}:=""
			LSS_Deficiency_as{2}:="M"
			LSS_Deficiency_as{3}:="S"
			LSS_Deficiency_as{4}:="C-S"
			LSS_Deficiency_as{5}:="C-H"
		End if 
		If (Size of array:C274(LSS_Urgency_as)=0)
			ARRAY TEXT:C222(LSS_Urgency_as; 4)  //Command Replaced was o_ARRAY string length was 1
			LSS_Urgency_as{1}:=""
			LSS_Urgency_as{2}:="I"
			LSS_Urgency_as{3}:="A"
			LSS_Urgency_as{4}:="P"
		End if 
		If (Size of array:C274(LSS_RatingChoices_as)=0)
			//This should come from table of lists or some other place
			ARRAY TEXT:C222(LSS_RatingChoices_as; 9)  //Command Replaced was o_ARRAY string length was 1
			LSS_RatingChoices_as{1}:=""
			LSS_RatingChoices_as{2}:="N"
			LSS_RatingChoices_as{3}:="1"
			LSS_RatingChoices_as{4}:="2"
			LSS_RatingChoices_as{5}:="3"
			LSS_RatingChoices_as{6}:="4"
			LSS_RatingChoices_as{7}:="H"
			LSS_RatingChoices_as{8}:="R"
			LSS_RatingChoices_as{9}:="X"
			
		End if 
		
		OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
		If (Is new record:C668([LSS_Inspection:164]))
			
			
			C_LONGINT:C283($ID_L)
			
			Inc_Sequence("LSS_InspectionId_s"; ->$ID_L)
			[LSS_Inspection:164]LSS_InspectionId_s:1:=String:C10($ID_L; <>KeyMask_s)
			[LSS_Inspection:164]LSS_InspectionTypeId_s:3:=LSS_InspectionTypeID_txt
			[LSS_Inspection:164]LSS_InventoryId_s:2:=[LSS_Inventory:165]LSS_InventoryId_s:1
			[LSS_Inspection:164]LSS_InspectionDate_d:4:=Current date:C33
			[LSS_Inspection:164]LSS_CreatedBy_s:45:=Current user:C182
			[LSS_Inspection:164]LSS_CreatedISODate_s:46:=ISODateTime(Current date:C33(*); Current time:C178(*))
			[LSS_Inspection:164]LSS_ConsultantName_txt:10:=<>PERS_MyCompany_txt
			[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=0
			If (GRP_UserInGroup("LSS_TeamLeader"; <>CurrentUser_PID)=1)
				[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=<>CurrentUser_PID
			End if 
			[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=0
			[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5:=0
			
			READ ONLY:C145([Personnel:42])
			ARRAY INTEGER:C220($Massdotreps_ai; Size of array:C274(LSS_MassDOTRepIDs_aL))
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($Massdotreps_ai))
				$Massdotreps_ai{$loop_L}:=LSS_MassDOTRepIDs_aL{$loop_L}
			End for 
			QUERY WITH ARRAY:C644([Personnel:42]Person ID:1; $Massdotreps_ai)
			QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Division No:7="044"+String:C10([LSS_Inventory:165]LSS_District_L:3))
			If (Records in selection:C76([Personnel:42])>0)
				FIRST RECORD:C50([Personnel:42])
				[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5:=[Personnel:42]Person ID:1
				LSS_MassDOTReps_atxt:=0  //Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
				POPUPMENUC(->LSS_MassDOTReps_atxt; ->LSS_MassDOTRepIDs_aL; ->[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5)
				LSS_MassDOTRep_s:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
			End if 
			
			LSS_SetUpButtonsForNewRecords
			
		Else 
			//LSS_SetPrevNextButtons (LSS_InspectionRow_L;Records in selection([LSS_Inspection]))
			
			QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
			
			LSS_FillAccessibility
			
		End if 
		
		//Page 3
		QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		ORDER BY:C49([LSS_DMeter:161]; [LSS_DMeter:161]LSS_DMeterDate_d:9; >; [LSS_DMeter:161]LSS_Location_s:3; >)
		QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		
		OBJECT SET VISIBLE:C603(*; "UTResults_@"; False:C215)
		
		If ([LSS_Inventory:165]LSS_InventoryType_s:28="HS") | ([LSS_Inventory:165]LSS_Category_s:2="SIGN")
			
			QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
			ORDER BY:C49([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_Panel_s:3; >)
			QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
			ORDER BY:C49([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_Panel_txt:3)
			QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
			ORDER BY:C49([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_TowerOrPost_txt:3; >; [LSS_TowerDistance:174]LSS_SignPanel_s:4; >)
		End if 
		
		LSS_SetPersonnel
		If (Is new record:C668([LSS_Inspection:164]))
			If ([LSS_Inspection:164]LSS_ProjectManagerId_L:9=0)
				If (Size of array:C274(LSS_ProjManagerIDs_aL)>0)
					[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=LSS_ProjManagerIDs_aL{1}
					LSS_ProjManagers_atxt:=0  //Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
					POPUPMENUC(->LSS_ProjManagers_atxt; ->LSS_ProjManagerIDs_aL; ->[LSS_Inspection:164]LSS_ProjectManagerId_L:9)
				End if 
				
			End if 
		End if 
		LSS_FillNames
		
		CLEAR VARIABLE:C89(LSS_Picture_pct)
		CLEAR VARIABLE:C89(LSS_UTPicture_pct)
		CLEAR VARIABLE:C89(LSS_DMeterPicture_pct)
		
		LSS_InpectionTabs_as:=1
		
		LSS_SetEntryColor(->[LSS_Inspection:164])
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (Read only state:C362([LSS_Inspection:164]))
			: (User in group:C338(Current user:C182; "Design Access Group"))
				$Entry_b:=True:C214
			Else 
				$Entry_b:=True:C214
				
		End case 
		
		
		
		OBJECT SET ENABLED:C1123(*; "LSS_Plans_b"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSS_Photos_b"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "bDelete"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "PlusButton_L@"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "UTButton_L"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "UTButton1_L"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "DMeterButton1_L"; $Entry_b)
		
		OBJECT SET ENABLED:C1123(*; "LSS_ConsultanList_atxt"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSS_MassDOTReps_atxt"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSS_ProjManagers_atxt"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSS_TeamLeaders_atxt"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSEditTeam"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSS_RtgDropDown@"; $Entry_b)
		
		
		OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; (([LSS_Inspection:164]LSS_Approved_L:43=BMS Rejected) | ([LSS_Inspection:164]LSS_ApprovalComments_txt:49#"")))
		OBJECT SET TITLE:C194(*; "LSS_Approved_L"; "Respond to Comments")
		
		If ([LSS_Inspection:164]LSS_Approved_L:43=BMS Approved) & ([LSS_Inspection:164]LSS_ApprovalComments_txt:49#"")
			OBJECT SET TITLE:C194(*; "LSS_Approved_L"; "View Comments")
		End if 
		OBJECT SET ENTERABLE:C238(*; "LSS_@;"; $Entry_b)
		OBJECT SET ENTERABLE:C238(*; "LSSEntryVariable@"; $Entry_b)
		OBJECT SET ENTERABLE:C238(*; "DMeterInput_@"; $Entry_b)
		OBJECT SET ENTERABLE:C238(*; "UTInput_@"; $Entry_b)
		
		If (In transaction:C397)
			[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1
		End if 
		QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=[LSS_Inspection:164]LSS_InspectionTypeId_s:3)
		
		LSS_CreateElementInputArrays([LSS_refInspectionType:167]LSS_AllowedElements_txt:3)
		
		C_LONGINT:C283($loop_L)
		ElementRating_LB:=0
		For ($loop_L; 1; Size of array:C274(ElementRating_LB))
			ElementRating_LB{$loop_L}:=False:C215
		End for 
		C_LONGINT:C283($pos_L)
		$pos_L:=Find in array:C230(LSS_InpectionTabs_as; "Damage")
		If ([LSS_refInspectionType:167]LSS_Description_txt:2="Damage@")
			If ($pos_L>0)
			Else 
				APPEND TO ARRAY:C911(LSS_InpectionTabs_as; "Damage")
			End if 
			
		Else 
			
			If ($pos_L>0)
				DELETE FROM ARRAY:C228(LSS_InpectionTabs_as; $pos_l; 1)
			End if 
		End if 
		C_TEXT:C284($Title_txt)
		$Title_txt:=OBJECT Get title:C1068(*; "InspectionHeader")
		$Title_txt:=Replace string:C233($Title_txt; "ROUTINE"; [LSS_refInspectionType:167]LSS_Description_txt:2)
		
		OBJECT SET TITLE:C194(*; "InspectionHeader"; Uppercase:C13($Title_txt))
		
		
End case 

//End FM_InspectionInput