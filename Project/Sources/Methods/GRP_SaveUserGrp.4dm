//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/13/06, 00:41:48
	// ----------------------------------------------------
	// Method: GRP_SaveUserGrp
	// Description
	// Save the changes to the current Perts user group record
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy3
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(1/31/13 15:16:03)
	Mods_2013_01
	//  `Added code to enforce uniqueness of Groupname
	//  `Made sure the LogNewrecord command for the group is given before the Log commands for the groupmembers
End if 
C_LONGINT:C283($Count_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=[PERS_Groups:109]PERS_GroupName_s:2; *)
QUERY:C277([PERS_Groups:109];  & [PERS_Groups:109]PERS_GroupID_I:1#[PERS_Groups:109]PERS_GroupID_I:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($Count_L=0)
	If ((Is new record:C668([PERS_Groups:109])) & GRP_LogChanges_b)
		LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; "PersUserGroups")
	End if 
	
	C_LONGINT:C283($NumSelected; $i)
	QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
	ARRAY LONGINT:C221($GrpMemRecIDs_aL; 0)
	ARRAY LONGINT:C221($RecstoBeDeleted_aL; 0)
	SELECTION TO ARRAY:C260([PERS_GroupMembers:110]; $GrpMemRecIDs_aL; [PERS_GroupMembers:110]PersonID_I:2; $ExistMems_aI)
	$NumSelected:=Count list items:C380(GroupMemberList_hL)
	For ($i; 1; Size of array:C274($ExistMems_aI))
		If (List item position:C629(GroupMemberList_hL; $ExistMems_aI{$i})>0)
		Else 
			INSERT IN ARRAY:C227($RecstoBeDeleted_aL; 0)
			$RecstoBeDeleted_aL{1}:=$GrpMemRecIDs_aL{$i}
		End if 
	End for 
	If (Size of array:C274($RecstoBeDeleted_aL)>0)
		CREATE SELECTION FROM ARRAY:C640([PERS_GroupMembers:110]; $RecstoBeDeleted_aL; "GroupMemsforDel")
		USE NAMED SELECTION:C332("GroupMemsforDel")
		CLEAR NAMED SELECTION:C333("GroupMemsforDel")
		If (GRP_LogChanges_b)
			For ($i; 1; Records in selection:C76([PERS_GroupMembers:110]))
				GOTO SELECTED RECORD:C245([PERS_GroupMembers:110]; $i)
				
				If ([PERS_GroupMembers:110]PersonID_I:2>0)
					// this is a person
					LogDeletion(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ->[Personnel:42]Person ID:1)
				Else 
					// negative id implies a group
					LogDeletion(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ->[PERS_Groups:109]PERS_GroupID_I:1)
				End if 
				
			End for 
			
		End if 
		DELETE SELECTION:C66([PERS_GroupMembers:110])
		QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
		SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $ExistMems_aI)
	End if 
	C_LONGINT:C283($PersIDinList; $pos)
	C_TEXT:C284($Name)
	For ($i; 1; $NumSelected)
		GET LIST ITEM:C378(GroupMemberList_hL; $i; $PersIDinList; $Name)
		$pos:=Find in array:C230($ExistMems_aI; $PersIDinList)
		If ($pos<=0)
			CREATE RECORD:C68([PERS_GroupMembers:110])
			[PERS_GroupMembers:110]GroupID_I:1:=[PERS_Groups:109]PERS_GroupID_I:1
			[PERS_GroupMembers:110]PersonID_I:2:=$PersIDinList
			SAVE RECORD:C53([PERS_GroupMembers:110])
			If (GRP_LogChanges_b)
				
				If ([PERS_GroupMembers:110]PersonID_I:2>0)
					//this is a person
					LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
				Else 
					// negative id implies group - there is  
					LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[PERS_Groups:109]PERS_GroupID_I:1)
					
				End if 
				
			End if 
		End if 
		
	End for 
	If (GRP_LogChanges_b)
		FlushGrpChgs(1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
	End if 
Else 
	ALERT:C41("There is an existing Personnel Group with the same name <"+[PERS_Groups:109]PERS_GroupName_s:2+"> !")
	REJECT:C38
	OBJECT SET ENABLED:C1123(*; "bValidate@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	GOTO OBJECT:C206([PERS_Groups:109]PERS_GroupName_s:2)
	POST KEY:C465(Tab key:K12:28)
	POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
End if 