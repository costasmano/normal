//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/13/06, 01:09:22
	// ----------------------------------------------------
	// Method: GRP_DeletePersUGrp
	// Description
	// delete a personnel user group and assoc group memberships
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy3
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283($NumMembers; $i)

QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
$NumMembers:=Records in selection:C76([PERS_GroupMembers:110])
C_TEXT:C284($msg)
If ($NumMembers>0)
	$msg:=" (has "+String:C10($NumMembers)+" members) "
Else 
	
End if 
$msg:="Delete current Personnel group"+$msg+" ?"
CONFIRM:C162($msg; "Delete"; "Cancel")
If (Ok=1)
	If (GRP_LogChanges_b)
		For ($i; 1; Records in selection:C76([PERS_GroupMembers:110]))
			GOTO SELECTED RECORD:C245([PERS_GroupMembers:110]; $i)
			PushGrpDelete(->[PERS_GroupMembers:110]PersonID_I:2)
		End for 
		FlushGrpDeletions(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ->[Personnel:42]Person ID:1)
		
	End if 
	DELETE SELECTION:C66([PERS_GroupMembers:110])
	If (GRP_LogChanges_b)
		LogDeletion(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
	End if 
	DELETE RECORD:C58([PERS_Groups:109])
	CANCEL:C270
End if 