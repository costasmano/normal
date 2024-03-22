//%attributes = {"invisible":true}
//Method: LSS_SetUp
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/18/19, 16:20:02
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	// added status collection
End if 
//
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
	
	
	select
	[PERS_GroupMembers].PersonID_I
	from
	[PERS_GroupMembers], [PERS_Groups]
	where
	[PERS_GroupMembers].GroupID_I = [PERS_Groups].PERS_GroupID_I
	and
	[PERS_Groups].PERS_GroupName_s = 'LSS_TeamLeader'
	into :LSS_AllTeamLeaders_aL ;
	
	select
	[PERS_GroupMembers].PersonID_I
	from
	[PERS_GroupMembers], [PERS_Groups]
	where
	[PERS_GroupMembers].GroupID_I = [PERS_Groups].PERS_GroupID_I
	and
	[PERS_Groups].PERS_GroupName_s = 'LSS_TeamMember'
	into :LSS_AllTeamMembers_aL ;
	
	select
	[PERS_GroupMembers].PersonID_I
	from
	[PERS_GroupMembers], [PERS_Groups]
	where
	[PERS_GroupMembers].GroupID_I = [PERS_Groups].PERS_GroupID_I
	and
	[PERS_Groups].PERS_GroupName_s = 'LSS_ProjectManager'
	into :LSS_AllProjManagers_aL ;
	
	select 
	[LSS_refStructureTypes].[LSS_StructureTypeId_s], 
	[LSS_refStructureTypes].[LSS_Description_txt]
	from
	[LSS_refStructureTypes]
	into
	:LSS_STID_atxt, 
	:LSS_STDescription_atxt;
	
End SQL

ARRAY TEXT:C222(LSS_Categories_as; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(LSS_Districts_as; 0)  //Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222(LSS_StructType_atxt; 0)

C_COLLECTION:C1488(LSS_StatusColors_c)
C_TEXT:C284($param_txt)
$param_txt:=ut_GetSysParameter("LSS_StatusColors")
If ($param_txt#"")
	LSS_StatusColors_c:=JSON Parse:C1218($param_txt; Is collection:K8:32)
	
Else 
	LSS_StatusColors_c:=New collection:C1472(\
		New object:C1471("status"; "default"; "color"; 0x00FFFFFF); \
		New object:C1471("status"; "Active"; "color"; 0x0066FF99); \
		New object:C1471("status"; "Removed"; "color"; 0x00FFA080); \
		New object:C1471("status"; "Proposed"; "color"; 0x00FFCC66))
	
End if 

LSS_SetSelectPullDowns

//End LSS_SetUp