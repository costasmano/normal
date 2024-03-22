//%attributes = {"invisible":true}
// Method: GRP_Primary_Acting
// Description
//  `Handle the primary and Acting buttons
// 
// Parameters
// $1 : $Primary_Acting_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/17/10, 14:07:53
	// ----------------------------------------------------
	
	Mods_2010_09
	Mods_2011_06  // CJ Miller`06/20/11, 10:09:48      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 12:18:55)
	Mods_2012_12
	//  `Use the LogLink method for the changes in [PERS_Groups]PERS_Primary, [PERS_Groups]PERS_Acting
	// Modified by: Costas Manousakis-(Designer)-(12/20/12 08:57:00)
	Mods_2012_12
	//  `Use PushChange when primary or acting is set to 0
	// Modified by: Costas Manousakis-(Designer)-(5/7/18 10:43:11)
	Mods_2018_05
	//  `use object set title to show/clear names of Primary / Acting
End if 
C_TEXT:C284($1)
C_LONGINT:C283(AllPersonnelList_hL; GroupMemberList_hL; $SelectedUser)
If (Is a list:C621(AllPersonnelList_hL) & Is a list:C621(GroupMemberList_hL))
	If (Count list items:C380(GroupMemberList_hL)>0)
		$SelectedUser:=Selected list items:C379(GroupMemberList_hL)
		If (($SelectedUser>0) & ($SelectedUser<=Count list items:C380(GroupMemberList_hL)))
			C_TEXT:C284($UserName)
			C_LONGINT:C283($UserID)
			GET LIST ITEM:C378(GroupMemberList_hL; $SelectedUser; $UserID; $UserName)
			
			Case of 
				: ($1="PRIMARY")
					If ([PERS_Groups:109]PERS_Primary:4#$UserID)
						[PERS_Groups:109]PERS_Primary:4:=$UserID
						OBJECT SET TITLE:C194(*; "PERS_Primary_txt"; $UserName)
						LogLink(->[PERS_Groups:109]PERS_Primary:4; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; ->[Personnel:42]Person ID:1)
					Else 
						[PERS_Groups:109]PERS_Primary:4:=0
						OBJECT SET TITLE:C194(*; "PERS_Primary_txt"; "")
						PushChange(1; ->[PERS_Groups:109]PERS_Primary:4)
					End if 
					
				: ($1="ACTING")
					If ([PERS_Groups:109]PERS_Acting:3#$UserID)
						[PERS_Groups:109]PERS_Acting:3:=$UserID
						OBJECT SET TITLE:C194(*; "PERS_Acting_txt"; $UserName)
						LogLink(->[PERS_Groups:109]PERS_Acting:3; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_Groups:109]PERS_GroupID_I:1; 0; ->[Personnel:42]Person ID:1)
					Else 
						[PERS_Groups:109]PERS_Acting:3:=0
						OBJECT SET TITLE:C194(*; "PERS_Acting_txt"; "")
						PushChange(1; ->[PERS_Groups:109]PERS_Acting:3)
					End if 
			End case 
			REDRAW:C174([PERS_Groups:109]PERS_Primary:4)
			REDRAW:C174([PERS_Groups:109]PERS_Acting:3)
			
		End if 
	End if 
End if 