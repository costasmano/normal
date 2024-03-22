
If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 10:47:36      ` Type all local variables for v11
End if 
C_LONGINT:C283($itemref; $nblogin; $retcode; $Owner; $K)
C_TEXT:C284($uname; $startup; $NewPW; $pw; $itemTxt)
C_DATE:C307($lastlogin)
GET LIST ITEM:C378(User_group_list; Selected list items:C379(User_group_list); $itemref; $itemTxt)
If (USGRP_UserListActive_b)
	If (Not:C34(Is user deleted:C616($ItemRef)))
		GET USER PROPERTIES:C611($itemref; $uname; $startup; $pw; $nblogin; $lastlogin)
		C_BOOLEAN:C305($NewUser_b; $done_b)
		$NewUser_b:=False:C215
		$done_b:=False:C215
		Repeat 
			$uname:=f_TrimStr(Request:C163("Enter New User Name"); True:C214; True:C214)
			$K:=Find in array:C230(asUNames; $uname+"@")
			If ($k>0)
				CONFIRM:C162("UserName <"+$uname+"> exists already ("+asUNames{$k}+")! Try again or cancel?"; "Again"; "Cancel")
				If (OK=1)
				Else 
					$done_b:=True:C214
				End if 
			Else 
				$done_b:=True:C214
				$NewUser_b:=True:C214
			End if 
		Until ($done_b)
		If ($NewUser_b)
			
			$NewPW:=f_TrimStr(Request:C163("Enter New Password"); True:C214; True:C214)
			If ((OK=1) & ($NewPW#"") & ($uname#""))
				$k:=Find in array:C230(alUIDs; $itemref)
				asUNames{$k}:=$uname
				$retcode:=Set user properties:C612($itemref; $uname; $startup; $NewPW; $nblogin; $lastlogin)
				If ($retCode=$itemref)
					$retcode:=Set user properties:C612($itemref; $uname; $startup; $NewPW; $nblogin; $lastlogin)
					GET USER PROPERTIES:C611($itemref; $uname; $startup; $pw; $nblogin; $lastlogin)
					ALERT:C41("Changed User name and pasword for "+String:C10($itemref)+" to "+$uname)
					SET LIST ITEM:C385(User_group_list; $itemref; $uname; $itemref)
					REDRAW:C174(User_group_list)  // Command Replaced was o_REDRAW LIST 
				Else 
					ALERT:C41("Some error occured!!!")
				End if 
				
			End if 
			
		End if 
	Else 
		ALERT:C41("User "+$itemTxt+" is deleted !")
	End if 
Else 
	GET GROUP PROPERTIES:C613($itemref; $uname; $Owner)
	C_BOOLEAN:C305($NewUser_b; $done_b)
	$NewUser_b:=False:C215
	$done_b:=False:C215
	Repeat 
		$uname:=f_TrimStr(Request:C163("Enter New Group Name"); True:C214; True:C214)
		$K:=Find in array:C230(asGrNames; $uname)
		If ($k>0)
			CONFIRM:C162("Group Name <"+$uname+"> exists already! Try again or cancel?"; "Again"; "Cancel")
			If (OK=1)
			Else 
				$done_b:=True:C214
			End if 
		Else 
			$done_b:=True:C214
			$NewUser_b:=True:C214
		End if 
	Until ($done_b)
	If ($NewUser_b)
		If ((OK=1) & ($uname#""))
			$k:=Find in array:C230(alGrIDs; $itemref)
			asGrNames{$k}:=$uname
			$retcode:=Set group properties:C614($itemref; $uname; $Owner)
			If ($retCode=$itemref)
				GET GROUP PROPERTIES:C613($itemref; $uname; $Owner)
				ALERT:C41("Changed Group name for "+String:C10($itemref)+" to "+$uname)
				SET LIST ITEM:C385(User_group_list; $itemref; $uname; $itemref)
				REDRAW:C174(User_group_list)  // Command Replaced was o_REDRAW LIST 
			Else 
				ALERT:C41("Some error occured!!!")
			End if 
			
		End if 
		
	End if 
	
End if 