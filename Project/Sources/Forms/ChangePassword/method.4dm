//Method: "ChangePassword"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/12/22, 11:33:53
	// ----------------------------------------------------
	//Created : 
	// Modified by: Chuck Miller-(Designer)-(7/19/22 12:51:55)
	Mods_2022_07  //Modified how passwords are changed in single user so that server password can be changed at the same time
	
	// Modified by: Costas Manousakis-(Designer)-(2022-12-23 15:43:15)
	Mods_2022_12_bug
	//  `moved away the administrator pw field. added a ? button to display help message about the pw rules
	//  `when designer or admin pick the user from the list of users - add question to use the debug option
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($Pos_L)
		$Pos_L:=0
		SET WINDOW TITLE:C213("Change Password for "+Current user:C182)
		Form:C1466.CurrentUser:=Current user:C182
		OBJECT SET FONT:C164(*; "Pass@"; "%Password")
		
		If (Current user:C182="Designer") | (Current user:C182="Administrator")
			C_TEXT:C284($TestUserName_txt)
			ARRAY TEXT:C222($UserNames_atxt; 0)
			ARRAY LONGINT:C221($UserIDs_aL; 0)
			GET USER LIST:C609($UserNames_atxt; $UserIDs_aL)
			SORT ARRAY:C229($UserNames_atxt; $UserIDs_aL)
			C_LONGINT:C283($picked_L)
			C_BOOLEAN:C305($endrepeat_b)
			$endrepeat_b:=False:C215
			Repeat 
				$picked_L:=G_PickFromList(->$UserNames_atxt; "Choose a user")
				If ($picked_L>0) & (OK=1)
					
					CONFIRM:C162("Change Password for  "+$UserNames_atxt{$picked_L}; "Yes"; "No")
					If (OK=1)
						Form:C1466.CurrentUser:=$UserNames_atxt{$picked_L}
						SET WINDOW TITLE:C213("Change Password for "+$UserNames_atxt{$picked_L})
						$endrepeat_b:=True:C214
					End if 
					
				Else 
					$endrepeat_b:=True:C214  // cancel -> end repeat loop
				End if 
				
			Until ($endrepeat_b)
			
			If ($picked_L>0)
				CONFIRM:C162("Use Debug option?")
				If (Ok=1)
					Form:C1466.dodebug:=True:C214
				End if 
			Else 
				//did not pick anyone
				CANCEL:C270
				
			End if 
			
		End if   //End if design or administrator
		
	: (Form event code:C388=On Unload:K2:2)
		If (OB Is defined:C1231(Form:C1466; "HelpWinID"))
			C_LONGINT:C283($winID)
			$winID:=Form:C1466.HelpWinID
			CLOSE WINDOW:C154($winID)
		End if 
End case 
//End ChangePassword