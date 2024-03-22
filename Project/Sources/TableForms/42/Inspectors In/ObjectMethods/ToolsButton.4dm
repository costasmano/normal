//Method: [Personnel];"Inspectors In".ToolsButton
//Description
//New button to launch menu with tools
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 9, 2022, 18:41:52
	Mods_2022_11
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(2023-06-07 10:40:27)
	Mods_2023_06_bug
	//  `allow access to changing password, groups and deactivating user only to design access group
End if 
//
ARRAY TEXT:C222($unames; 0)
ARRAY LONGINT:C221($uIDs; 0)
C_TEXT:C284($uname; $ustart; $upw)
C_LONGINT:C283($ulogin)
C_DATE:C307($lastlogin)
C_LONGINT:C283($myID)
C_TEXT:C284($menu_; $menupick)

C_LONGINT:C283($mouse_x; $mouse_y; $mousebtn)
GET MOUSE:C468($mouse_x; $mouse_y; $mousebtn)
//C_POINTER($currBtn_ptr)
//C_LONGINT($ol;$ot;$or;$ob)
//$currBtn_ptr:=OBJECT Get pointer(Object current)
//OBJECT GET COORDINATES($currBtn_ptr->;$ol;$ot;$or;$ob)
//$mouse_x:=$or
//$mouse_y:=$ob

GET USER LIST:C609($unames; $uIDs)
C_BOOLEAN:C305($valid4DID)
$valid4DID:=(Find in array:C230($uIDs; [Personnel:42]UserID_4D:12)>0)
ARRAY TEXT:C222($Tools_; 0)
APPEND TO ARRAY:C911($Tools_; "Show Login Info")
If (User in group:C338(Current user:C182; "Design Access Group"))
	
	If ($valid4DID)
		APPEND TO ARRAY:C911($Tools_; "Change password")
		APPEND TO ARRAY:C911($Tools_; "Add to 4D User group")
		APPEND TO ARRAY:C911($Tools_; "Remove from 4D User group")
		APPEND TO ARRAY:C911($Tools_; "Save Users and Groups on server")
		
	End if 
	APPEND TO ARRAY:C911($Tools_; "Add to Personnel group")
	APPEND TO ARRAY:C911($Tools_; "Remove from Personnel group")
	APPEND TO ARRAY:C911($Tools_; "Manage Personnel groups")
	APPEND TO ARRAY:C911($Tools_; "Deactivate user")
	
End if 

