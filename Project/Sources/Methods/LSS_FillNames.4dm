//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 10/21/14, 10:52:10
// ----------------------------------------------------
// Method: LSS_FillNames
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($Key_L; $Loop_L)
C_TEXT:C284($Key_txt)

$Key_L:=[LSS_Inspection:164]LSS_ProjectManagerId_L:9
LSS_ProjectManager_s:=""
Begin SQL
	select  CONCAT(CONCAT([Personnel].[First Name],' '),[Personnel].[Last Name])
	FROM [Personnel]
	where [Personnel].[Person ID] = :$Key_L
	into :LSS_ProjectManager_s;
End SQL

$Key_L:=[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5
LSS_MassDOTRep_s:=""
Begin SQL
	select  CONCAT(CONCAT([Personnel].[First Name],' '),[Personnel].[Last Name])
	FROM [Personnel]
	where [Personnel].[Person ID] = :$Key_L
	into :LSS_MassDOTRep_s;
End SQL

$Key_L:=[LSS_Inspection:164]LSS_TeamLeaderId_L:8
LSS_TeamLeader_s:=""
Begin SQL
	select  CONCAT(CONCAT([Personnel].[First Name],' '),[Personnel].[Last Name])
	FROM [Personnel]
	where [Personnel].[Person ID] = :$Key_L
	into :LSS_TeamLeader_s;
End SQL

LSS_FillTeamMembers
