//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/06, 22:10:09
	// ----------------------------------------------------
	// Method: GRP_AddToGroup
	// Description
	// Add a Personnel member to the current user group
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy3
	// Modified by: costasmanousakis-(Designer)-(3/22/2007 09:12:25)
	Mods_2007_CM07
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283(AllPersonnelList_hL; GroupMemberList_hL; $SelectedUser; $UserID)
C_TEXT:C284($UserName)
If (Is a list:C621(AllPersonnelList_hL) & Is a list:C621(GroupMemberList_hL))
	If (Count list items:C380(AllPersonnelList_hL)>0)
		$SelectedUser:=Selected list items:C379(AllPersonnelList_hL)
		If (($SelectedUser>0) & ($SelectedUser<=Count list items:C380(AllPersonnelList_hL)))
			GET LIST ITEM:C378(AllPersonnelList_hL; $SelectedUser; $UserID; $UserName)
			If (List item position:C629(GroupMemberList_hL; $UserID)<1)
				APPEND TO LIST:C376(GroupMemberList_hL; $UserName; $UserID)
				SORT LIST:C391(GroupMemberList_hL)
				REDRAW:C174(GroupMemberList_hL)  // Command Replaced was o_REDRAW LIST 
				DELETE FROM LIST:C624(AllPersonnelList_hL; $UserID)
				SORT LIST:C391(AllPersonnelList_hL)
				REDRAW:C174(AllPersonnelList_hL)  // Command Replaced was o_REDRAW LIST 
			End if 
			If ($SelectedUser>Count list items:C380(AllPersonnelList_hL))
				SELECT LIST ITEMS BY POSITION:C381(AllPersonnelList_hL; Count list items:C380(AllPersonnelList_hL))
			End if 
			
		End if 
		
	End if 
End if 