$menu_:=MENU_BuildMenuFromArrays(->$Tools_; ->$Tools_; ",")
$menupick:=Dynamic pop up menu:C1006($menu_)
RELEASE MENU:C978($menu_)
Case of 
	: ($menupick="Show Login Info")
		ut_BigAlert([Personnel:42]MachineName_txt:18; "Login info in [Personnel]")
	: ($menupick="Deactivate user")
		CONFIRM:C162("Deactivate user "+[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5+" company "+[Personnel:42]Employer:9+" ?")
		If (OK=1)
			C_LONGINT:C283($4DID)
			$4DID:=[Personnel:42]UserID_4D:12
			//remove active flag
			[Personnel:42]Active:11:=False:C215
			//change userID_4D to 0
			[Personnel:42]UserID_4D:12:=0
			PushChange(1; ->[Personnel:42]Active:11)
			PushChange(1; ->[Personnel:42]UserID_4D:12)
			//update hlist on page 1
			SELECT LIST ITEMS BY REFERENCE:C630(PWUserHList; [Personnel:42]UserID_4D:12)
			//remove from PERS_groups
			ARRAY LONGINT:C221($persgrpIDs_al; 0)
			ARRAY TEXT:C222($persgrpnames_atxt; 0)
			C_LONGINT:C283($myid)
			$myid:=[Personnel:42]Person ID:1
			Begin SQL
				select [PERS_GroupMembers].GroupID_I,
				[pers_groups].PERS_GroupName_s
				from [pers_groupmembers], [pers_groups]
				where [pers_groupmembers].PersonID_I = :$myid
				and [pers_groups].PERS_GroupID_I = [pers_Groupmembers].GroupID_I
				into :$persgrpIDs_al, :$persgrpnames_atxt ;
			End SQL
			If (Size of array:C274($persgrpIDs_al)>0)
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($persgrpIDs_al))
					QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$persgrpIDs_al{$loop_L}; *)
					QUERY:C277([PERS_GroupMembers:110];  & ; [PERS_GroupMembers:110]PersonID_I:2=$myid)
					If (ut_LoadRecordInteractiveV2(->[PERS_GroupMembers:110])=1)
						LogDeletion(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ->[Personnel:42]Person ID:1)
						DELETE RECORD:C58([PERS_GroupMembers:110])
					Else 
						
						ALERT:C41("Could not clear membership to group "+$persgrpnames_atxt{$loop_L}+" ! It must be done manually!")
					End if 
					
				End for 
			Else 
				ALERT:C41("User not a member of any personnel groups")
			End if 
			
			If ($valid4DID)
				//change groups array to only inactiveusers group
				C_TEXT:C284($uname; $ustart; $upw)
				ARRAY LONGINT:C221($grps; 0)
				ARRAY TEXT:C222($4dgroups; 0)
				ARRAY LONGINT:C221($4dgrouIDs; 0)
				GET GROUP LIST:C610($4dgroups; $4dgrouIDs)
				C_LONGINT:C283($inactivegroup)
				$inactivegroup:=$4dgrouIDs{Find in array:C230($4dgroups; "InactiveUsers")}
				
				GET USER PROPERTIES:C611($4DID; $uname; $ustart; $upw; $ulogin; $lastlogin; $grps)
				
				If (Size of array:C274($grps)=1) & (Find in array:C230($grps; $inactivegroup)>0)
					//member of one group and it is the inactive group
					ALERT:C41("User already member of the InactiveUsers group")
				Else 
					//all other cases replace the group membership
					ARRAY LONGINT:C221($grps; 0)
					APPEND TO ARRAY:C911($grps; $4dgrouIDs{Find in array:C230($4dgroups; "InactiveUsers")})
					ON ERR CALL:C155("4D_Errors")
					C_BOOLEAN:C305(4DError_b)
					4DError_b:=False:C215
					$4DID:=Set user properties:C612($4DID; $uname; $ustart; *; $ulogin; $lastlogin; $grps)
					If (4DError_b)
						C_TEXT:C284($errmsg)
						$errmsg:="Error updating Group membership in 4D Users and Groups\n"+ut_ArrayToText(->SQL_InternalDescriptions_atxt; "\n")
						ALERT:C41($errmsg)
						4DError_b:=False:C215
						
					Else 
						//save groups on server
						CONFIRM:C162("Save users and Groups on server?")
						If (OK=1)
							C_LONGINT:C283($procID_L)
							$procID_L:=Execute on server:C373("UG_SaveUsersAndGroups"; 0)
						End if 
						
					End if 
					
				End if   //not member of inactiveusers group only
				
			Else 
				ALERT:C41("4D user ID "+String:C10([Personnel:42]UserID_4D:12)+" is not valid in the current password system")
			End if   // if valid 4d user
			
			//update lists
			PERS_ShowMemberships
			
		End if   // OK to deactivate user
		
	: ($menupick="change password")
		C_TEXT:C284($pw)
		$pw:=USR_GeneratePassword(New object:C1471("firstname"; [Personnel:42]First Name:3; "lastname"; [Personnel:42]Last Name:5))
		$pw:=Request:C163("Enter new user password"; $pw)
		If ($pw#"")
			GET USER PROPERTIES:C611([Personnel:42]UserID_4D:12; $uname; $ustart; $upw; $ulogin; $lastlogin)
			ON ERR CALL:C155("4D_Errors")
			C_BOOLEAN:C305(4DError_b)
			4DError_b:=False:C215
			$myID:=Set user properties:C612([Personnel:42]UserID_4D:12; $uname; $ustart; $pw; $ulogin; $lastlogin)
			If (4DError_b)
				C_TEXT:C284($errmsg)
				$errmsg:="Error updating Password\n"+ut_ArrayToText(->SQL_InternalDescriptions_atxt; "\n")
				ALERT:C41($errmsg)
				4DError_b:=False:C215
			Else 
				//save groups on server
				CONFIRM:C162("Save users and Groups on server?")
				If (OK=1)
					C_LONGINT:C283($procID_L)
					$procID_L:=Execute on server:C373("UG_SaveUsersAndGroups"; 0)
				End if 
				
			End if 
			
		End if 
		
	: ($menupick="Add to 4D User group")
		ARRAY TEXT:C222($4dgroups; 0)
		ARRAY LONGINT:C221($4dgrouIDs; 0)
		GET GROUP LIST:C610($4dgroups; $4dgrouIDs)
		C_LONGINT:C283($loop_L)
		For ($loop_L; Size of array:C274($4dgroups); 1; -1)
			If ($4dgrouIDs{$loop_L}<0)
				//consider only administrator groups
				If (User in group:C338($unames{Find in array:C230($uIDs; [Personnel:42]UserID_4D:12)}; $4dgroups{$loop_L}))
					DELETE FROM ARRAY:C228($4dgrouIDs; $loop_L)
					DELETE FROM ARRAY:C228($4dgroups; $loop_L)
				End if 
				
			Else 
				//igonre designer groups
				DELETE FROM ARRAY:C228($4dgrouIDs; $loop_L)
				DELETE FROM ARRAY:C228($4dgroups; $loop_L)
				
			End if 
		End for 
		SORT ARRAY:C229($4dgroups; $4dgrouIDs)
		$menu_:=MENU_BuildMenuFromArrays(->$4dgroups; ->$4dgroups; ",")
		$menupick:=Dynamic pop up menu:C1006($menu_; ""; $mouse_x; $mouse_y)
		RELEASE MENU:C978($menu_)
		If ($menupick#"")
			//confirm choice
			CONFIRM:C162("Add user to 4D User group "+$menupick+" ?"; "Add"; "Cancel")
			If (OK=1)
				C_LONGINT:C283($pickID)
				$pickID:=$4dgrouIDs{Find in array:C230($4dgroups; $menupick)}
				ARRAY LONGINT:C221($usrGroupsIds; 0)
				GET USER PROPERTIES:C611([Personnel:42]UserID_4D:12; $uname; $ustart; $upw; $ulogin; $lastlogin; $usrGroupsIds)
				APPEND TO ARRAY:C911($usrGroupsIds; $pickID)
				ON ERR CALL:C155("4D_Errors")
				C_BOOLEAN:C305(4DError_b)
				4DError_b:=False:C215
				$myID:=Set user properties:C612([Personnel:42]UserID_4D:12; $uname; $ustart; *; $ulogin; $lastlogin; $usrGroupsIds)
				If (4DError_b)
					C_TEXT:C284($errmsg)
					$errmsg:="Error(s) updating 4D User groups\n"+ut_ArrayToText(->SQL_InternalDescriptions_atxt; "\n")
					ALERT:C41($errmsg)
					4DError_b:=False:C215
				Else 
					PERS_ShowMemberships(Choose:C955((OBJECT Get title:C1068(*; "Expand")="Expand"); "Collapse"; "Expand"))
					//save groups on server
					CONFIRM:C162("Save users and Groups on server?")
					If (OK=1)
						C_LONGINT:C283($procID_L)
						$procID_L:=Execute on server:C373("UG_SaveUsersAndGroups"; 0)
					End if 
					
				End if 
				
			End if   // if ok to add
			
		End if   //if picked a group
		
	: ($menupick="Remove from 4D user group")
		ARRAY LONGINT:C221($usrGroupsIds; 0)
		GET USER PROPERTIES:C611([Personnel:42]UserID_4D:12; $uname; $ustart; $upw; $ulogin; $lastlogin; $usrGroupsIds)
		
		If (Size of array:C274($usrGroupsIds)>0)
			ARRAY TEXT:C222($4dgroups; 0)
			ARRAY LONGINT:C221($4dgrouIDs; 0)
			GET GROUP LIST:C610($4dgroups; $4dgrouIDs)
			ARRAY TEXT:C222($usrGroups; Size of array:C274($usrGroupsIds))
			C_LONGINT:C283($loop_L; $grpindx)
			For ($loop_L; 1; Size of array:C274($usrGroups))
				$grpindx:=Find in array:C230($4dgrouIDs; $usrGroupsIds{$loop_L})
				
				If ($grpindx>0)
					$usrGroups{$loop_L}:=$4dgroups{$grpindx}
				Else 
					$usrGroups{$loop_L}:="Invalid group ID "+String:C10($usrGroupsIds{$loop_L})
				End if 
				
			End for 
			SORT ARRAY:C229($usrGroups; $usrGroupsIds)
			$menu_:=MENU_BuildMenuFromArrays(->$usrGroups; ->$usrGroups; ",")
			$menupick:=Dynamic pop up menu:C1006($menu_; ""; $mouse_x; $mouse_y)
			RELEASE MENU:C978($menu_)
			If ($menupick#"")
				CONFIRM:C162("Remove user from 4D user group "+$menupick+" ?"; "Remove"; "Cancel")
				If (OK=1)
					$grpindx:=Find in array:C230($usrGroups; $menupick)
					DELETE FROM ARRAY:C228($usrGroupsIds; $grpindx; 1)
					
					ON ERR CALL:C155("4D_Errors")
					C_BOOLEAN:C305(4DError_b)
					4DError_b:=False:C215
					$myID:=Set user properties:C612([Personnel:42]UserID_4D:12; $uname; $ustart; *; $ulogin; $lastlogin; $usrGroupsIds)
					If (4DError_b)
						C_TEXT:C284($errmsg)
						$errmsg:="Error(s) updating 4D User groups\n"+ut_ArrayToText(->SQL_InternalDescriptions_atxt; "\n")
						ALERT:C41($errmsg)
						4DError_b:=False:C215
					Else 
						PERS_ShowMemberships(Choose:C955((OBJECT Get title:C1068(*; "Expand")="Expand"); "Collapse"; "Expand"))
						//save groups on server
						CONFIRM:C162("Save users and Groups on server?")
						If (OK=1)
							C_LONGINT:C283($procID_L)
							$procID_L:=Execute on server:C373("UG_SaveUsersAndGroups"; 0)
						End if 
						
					End if   //if 4dError
					
				End if   // if ok to remove
				
			End if   //if picked a group
			
		Else 
			ALERT:C41("User does not belong to any 4D user groups")
		End if 
		
	: ($menupick="Save Users and Groups on server")
		//save groups on server
		CONFIRM:C162("Save users and Groups on server?")
		If (OK=1)
			C_LONGINT:C283($procID_L)
			$procID_L:=Execute on server:C373("UG_SaveUsersAndGroups"; 0)
		End if 
		
	: ($menupick="Add to Personnel group")
		ARRAY LONGINT:C221($persgrpIDs_al; 0)
		ARRAY TEXT:C222($persgrpnames_atxt; 0)
		C_LONGINT:C283($loadProgress_L)
		$loadProgress_L:=Progress New
		Progress SET TITLE($loadProgress_L; "Getting available Personnel groups")
		Progress SET PROGRESS($loadProgress_L; -1; ""; True:C214)
		Begin SQL
			select [pers_groups].PERS_GroupName_s , [pers_Groups].PERS_GroupID_I
			from [pers_groups]
			into :$persgrpnames_atxt , :$persgrpIDs_al ;
		End SQL
		
		C_LONGINT:C283($loop_L)
		//remove groups that user already belongs to
		For ($loop_L; Size of array:C274($persgrpIDs_al); 1; -1)
			If (GRP_UserInGroup($persgrpnames_atxt{$loop_L}; [Personnel:42]Person ID:1)=1)
				DELETE FROM ARRAY:C228($persgrpnames_atxt; $loop_L; 1)
				DELETE FROM ARRAY:C228($persgrpIDs_al; $loop_L; 1)
			End if 
		End for 
		
		Progress QUIT($loadProgress_L)
		DELAY PROCESS:C323(Current process:C322; 3)  // 3 ticks for the progress window to close
		
		SORT ARRAY:C229($persgrpnames_atxt; $persgrpIDs_al)
		$menu_:=MENU_BuildMenuFromArrays(->$persgrpnames_atxt; ->$persgrpnames_atxt; ",")
		$menupick:=Dynamic pop up menu:C1006($menu_; ""; $mouse_x; $mouse_y)
		RELEASE MENU:C978($menu_)
		If ($menupick#"")
			CONFIRM:C162("Add user to Personnel group "+$menupick+" ?"; "Add"; "Cancel")
			If (OK=1)
				$grpindx:=Find in array:C230($persgrpnames_atxt; $menupick)
				CREATE RECORD:C68([PERS_GroupMembers:110])
				[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
				[PERS_GroupMembers:110]GroupID_I:1:=$persgrpIDs_al{$grpindx}
				SAVE RECORD:C53([PERS_GroupMembers:110])
				LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
				UNLOAD RECORD:C212([PERS_GroupMembers:110])
				
				PERS_ShowMemberships(Choose:C955((OBJECT Get title:C1068(*; "Expand")="Expand"); "Collapse"; "Expand"))
				
			End if   //if ok to add
			
		End if   //if picked a group
		
	: ($menupick="Remove from Personnel group")
		ARRAY LONGINT:C221($persgrpIDs_al; 0)
		ARRAY TEXT:C222($persgrpnames_atxt; 0)
		C_LONGINT:C283($myid)
		$myid:=[Personnel:42]Person ID:1  // need this for the SQL call
		Begin SQL
			select [PERS_GroupMembers].GroupID_I,
			[pers_groups].PERS_GroupName_s
			from [pers_groupmembers], [pers_groups]
			where [pers_groupmembers].PersonID_I = :$myid
			and [pers_groups].PERS_GroupID_I = [pers_Groupmembers].GroupID_I
			into :$persgrpIDs_al, :$persgrpnames_atxt ;
		End SQL
		If (Size of array:C274($persgrpIDs_al)>0)
			SORT ARRAY:C229($persgrpnames_atxt; $persgrpIDs_al)
			$menu_:=MENU_BuildMenuFromArrays(->$persgrpnames_atxt; ->$persgrpnames_atxt; ",")
			$menupick:=Dynamic pop up menu:C1006($menu_; ""; $mouse_x; $mouse_y)
			RELEASE MENU:C978($menu_)
			If ($menupick#"")
				CONFIRM:C162("Remove user from Personnel group "+$menupick+" ?"; "Remove"; "Cancel")
				If (OK=1)
					QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$persgrpIDs_al{Find in array:C230($persgrpnames_atxt; $menupick)}; *)
					QUERY:C277([PERS_GroupMembers:110];  & ; [PERS_GroupMembers:110]PersonID_I:2=[Personnel:42]Person ID:1)
					If (ut_LoadRecordInteractiveV2(->[PERS_GroupMembers:110])=1)
						LogDeletion(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ->[Personnel:42]Person ID:1)
						DELETE RECORD:C58([PERS_GroupMembers:110])
						PERS_ShowMemberships(Choose:C955((OBJECT Get title:C1068(*; "Expand")="Expand"); "Collapse"; "Expand"))
						
					Else 
						ALERT:C41("Could not clear membership to group "+$menupick+" ! It must be done manually!")
					End if 
					
				End if   // if ok to remove
				
			End if   //if picked a group
			
		Else 
			ALERT:C41("User not a member of any Personnel groups")
		End if 
		
	: ($menupick="Manage Personnel groups")
		PERS_ManagePersonGrps([Personnel:42]Person ID:1)
		PERS_ShowMemberships(Choose:C955((OBJECT Get title:C1068(*; "Expand")="Expand"); "Collapse"; "Expand"))
		
End case 
//End [Personnel].Inspectors In.ToolsButton   