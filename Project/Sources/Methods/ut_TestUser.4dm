//%attributes = {"invisible":true}
// Method: ut_TestUser
// Description
// Switch the enviroment to another user - mainly for testing code. Pick a user from the aPeople list.
// Available only  design access users.
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 08:29:08
	// ----------------------------------------------------
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(6/27/17 16:58:05)
	Mods_2017_06_bug
	//  `aPeople can be a text array
	// Modified by: Costas Manousakis-(Designer)-(3/17/21 16:58:32)
	Mods_2021_03
	//  `if we cancel from the choice, ask to switch back.
	// Modified by: Costas Manousakis-(Designer)-(2022-11-15 14:16:45)
	Mods_2022_11
	//  `use local arrays for people and people id so we can display employer and whether user is active
	//  `only get people who have a 4d user id
	
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	C_LONGINT:C283($Person_L; $step_l; $NumSteps_L; $New4DUID_L)
	C_TEXT:C284($error_t)
	$step_l:=0
	$NumSteps_L:=5
	$error_t:=""
	Repeat 
		Case of 
			: ($step_l=0)
				ARRAY TEXT:C222($people; 0)
				ARRAY LONGINT:C221($peopleID; 0)
				Begin SQL
					select concat(concat(concat(concat(concat(CONCAT([personnel].[first name],' ') 
					,[personnel].[last name]),' - ')
					,[Personnel].[Employer]),' - ')
					,substring('IA',1+cast([personnel].[active] as int),1)),
					[Personnel].[Person ID]
					from [personnel]
					where
					[personnel].[userid_4d] <> 0
					into :$people, :$peopleID ;
					
				End SQL
				
				//do this step
				//fill $error_t if encountered
			: ($step_l=1)
				//do this step
				SORT ARRAY:C229($people; $peopleID)
				$Person_L:=G_PickFromList(->$people; "Pick a person!")
				If ($Person_L<=0)  //fill $error_t if encountered
					$error_t:="Did Not Pick anybody! Still as "+<>CurrentUser_Name
					If (<>CurrentUser_Name#Current user:C182)
						//current user setting is not a design user - should we change back?
						CONFIRM:C162("Do you want to switch back to "+Current user:C182+" or stay as "+<>CurrentUser_Name+" ?"; Current user:C182; <>CurrentUser_Name)
						If (OK=1)
							<>CurrentUser_Name:=Current user:C182
							<>CurrentUser_UID:=utf_GetUserID(<>CurrentUser_Name)
							<>CurrentUser_PID:=utf_GetUserPID(<>CurrentUser_Name)
							$error_t:="Switched back to "+<>CurrentUser_Name
						End if 
					End if 
					
				End if 
				
			: ($step_l=2)
				//do this step
				READ ONLY:C145([Personnel:42])
				QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$peopleID{$Person_L})
				FIRST RECORD:C50([Personnel:42])
				$New4DUID_L:=[Personnel:42]UserID_4D:12
				READ WRITE:C146([Personnel:42])
				If ($New4DUID_L=0)
					$error_t:="Selected user does not have a related 4D User ID !"
				End if 
			: ($step_l=3)
				ARRAY TEXT:C222($Users4d_atxt; 0)
				ARRAY LONGINT:C221($UserIDs4d_aL; 0)
				GET USER LIST:C609($Users4d_atxt; $UserIDs4d_aL)
				C_TEXT:C284($username4d_txt; $pw)
				$username4d_txt:=$Users4d_atxt{Find in array:C230($UserIDs4d_aL; $New4DUID_L)}
				<>CurrentUser_Name:=$username4d_txt
				<>CurrentUser_UID:=$New4DUID_L
				<>CurrentUser_PID:=$peopleID{$Person_L}
				PERS_GetMyInfo
				$pw:=Request:C163("Password for :"+$username4d_txt+" (cancel to not switch 4D user)")
				If (OK=1)
					CHANGE CURRENT USER:C289($username4d_txt; $pw)
					If (OK=0)
						$error_t:="Error switching 4D user!"
					End if 
					
				End if 
				
		End case 
		$step_l:=$step_l+1
	Until ($step_l>$NumSteps_L) | ($error_t#"")
	If ($error_t#"")
		ALERT:C41($error_t)
	End if 
	
End if 