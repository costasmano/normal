//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: GRP_GetGroupRepID
// Description
//  ` Retrieve the ID of the representative of a personnel group. 
//  ` Either the primary, the acting, or the first one on the list
// 
// Parameters
// $0 : $PersonID_L of primary member
// $1 : $GroupName_txt in Pers_groups
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/06/11, 09:12:15
	// First Release
	Mods_2011_12
End if 
C_LONGINT:C283($0; $PersonID_L)
$PersonID_L:=-9999
C_TEXT:C284($1; $GroupName_txt)
$GroupName_txt:=$1

C_BOOLEAN:C305($GrpRO_b; $GrpMemRO_b; $PersRO_b)
$GrpRO_b:=Read only state:C362([PERS_Groups:109])
$GrpMemRO_b:=Read only state:C362([PERS_GroupMembers:110])
$PersRO_b:=Read only state:C362([Personnel:42])
READ ONLY:C145([PERS_Groups:109])
READ ONLY:C145([Personnel:42])
READ ONLY:C145([PERS_GroupMembers:110])

QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt)
Case of 
	: (Records in selection:C76([PERS_Groups:109])=1)
		FIRST RECORD:C50([PERS_Groups:109])
		LOAD RECORD:C52([PERS_Groups:109])
		Case of 
			: ([PERS_Groups:109]PERS_Primary:4>0)
				$PersonID_L:=[PERS_Groups:109]PERS_Primary:4
			: ([PERS_Groups:109]PERS_Acting:3>0)
				$PersonID_L:=[PERS_Groups:109]PERS_Acting:3
			Else 
				QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
				FIRST RECORD:C50([PERS_GroupMembers:110])
				$PersonID_L:=[PERS_GroupMembers:110]PersonID_I:2
				
		End case 
		
	: (Records in selection:C76([PERS_Groups:109])=0)
		$PersonID_L:=0
	: (Records in selection:C76([PERS_Groups:109])>1)
		$PersonID_L:=-1
		
End case 

If (Not:C34($GrpRO_b))
	READ WRITE:C146([PERS_Groups:109])
End if 
If (Not:C34($GrpMemRO_b))
	READ WRITE:C146([PERS_GroupMembers:110])
End if 
If (Not:C34($PersRO_b))
	READ WRITE:C146([Personnel:42])
End if 

$0:=$PersonID_L