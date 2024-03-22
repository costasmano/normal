If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 10:50:57      ` Type all local variables for v11
End if 
C_TEXT:C284($uname; $startup; $pw; $NewUserName; $NewUserPW; $itemTxt)
C_LONGINT:C283($ItemRef; $newwin; $nblogin; $NewID; $vlUsersublist)
C_DATE:C307($lastlogin)
ARRAY LONGINT:C221($grparray; 0)
If (USGRP_UserListActive_b)
	
	$NewUserName:=f_TrimStr(Request:C163("Enter New User Name "); True:C214; True:C214)
	If ((OK=1) & ($NewUserName#""))
		If (Find in array:C230(asUNames; ($NewUserName+" - @"))>0)
			ALERT:C41("User "+$NewUserName+" Exists Already!!")
		Else 
			$NewUserPW:=f_TrimStr(Request:C163("Password for "+$NewUserName); True:C214; True:C214)
			If ($NewUserPW="")
				ALERT:C41("Cannot have blank password!!!"+<>sCR+"That's a NO NO!!!")
			Else 
				GET LIST ITEM:C378(User_group_list; Selected list items:C379(User_group_list); $itemref; $itemTxt)
				If (Not:C34(Is user deleted:C616($ItemRef)))
					GET USER PROPERTIES:C611($itemref; $uname; $startup; $pw; $nblogin; $lastlogin; $grparray)
				Else 
					ARRAY LONGINT:C221($grparray; 0)
				End if 
				C_DATE:C307($BlankDate)
				$NewID:=Set user properties:C612((-2); $NewUserName; ""; $NewUserPW; 0; $BlankDate; $grparray)
				ALERT:C41("Added User "+$NewUserName+" ID :"+String:C10($NewID))
				$NewUserName:=$NewUserName+" - "+String:C10($BlankDate)
				If (Size of array:C274($grparray)>0)
					C_LONGINT:C283($j)
					$vlUsersublist:=New list:C375
					For ($j; 1; Size of array:C274($grparray))
						G_Add_to_PList($grparray{$j}; $vlUsersublist)
					End for 
					APPEND TO LIST:C376(User_Group_list; $NewUserName; $NewID; $vlUsersublist; False:C215)
				Else 
					APPEND TO LIST:C376(User_Group_list; $NewUserName; $NewID)
				End if 
				SORT LIST:C391(User_Group_list)
				REDRAW:C174(User_Group_list)  // Command Replaced was o_REDRAW LIST 
			End if 
			
		End if 
	End if 
Else 
	$NewUserName:=f_TrimStr(Request:C163("Enter New Group Name "); True:C214; True:C214)
	If ((OK=1) & ($NewUserName#""))
		If (Find in array:C230(asGrNames; $NewUserName)>0)
			ALERT:C41("Group "+$NewUserName+" Exists Already!!")
		Else 
			C_DATE:C307($BlankDate)
			$NewID:=Set group properties:C614((-2); $NewUserName; 2)
			ALERT:C41("Added Group "+$NewUserName+" ID :"+String:C10($NewID))
			APPEND TO LIST:C376(User_Group_list; $NewUserName; $NewID)
			SORT LIST:C391(User_Group_list)
			REDRAW:C174(User_Group_list)  // Command Replaced was o_REDRAW LIST 
			
		End if 
	End if 
End if 
