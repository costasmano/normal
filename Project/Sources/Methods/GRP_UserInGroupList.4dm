//%attributes = {"invisible":true}
//Method: GRP_UserInGroupList
//Description
// Determine whether the user is a member of a list of groups passed as an text array pointer
// Parameters
// $0 : $Result_L
// $1 : $PersGrps_ptr ptr to string/text array with names of groups in ([Pers_Groups])
// $2 : $PersUserID_i (optional) : ID from [Personnel] table
// Result : L 
//  ` 0 : User not in any group
//  ` N>0 : User in N group(s)
//  ` -1 : Some error
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/16, 09:28:46
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_LONGINT:C283(GRP_UserInGroupList; $0)
	C_POINTER:C301(GRP_UserInGroupList; $1)
	C_LONGINT:C283(GRP_UserInGroupList; $2)  //Command Replaced was o_C_INTEGER
	
End if 
//

C_LONGINT:C283($0; $Result_L)
C_POINTER:C301($1; $PersGrpNames_ptr)
$PersGrpNames_ptr:=$1
C_LONGINT:C283($PersUserID_i)  //Command Replaced was o_C_INTEGER
$PersUserID_i:=<>CurrentUser_PID
If (Count parameters:C259>1)
	C_LONGINT:C283($2)  //Command Replaced was o_C_INTEGER
	$PersUserID_i:=$2
End if 

$Result_L:=0

C_BOOLEAN:C305($ReadStateGM_B; $ReadStateGroup_B)
$ReadStateGM_B:=Read only state:C362([PERS_GroupMembers:110])
$ReadStateGroup_B:=Read only state:C362([PERS_Groups:109])
READ ONLY:C145([PERS_GroupMembers:110])
READ ONLY:C145([PERS_Groups:109])

If ((Type:C295($PersGrpNames_ptr->)=String array:K8:15) | (Type:C295($PersGrpNames_ptr->)=Text array:K8:16))
	C_LONGINT:C283($loop_L; $Res_L)
	For ($loop_L; 1; Size of array:C274($PersGrpNames_ptr->))
		$Res_L:=GRP_UserInGroup($PersGrpNames_ptr->{$loop_L}; $PersUserID_i)
		
		Case of 
			: ($Res_L=1)
				$Result_L:=$Result_L+1
			: ($Res_L<0)
				$Result_L:=-1  //in case of error exit loop
				$loop_L:=Size of array:C274($PersGrpNames_ptr->)+1
		End case 
		
	End for 
	
Else 
	ALERT:C41("!! Error in GRP_UserInGroupList : Parameter 1 not a string or text array!")
	$Result_L:=-1
End if 

If (Not:C34($ReadStateGM_B))
	READ WRITE:C146([PERS_GroupMembers:110])
End if 
If (Not:C34($ReadStateGroup_B))
	READ WRITE:C146([PERS_Groups:109])
End if 

$0:=$Result_L
//End GRP_UserInGroupList