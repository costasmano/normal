//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJ_IdentifyHighestGroup
// User name (OS): cjmiller
// Date and time: 05/16/07, 11:18:51
// ----------------------------------------------------
// Description
// This method will identify and return hisghest group a person is a member of

//
// Parameters
//$0 highest group membership for access control

// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/16/07, 11:51:22 `Add code to control access 
End if 
READ ONLY:C145([Personnel:42])
READ ONLY:C145([PERS_GroupMembers:110])
READ ONLY:C145([PERS_Groups:109])

C_TEXT:C284($CurrentUser_txt; $CurrentGroup_txt; $0)
$CurrentUser_txt:=Current user:C182
$CurrentGroup_txt:="No Access"

If ($CurrentUser_txt="Designer")
	$CurrentGroup_txt:="PRJ_CreateGroup"
Else 
	QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=<>CurrentUser_UID)
	If (Records in selection:C76([Personnel:42])=1)
		QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=[Personnel:42]Person ID:1)
		SELECTION TO ARRAY:C260([PERS_GroupMembers:110]GroupID_I:1; $MembershipGroups_al)
		QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="PRJ_CreateGroup")
		If (Find in array:C230($MembershipGroups_al; [PERS_Groups:109]PERS_GroupID_I:1)>0)
			$CurrentGroup_txt:="PRJ_CreateGroup"
		Else 
			QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="Struct Proj Managers")
			If (Find in array:C230($MembershipGroups_al; [PERS_Groups:109]PERS_GroupID_I:1)>0)
				$CurrentGroup_txt:="Struct Proj Managers"
			Else 
				QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="PRJ_Tool")
				If (Find in array:C230($MembershipGroups_al; [PERS_Groups:109]PERS_GroupID_I:1)>0)
					$CurrentGroup_txt:="PRJ_Tool"
				Else 
					QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="Consultant Review")
					If (Find in array:C230($MembershipGroups_al; [PERS_Groups:109]PERS_GroupID_I:1)>0)
						$CurrentGroup_txt:="Consultant Review"
						
					Else 
						QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="BridgePreservation")
						If (Find in array:C230($MembershipGroups_al; [PERS_Groups:109]PERS_GroupID_I:1)>0)
							$CurrentGroup_txt:="BridgePreservation"
						Else 
							
							QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="BridgeInHouseDes")
							If (Find in array:C230($MembershipGroups_al; [PERS_Groups:109]PERS_GroupID_I:1)>0)
								$CurrentGroup_txt:="BridgeInHouseDes"
							End if 
						End if 
						
					End if 
				End if 
				
			End if 
		End if 
	End if 
End if 
$0:=$CurrentGroup_txt
//End ut_PRJ_IdentifyHighestGroup