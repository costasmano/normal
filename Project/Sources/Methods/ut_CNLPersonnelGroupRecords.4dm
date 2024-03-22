//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/03/14, 12:21:20
//----------------------------------------------------
//Method: ut_CNLPersonnelGroupRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	//Modified by: Charles Miller (4/3/14 12:21:22)
	
End if 
READ ONLY:C145(*)
READ WRITE:C146([PERS_Groups:109])
//Check and create if need by new group
//LSS Project Manager
//LSS Team Leader
//LSS Team Member
//LSS Mass DOT Rep
ARRAY POINTER:C280(ptr_Changes; 0; 0)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="LSS Project Manager")
If (Records in selection:C76([PERS_Groups:109])=0)
	CREATE RECORD:C68([PERS_Groups:109])
	Inc_Sequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
	[PERS_Groups:109]PERS_GroupName_s:2:="LSS Project Manager"
	InitChangeStack(1)
	LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; "PersUserGroups")
	PushChange(1; ->[PERS_Groups:109]PERS_GroupName_s:2)
	FlushGrpChgs(1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
	SAVE RECORD:C53([PERS_Groups:109])
	UNLOAD RECORD:C212([PERS_Groups:109])
End if 
ARRAY POINTER:C280(ptr_Changes; 0; 0)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="LSS Team Leader")
If (Records in selection:C76([PERS_Groups:109])=0)
	CREATE RECORD:C68([PERS_Groups:109])
	Inc_Sequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
	[PERS_Groups:109]PERS_GroupName_s:2:="LSS Team Leader"
	InitChangeStack(1)
	LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; "PersUserGroups")
	PushChange(1; ->[PERS_Groups:109]PERS_GroupName_s:2)
	FlushGrpChgs(1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
	SAVE RECORD:C53([PERS_Groups:109])
	UNLOAD RECORD:C212([PERS_Groups:109])
End if 
ARRAY POINTER:C280(ptr_Changes; 0; 0)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="LSS Team Member")
If (Records in selection:C76([PERS_Groups:109])=0)
	CREATE RECORD:C68([PERS_Groups:109])
	Inc_Sequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
	[PERS_Groups:109]PERS_GroupName_s:2:="LSS Team Member"
	InitChangeStack(1)
	LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; "PersUserGroups")
	PushChange(1; ->[PERS_Groups:109]PERS_GroupName_s:2)
	FlushGrpChgs(1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
	SAVE RECORD:C53([PERS_Groups:109])
	UNLOAD RECORD:C212([PERS_Groups:109])
End if 
ARRAY POINTER:C280(ptr_Changes; 0; 0)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="Mass DOT Rep")
If (Records in selection:C76([PERS_Groups:109])=0)
	CREATE RECORD:C68([PERS_Groups:109])
	Inc_Sequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
	[PERS_Groups:109]PERS_GroupName_s:2:="Mass DOT Rep"
	InitChangeStack(1)
	LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; "PersUserGroups")
	PushChange(1; ->[PERS_Groups:109]PERS_GroupName_s:2)
	FlushGrpChgs(1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
	SAVE RECORD:C53([PERS_Groups:109])
	UNLOAD RECORD:C212([PERS_Groups:109])
End if 
ARRAY POINTER:C280(ptr_Changes; 0; 0)
READ ONLY:C145([PERS_Groups:109])
//End ut_CNLPersonnelGroupRecords

