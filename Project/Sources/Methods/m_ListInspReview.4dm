//%attributes = {"invisible":true}
//Method: m_ListInspReview
//  `Description
//  ` run the Anc struct insp review screen
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 15:17:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
	
	C_TEXT:C284(m_ListInspReview; $1)
	Mods_2019_06  //Add code to make sure windows open and take into account 13" mac books
	//Modified by: Chuck Miller (6/4/19 13:52:21)
	
End if 
//

If (Count parameters:C259=0)
	C_LONGINT:C283($LPid_L)
	$LPid_L:=LSpawnProcess(Current method name:C684; <>LStackSize; "AncInspReview"; True:C214; False:C215; "RUN")
Else 
	C_TEXT:C284($1)
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	READ ONLY:C145(*)
	SHORT_MESSAGE("Retrieving data. Please wait…")
	Compiler_LB
	Compiler_LSS
	Compiler_InspElmtVars
	InitPers
	
	//ut_TestUser 
	LSS_SetUpPermissions
	//This is beginning of prefilling arrays
	
	ARRAY LONGINT:C221(LSS_ELementDictionaryID_al; 0)
	ARRAY BOOLEAN:C223(LSS_ELementDisctionaryHeader_ab; 0)
	ARRAY TEXT:C222(LSS_ELementDictionaryDescr_atxt; 0)
	ARRAY LONGINT:C221(LSS_AllTeamLeaders_aL; 0)
	ARRAY LONGINT:C221(LSS_AllTeamMembers_aL; 0)
	ARRAY LONGINT:C221(LSS_AllProjManagers_aL; 0)
	ARRAY TEXT:C222(LSS_STID_atxt; 0)
	ARRAY TEXT:C222(LSS_STDescription_atxt; 0)
	
	Begin SQL
		SELECT
		[LSS_Element].[LSS_ElementId_L], 
		[LSS_Element].[LSS_ElementHeader_b],  
		[LSS_Element].[LSS_ElementDescription_s] 
		FROM 
		[LSS_Element] 
		INTO 
		:LSS_ELementDictionaryID_aL,
		:LSS_ELementDisctionaryHeader_ab, 
		:LSS_ELementDictionaryDescr_atxt;
		
	End SQL
	
	Begin SQL
		select
		[PERS_GroupMembers].PersonID_I
		from
		[PERS_GroupMembers], [PERS_Groups]
		where
		[PERS_GroupMembers].GroupID_I = [PERS_Groups].PERS_GroupID_I
		and
		[PERS_Groups].PERS_GroupName_s = 'LSS_TeamLeader'
		into :LSS_AllTeamLeaders_aL ;
	End SQL
	
	Begin SQL
		select
		[PERS_GroupMembers].PersonID_I
		from
		[PERS_GroupMembers], [PERS_Groups]
		where
		[PERS_GroupMembers].GroupID_I = [PERS_Groups].PERS_GroupID_I
		and
		[PERS_Groups].PERS_GroupName_s = 'LSS_TeamMember'
		into :LSS_AllTeamMembers_aL ;
	End SQL
	
	Begin SQL
		select
		[PERS_GroupMembers].PersonID_I
		from
		[PERS_GroupMembers], [PERS_Groups]
		where
		[PERS_GroupMembers].GroupID_I = [PERS_Groups].PERS_GroupID_I
		and
		[PERS_Groups].PERS_GroupName_s = 'LSS_ProjectManager'
		into :LSS_AllProjManagers_aL ;
	End SQL
	
	Begin SQL
		select 
		[LSS_refStructureTypes].[LSS_StructureTypeId_s], 
		[LSS_refStructureTypes].[LSS_Description_txt]
		from
		[LSS_refStructureTypes]
		into
		:LSS_STID_atxt, 
		:LSS_STDescription_atxt;
		
	End SQL
	
	//LSS_SetKeyMask  
	READ ONLY:C145([LSS_Inventory:165])
	READ ONLY:C145([LSS_refInspectionType:167])
	
	LSS_GetPendingInsp
	
	ARRAY POINTER:C280(ptr_changes; 0; 0)
	
	C_LONGINT:C283($Width_L; $Height_L)
	SET MENU BAR:C67("Blankmenu")
	ARRAY TEXT:C222(LSS_Categories_as; 0)  //Command Replaced was o_ARRAY string length was 30
	ARRAY TEXT:C222(LSS_Districts_as; 0)  //Command Replaced was o_ARRAY string length was 10
	ARRAY TEXT:C222(LSS_StructType_atxt; 0)
	LSS_SetSelectPullDowns
	UpdatWindArray(""; Current process:C322)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	LSS_SortInspReview
	COPY NAMED SELECTION:C331([LSS_Inspection:164]; "InspReviewSet")
	CLOSE WINDOW:C154
	
	FORM GET PROPERTIES:C674([LSS_Inspection:164]; "InspectionReview"; $Width_L; $Height_L)
	C_LONGINT:C283($scrWidth_l; $scrHeight_l)
	
	//LSS_SetKeyMask  
	$scrWidth_l:=Screen width:C187
	$scrHeight_l:=Screen height:C188
	
	$Height_L:=800
	
	If ($scrHeight_l-20<$Height_L)
		$Height_L:=$scrHeight_l-120
	End if 
	If ($scrWidth_l<$Width_L)
		$Width_L:=$scrWidth_l-40
	End if 
	ut_OpenNewWindow($Width_L; $Height_L; 2; Plain window:K34:13)
	WIN_SetWindowTitle(->[LSS_Inspection:164])
	DIALOG:C40([LSS_Inspection:164]; "InspectionReview")
	CLEAR NAMED SELECTION:C333("InspReviewSet")
	CLEAR SET:C117("InspReviewSet")
	
	UpdatWindArray(""; Current process:C322)
	
End if 
//End m_ListInspReview