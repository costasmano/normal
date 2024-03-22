//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/06, 22:10:38
	// ----------------------------------------------------
	// Method: GRP_RemoveFromGroup
	// Description
	// Remove a member from the current user group
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy3
	// Modified by: costasmanousakis-(Designer)-(3/22/2007 09:13:48)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/17/10 14:58:33)
	Mods_2010_09
	//  `Added changes to hanlde the Acting-promary roles when removing a member
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 12:15:11)
	Mods_2012_12
	//  `Use the LogLink method for the changes in [PERS_Groups]PERS_Primary, [PERS_Groups]PERS_Acting
	// Modified by: Costas Manousakis-(Designer)-(5/2/13 10:58:25)
	Mods_2013_05
	//  `use LogChanges  to clear out the primary or acting fields - logLiink will not transfer correctly
	// Modified by: Costas Manousakis-(Designer)-(5/7/18 10:42:07)
	Mods_2018_05
	//  `use object set title to show/clear names of acting/primary
End if 
C_LONGINT:C283(AllPersonnelList_hL; GroupMemberList_hL; $SelectedUser; $UserID)
C_TEXT:C284($UserName)
If (Is a list:C621(AllPersonnelList_hL) & Is a list:C621(GroupMemberList_hL))
	If (Count list items:C380(GroupMemberList_hL)>0)
		$SelectedUser:=Selected list items:C379(GroupMemberList_hL)
		If (($SelectedUser>0) & ($SelectedUser<=Count list items:C380(GroupMemberList_hL)))
			GET LIST ITEM:C378(GroupMemberList_hL; $SelectedUser; $UserID; $UserName)
			If (List item position:C629(AllPersonnelList_hL; $UserID)<1)
				APPEND TO LIST:C376(AllPersonnelList_hL; $UserName; $UserID)
				SORT LIST:C391(AllPersonnelList_hL)
				REDRAW:C174(AllPersonnelList_hL)  // Command Replaced was o_REDRAW LIST 
				If ([PERS_Groups:109]PERS_Primary:4=$UserID)
					[PERS_Groups:109]PERS_Primary:4:=0
					OBJECT SET TITLE:C194(*; "PERS_Primary_txt"; "")
					LogChanges(->[PERS_Groups:109]PERS_Primary:4; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
				End if 
				If ([PERS_Groups:109]PERS_Acting:3=$UserID)
					[PERS_Groups:109]PERS_Acting:3:=0
					OBJECT SET TITLE:C194(*; "PERS_Acting_txt"; "")
					LogChanges(->[PERS_Groups:109]PERS_Acting:3; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0)
				End if 
				
				DELETE FROM LIST:C624(GroupMemberList_hL; $UserID)
				SORT LIST:C391(GroupMemberList_hL)
				REDRAW:C174(GroupMemberList_hL)  // Command Replaced was o_REDRAW LIST 
			End if 
			If ($SelectedUser>Count list items:C380(GroupMemberList_hL))
				SELECT LIST ITEMS BY POSITION:C381(GroupMemberList_hL; Count list items:C380(GroupMemberList_hL))
			End if 
			
		End if 
	End if 
End if 