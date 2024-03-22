//%attributes = {"invisible":true}
//Method: Temp_CreateAddInspGrp
//Description
// create or update pers_group "TIN_AddInspections"
// all jobe code 1,2,3 and Active and member of "MHDInspectionRWAccess"
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/17/16, 16:08:48
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
//find group
C_LONGINT:C283($groupID_L)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="TIN_AddInspections_ALL")
If (Records in selection:C76([PERS_Groups:109])=0)
	CREATE RECORD:C68([PERS_Groups:109])
	Inc_Sequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
	[PERS_Groups:109]PERS_GroupName_s:2:="TIN_AddInspections_ALL"
	
	LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; "PersUserGroups")
	LogChanges(->[PERS_Groups:109]PERS_GroupName_s:2; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
	SAVE RECORD:C53([PERS_Groups:109])
End if 

$groupID_L:=[PERS_Groups:109]PERS_GroupID_I:1

QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$groupID_L)
//get current list
ARRAY INTEGER:C220($CurrentList_aL; 0)
SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $CurrentList_aL)

READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]Active:11=True:C214)

QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Job Code:8=1; *)  //dbie 
QUERY SELECTION:C341([Personnel:42];  | ; [Personnel:42]Job Code:8=2; *)  // tm leader
QUERY SELECTION:C341([Personnel:42];  | ; [Personnel:42]Job Code:8=3)  //tm member

QUERY SELECTION:C341([Personnel:42]; [Personnel:42]UserID_4D:12#0)

CREATE SET:C116([Personnel:42]; "ALLELIGIBLE")
//first do _ALL = all consultants i.e. employer # "Mass. highwa..."
QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9#"Mass. Highway D@")

FIRST RECORD:C50([Personnel:42])
While (Not:C34(End selection:C36([Personnel:42])))
	//check if member of MHDInspectionRWAccess
	If (User in group:C338(Pers_Get4DUName; "MHDInspectionRWAccess"))
		//check if user already in the list
		If (Find in array:C230($CurrentList_aL; [Personnel:42]Person ID:1)>0)
		Else 
			//needs to be added
			CREATE RECORD:C68([PERS_GroupMembers:110])
			[PERS_GroupMembers:110]GroupID_I:1:=$groupID_L
			[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
			SAVE RECORD:C53([PERS_GroupMembers:110])
			LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
		End if 
	Else 
		
	End if 
	NEXT RECORD:C51([Personnel:42])
End while 

//repeat for D1 - D6 i.e. employer=Mass. higway" and division = 0441-0446
C_LONGINT:C283($distrLoop_L)
C_TEXT:C284($GroupName_txt)
For ($distrLoop_L; 1; 6)
	$GroupName_txt:="TIN_AddInspections_D"+String:C10($distrLoop_L)
	QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt)
	If (Records in selection:C76([PERS_Groups:109])=0)
		CREATE RECORD:C68([PERS_Groups:109])
		Inc_Sequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
		[PERS_Groups:109]PERS_GroupName_s:2:=$GroupName_txt
		
		LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; "PersUserGroups")
		LogChanges(->[PERS_Groups:109]PERS_GroupName_s:2; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
		SAVE RECORD:C53([PERS_Groups:109])
	End if 
	
	$groupID_L:=[PERS_Groups:109]PERS_GroupID_I:1
	
	QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$groupID_L)
	//get current list
	ARRAY INTEGER:C220($CurrentList_aL; 0)
	SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $CurrentList_aL)
	USE SET:C118("ALLELIGIBLE")
	QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9="Mass. Highway D@"; *)
	QUERY SELECTION:C341([Personnel:42];  & ; [Personnel:42]Division No:7="044"+String:C10($distrLoop_L))
	FIRST RECORD:C50([Personnel:42])
	While (Not:C34(End selection:C36([Personnel:42])))
		//check if member of MHDInspectionRWAccess
		If (User in group:C338(Pers_Get4DUName; "MHDInspectionRWAccess"))
			//check if user already in the list
			If (Find in array:C230($CurrentList_aL; [Personnel:42]Person ID:1)>0)
			Else 
				//needs to be added
				CREATE RECORD:C68([PERS_GroupMembers:110])
				[PERS_GroupMembers:110]GroupID_I:1:=$groupID_L
				[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
				SAVE RECORD:C53([PERS_GroupMembers:110])
				LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
			End if 
		Else 
			
		End if 
		NEXT RECORD:C51([Personnel:42])
	End while 
	
End for 

UNLOAD RECORD:C212([PERS_GroupMembers:110])
UNLOAD RECORD:C212([PERS_Groups:109])

CLEAR SET:C117("ALLELIGIBLE")

//End Temp_CreateAddInspGrp