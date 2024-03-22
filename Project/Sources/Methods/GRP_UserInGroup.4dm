//%attributes = {"invisible":true}
// Method: Method: GRP_UserInGroup
// Description
//  ` Determine whether the current user is a member of a group(s)
// Parameters
// $0 : $Result_L
// $1 : $PersGrpName_txt in ([Pers_Groups])
// $2 : $PersUserID_i (optional) : ID from [Personnel] table
// Result : L 
//  ` 0 : User not in group
//  ` 1 : User in group
//  ` -1 : Some error
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/24/10, 11:03:11
	// ----------------------------------------------------
	
	Mods_2010_09
	Mods_2015_03
	//Modified by: administrator (3/25/15 16:01:13)
	//Add code to only reset to read write mode when in that state to start
	// Modified by: Costas Manousakis-(Designer)-(1/16/19 12:33:06)
	Mods_2019_01_bug
	//  `do not return an error if there are no members found - the problem will be
	//  `by loss of functionality - and not by impacting other areas - partial fix to CallReference #593 
	// Modified by: Costas Manousakis-(Designer)-(2022-03-29T00:00:00 20:38:40)
	Mods_2022_03
	//  `modified to account for groups having subgroups
End if 
C_LONGINT:C283($0; $Result_L)
C_TEXT:C284($1; $PersGrpName_txt)
$PersGrpName_txt:=$1
C_LONGINT:C283($PersUserID_i)  // **Replaced C_LONGINT()//Command Replaced was o C INTEGER
$PersUserID_i:=<>CurrentUser_PID
If (Count parameters:C259>1)
	C_LONGINT:C283($2)  // **Replaced C_LONGINT()//Command Replaced was o C_INTEGER
	$PersUserID_i:=$2
End if 

$Result_L:=0

C_BOOLEAN:C305($ReadStateGM_B; $ReadStateGroup_B)
$ReadStateGM_B:=Read only state:C362([PERS_GroupMembers:110])
$ReadStateGroup_B:=Read only state:C362([PERS_Groups:109])
READ ONLY:C145([PERS_GroupMembers:110])
READ ONLY:C145([PERS_Groups:109])

C_BOOLEAN:C305($vWildCardSearch_b)
$vWildCardSearch_b:=(Position:C15("@"; $PersGrpName_txt)>0)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$PersGrpName_txt)

ARRAY INTEGER:C220($PersGrpIDs_a_i; Records in selection:C76([PERS_Groups:109]))
SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupID_I:1; $PersGrpIDs_a_i)

QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $PersGrpIDs_a_i)
QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=$PersUserID_i)

If (Records in selection:C76([PERS_GroupMembers:110])>0)
	$Result_L:=1
	
	//QUERY SELECTION([PERS_GroupMembers];[PERS_GroupMembers]PersonID_I=$PersUserID_i)
	//If ((Records in selection([PERS_GroupMembers])=1) | ((Records in selection([PERS_GroupMembers])>0) & $vWildCardSearch_b))
	//$Result_L:=1
	//Else 
	//$Result_L:=0
	//End if 
Else 
	//$Result_L:=-1
	QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $PersGrpIDs_a_i)
	QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2<0)
	ARRAY INTEGER:C220($subGroups_a_i; 0)
	SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $subGroups_a_i)
	
	C_LONGINT:C283($loop_L)
	
	While (Size of array:C274($subGroups_a_i)>0)
		
		For ($loop_L; Size of array:C274($subGroups_a_i); 1; -1)
			$subGroups_a_i{$loop_L}:=(-1*$subGroups_a_i{$loop_L})
			If (Find in array:C230($PersGrpIDs_a_i; $subGroups_a_i{$loop_L})>0)
				DELETE FROM ARRAY:C228($subGroups_a_i; $loop_L; 1)  // delete from further searching
			Else 
				APPEND TO ARRAY:C911($PersGrpIDs_a_i; $subGroups_a_i{$loop_L})  //add to list so it does not get searched again
			End if 
		End for 
		
		If (Size of array:C274($subGroups_a_i)>0)
			QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $subGroups_a_i)
			QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=$PersUserID_i)  //check if a member
			
			If (Records in selection:C76([PERS_GroupMembers:110])>0)
				$Result_L:=1  // found it
				ARRAY INTEGER:C220($subGroups_a_i; 0)  // set array size to zero so we stop searching
			Else 
				QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $subGroups_a_i)
				QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2<0)  //look for subgroups
				SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $subGroups_a_i)
			End if 
			
		End if 
		
	End while 
	
End if 

If (Not:C34($ReadStateGM_B))
	READ WRITE:C146([PERS_GroupMembers:110])
End if 
If (Not:C34($ReadStateGroup_B))
	READ WRITE:C146([PERS_Groups:109])
End if 

$0:=$Result_L