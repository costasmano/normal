//%attributes = {"invisible":true}
// Method: GRP_4DUIDinGroup
// Find if a 4D user ID belongs to a group in [Pers_groups]
// Parameters
// 1 : L : 4D User ID number
// 2 : Txt : Name of custom group (in [Pers_Groups])
// Result : L 
//  ` 0 : User not in group
//  ` 1 : User in group
//  ` -1 : Some error : 4D user ID is not assigned to a single Personnel record
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/22/07, 09:15:01
	// ----------------------------------------------------
	
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(2022-03-29T00:00:00 18:25:48)
	Mods_2022_03
	//  `modified to account for groups having subgroups
End if 
C_LONGINT:C283($0; $ResultCode_L; $1; $4DUID_L)
C_TEXT:C284($2; $PersGrpName_txt)
$4DUID_L:=$1
$PersGrpName_txt:=$2
$ResultCode_L:=0
READ ONLY:C145([PERS_Groups:109])
READ ONLY:C145([PERS_GroupMembers:110])
READ ONLY:C145([Personnel:42])

QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$4DUID_L)

C_LONGINT:C283($PersonID_L)
$PersonID_L:=[Personnel:42]Person ID:1

C_BOOLEAN:C305($vWildCardSearch_b)
$vWildCardSearch_b:=(Position:C15("@"; $PersGrpName_txt)>0)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$PersGrpName_txt)

ARRAY INTEGER:C220($PersGrpIDs_a_i; 0)
SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupID_I:1; $PersGrpIDs_a_i)

Case of 
	: (Records in selection:C76([Personnel:42])#1)
		$ResultCode_L:=-1  //unique personnel record not found for 4D usser ID
	: (Size of array:C274($PersGrpIDs_a_i)=0)
		$ResultCode_L:=-1  // personnel group not found
		
	Else 
		$ResultCode_L:=GRP_UserInGroup($PersGrpName_txt; $PersonID_L)
		If (False:C215)
			$ResultCode_L:=0
			
			QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $PersGrpIDs_a_i)
			QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=$PersonID_L)  //check if a member
			If (Records in selection:C76([PERS_GroupMembers:110])>0)
				//it is a member
				$ResultCode_L:=1
			Else 
				//check on groups
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
						QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=$PersonID_L)  //check if a member
						
						If (Records in selection:C76([PERS_GroupMembers:110])>0)
							$ResultCode_L:=1  // found it
							ARRAY INTEGER:C220($subGroups_a_i; 0)  // set array size to zero so we stop searching
						Else 
							QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $subGroups_a_i)
							QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2<0)  //look for subgroups
							SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $subGroups_a_i)
						End if 
						
					End if 
					
				End while 
				
			End if 
			
		End if 
		
End case 

READ WRITE:C146([PERS_Groups:109])
READ WRITE:C146([PERS_GroupMembers:110])
READ WRITE:C146([Personnel:42])
$0:=$ResultCode_L
