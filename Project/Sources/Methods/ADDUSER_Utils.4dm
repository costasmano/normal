//%attributes = {"invisible":true}
// Method: ADDUSER_Utils
// Description
//  ` Perform tasks used for dialog [Personnel];"ADDUserDialog". Controls the
//  `Form method and object methods on the form.
// 
// Parameters
// $1 : $Task_txt 
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/10, 22:44:59
	// ----------------------------------------------------
	
	Mods_2010_11
	// Modified by: costasmanousakis-(Designer)-(6/1/11 13:52:08)
	Mods_2011_05
	//  `changed email extension to dot.state.ma.us
	Mods_2011_06  // CJ Miller`06/20/11, 10:15:10      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2/6/15 15:36:59)
	Mods_2015_02
	//  ` under task "NAMECHANGE"
	//  `changed  to $C0:=((Random%(5+1))+1)  from (6+1) : this one could result in  $C0=7
	//  `also added warming of Random by calling it 5 times before using it
	// Modified by: Costas Manousakis-(Designer)-(4/1/15 11:50:24)
	Mods_2015_04
	//  ` warming of Random by calling it 50 times before using it
	// Modified by: Costas Manousakis-(Designer)-(6/22/15 13:00:37)
	Mods_2015_06
	//  `increased the warming of random to 500 times
	// Modified by: Costas Manousakis-(Designer)-(2/3/16 15:45:25)
	Mods_2016_02_bug
	//  `in the call to random add Tickcount for more randomness
	// Modified by: Costas Manousakis-(Designer)-(2021-10-27T00:00:00 17:10:29)
	Mods_2021_10_bug
	//  `added option to pick a user from the inactive users to use as new user :D
	// Modified by: Costas Manousakis-(Designer)-(2021-11-05T00:00:00 17:39:13)
	Mods_2021_11_bug
	//  `added a check if we are re-using the same name as a user that is inactive
	// Modified by: Costas Manousakis-(Designer)-(2021-12-02T00:00:00 11:23:16)
	Mods_2021_12_bug
	//  `After closing dialog, prompt to save the users and groups on server when on client
	// Modified by: manousakisc (5/26/2022)
	Mods_2022_05
	// collect the usernames and passwords created and when closing the form save them to a text file or place them in the pasteboard
	// Modified by: Costas Manousakis-(Designer)-(2022-06-07 21:07:31)
	Mods_2022_06
	//  `use OB is defined() instead of Undefined() 
	// Modified by: Costas Manousakis-(Designer)-(2022-11-23 12:16:35)
	Mods_2022_11
	//  `use method USR_GeneratePassword
End if 
C_TEXT:C284($Task_txt)
$Task_txt:="LAUNCH"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Task_txt:=$1
	
End if 

C_POINTER:C301($InactiveHL_ptr; $inactiveUserID_ptr)
$InactiveHL_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "InactiveUsers")
$inactiveUserID_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "InactiveUserID")

Case of 
	: ($Task_txt="LAUNCH")
		C_LONGINT:C283($w; $h)
		FORM GET PROPERTIES:C674([Personnel:42]; "ADDUserDialog"; $w; $h)
		ut_OpenNewWindow($w; $h; 0; Plain window:K34:13)
		DIALOG:C40([Personnel:42]; "ADDUserDialog")
		If (Application type:C494=4D Remote mode:K5:5)
			CONFIRM:C162("Save users and Groups on server?")
			If (OK=1)
				C_LONGINT:C283($procID_L)
				$procID_L:=Execute on server:C373("UG_SaveUsersAndGroups"; 0)
			End if 
			
		End if 
	: ($Task_txt="FORMMETHOD")
		C_LONGINT:C283($FormEvent_L)
		If (Count parameters:C259>1)
			C_LONGINT:C283($2)
			$FormEvent_L:=$2
		Else 
			$FormEvent_L:=Form event code:C388
		End if 
		
		Case of 
			: ($FormEvent_L=On Load:K2:1)
				ARRAY TEXT:C222($PWUserList; 0)  //Command Replaced was o_ARRAY string length was 40
				ARRAY INTEGER:C220($PWUserIDs; 0)
				GET USER LIST:C609($PWUserList; $PWUserIDs)
				SORT ARRAY:C229($PWUserList; $PWUserIDs)
				INSERT IN ARRAY:C227($PWUserList; 0)
				INSERT IN ARRAY:C227($PWUserIDs; 0)
				$PWUserList{1}:=""
				$PWUserIDs{1}:=0
				C_LONGINT:C283(PWUserHList; ADDUSER_Copy4DFrom_HL; ADDUSER_CopyPersFrom_HL; $i)
				C_LONGINT:C283(ADDUSER_4DUID_L; ADDUSER_CopyFrom_L; ADDUSER_CopyF4Drom_L; ADDUSER_Jcode; ADDUSER_4DGroup_L)
				C_TEXT:C284(ADDUSER_Prefix; ADDUSER_First; ADDUSER_Last; ADDUSER_Middle; ADDUSER_Suffix; ADDUSER_Employer; ADDUSER_Phone; ADDUSER_Email; ADDUSER_CopyUname)
				C_TEXT:C284(ADDUSER_NewUserN_txt; ADDUSER_NewPW_txt; ADDUSER_Division)
				ARRAY TEXT:C222(ADDUSER_CopyGroups_atxt; 0)
				ARRAY TEXT:C222(ADDUSER_4DGroups_atxt; 0)
				ARRAY LONGINT:C221(ADDUSER_4DGrpIDS_aL; 0)
				GET GROUP LIST:C610(ADDUSER_4DGroups_atxt; ADDUSER_4DGrpIDS_aL)
				SORT ARRAY:C229(ADDUSER_4DGroups_atxt; ADDUSER_4DGrpIDS_aL)
				If (Is a list:C621(PWUserHList))
					CLEAR LIST:C377(PWUserHList; *)
				End if 
				PWUserHList:=New list:C375
				If (Is a list:C621(ADDUSER_Copy4DFrom_HL))
					CLEAR LIST:C377(ADDUSER_Copy4DFrom_HL; *)
				End if 
				ADDUSER_Copy4DFrom_HL:=New list:C375
				If (Is a list:C621(ADDUSER_CopyPersFrom_HL))
					CLEAR LIST:C377(ADDUSER_CopyPersFrom_HL; *)
				End if 
				ADDUSER_CopyPersFrom_HL:=New list:C375
				
				If (Is a list:C621($InactiveHL_ptr->))
					CLEAR LIST:C377($InactiveHL_ptr->)
				End if 
				$InactiveHL_ptr->:=New list:C375
				
				For ($i; 1; Size of array:C274($PWUserList))
					APPEND TO LIST:C376(PWUserHList; ($PWUserList{$i}+" <"+String:C10($PWUserIDs{$i})+">"); $PWUserIDs{$i})
					APPEND TO LIST:C376(ADDUSER_Copy4DFrom_HL; ($PWUserList{$i}+" <"+String:C10($PWUserIDs{$i})+">"); $PWUserIDs{$i})
					If (User in group:C338($PWUserList{$i}; "InactiveUsers")) & ($PWUserIDs{$i}<0)
						APPEND TO LIST:C376($InactiveHL_ptr->; ($PWUserList{$i}+" <"+String:C10($PWUserIDs{$i})+">"); $PWUserIDs{$i})
					End if 
				End for 
				ARRAY TEXT:C222($PWUserList; 0)  //Command Replaced was o_ARRAY string length was 40
				ARRAY INTEGER:C220($PWUserIDs; 0)
				ALL RECORDS:C47([Personnel:42])
				ORDER BY:C49([Personnel:42]; [Personnel:42]First Name:3; >; [Personnel:42]Last Name:5; >)
				C_LONGINT:C283($NumPers_L)
				$NumPers_L:=Records in selection:C76([Personnel:42])
				ARRAY TEXT:C222($Fnames_atxt; $NumPers_L)
				ARRAY TEXT:C222($LNames_atxt; $NumPers_L)
				ARRAY INTEGER:C220($PersIDS_aL; $NumPers_L)
				ARRAY LONGINT:C221(ADDUSER_4DUIDs_aL; $NumPers_L)
				SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $Fnames_atxt; [Personnel:42]Last Name:5; $LNames_atxt; [Personnel:42]Person ID:1; $PersIDS_aL; [Personnel:42]UserID_4D:12; ADDUSER_4DUIDs_aL; [Personnel:42]Employer:9; $EmplNames_atxt)
				For ($i; 1; $NumPers_L)
					APPEND TO LIST:C376(ADDUSER_CopyPersFrom_HL; ($Fnames_atxt{$i}+" "+$LNames_atxt{$i}+" - "+$EmplNames_atxt{$i}); $PersIDS_aL{$i})
				End for 
				ARRAY TEXT:C222($Fnames_atxt; 0)
				ARRAY TEXT:C222($LNames_atxt; 0)
				ARRAY INTEGER:C220($PersIDS_aL; 0)
				ARRAY TEXT:C222(aJob; 0)  //Command Replaced was o_ARRAY string length was 80
				LIST TO ARRAY:C288("Jobs"; aJob)
				ARRAY INTEGER:C220(aJobCode; Size of array:C274(aJob))
				For ($i; 1; Size of array:C274(aJob))
					aJobCode{$i}:=$i
				End for 
				aJob:=0
				ADDUSER_4DGroup_L:=0
				ADDUSER_4DUID_L:=0
				
				
			: ($FormEvent_L=On Unload:K2:2)
				CLEAR LIST:C377(PWUserHList; *)
				CLEAR LIST:C377(ADDUSER_Copy4DFrom_HL; *)
				CLEAR LIST:C377(ADDUSER_CopyPersFrom_HL; *)
				ARRAY LONGINT:C221(ADDUSER_4DUIDs_aL; 0)
				ARRAY TEXT:C222(ADDUSER_CopyGroups_atxt; 0)
				
				ADDUSER_4DUID_L:=0
				ADDUSER_CopyFrom_L:=0
				ADDUSER_CopyF4Drom_L:=0
				
				ADDUSER_Prefix:=""
				ADDUSER_First:=""
				ADDUSER_Last:=""
				ADDUSER_Middle:=""
				ADDUSER_Suffix:=""
				ADDUSER_Employer:=""
				ADDUSER_Division:=""
				ADDUSER_Jcode:=0
				ADDUSER_Phone:=""
				ADDUSER_Email:=""
				ADDUSER_CopyUname:=""
				ADDUSER_NewUserN_txt:=""
				ADDUSER_NewPW_txt:=""
				
				//save any created login info to text file
				C_COLLECTION:C1488($users_c)
				C_OBJECT:C1216($useradded_o)
				
				If (OB Is defined:C1231(Form:C1466; "usersadded"))
					
					C_LONGINT:C283($numusers_)
					$users_c:=Form:C1466.usersadded
					If ($users_c.count()>0)
						//build the text
						C_TEXT:C284($namesandPw_txt)
						$namesandPw_txt:="Username"+Char:C90(Tab:K15:37)+"Password"+Char:C90(Carriage return:K15:38)
						For each ($useradded_o; $users_c)
							$namesandPw_txt:=$namesandPw_txt+$useradded_o.name+Char:C90(Tab:K15:37)+$useradded_o.pw+Char:C90(Carriage return:K15:38)
						End for each 
						//ask to save to file
						C_TEXT:C284($savefile)
						$savefile:=Select document:C905(""; ".txt"; "Choose file to save login info into"; File name entry:K24:17)
						
						If (OK=1)
							$savefile:=Document  //get the full file spec
							C_BLOB:C604($blob_x)
							TEXT TO BLOB:C554($namesandPw_txt; $blob_x; UTF8 text without length:K22:17)
							BLOB TO DOCUMENT:C526($savefile; $blob_x)
							SHOW ON DISK:C922($savefile)
						Else 
							SET TEXT TO PASTEBOARD:C523($namesandPw_txt)
							ALERT:C41("Usernames and passwords have been placed in the pasteboard")
						End if 
						
					End if 
					
				End if 
				
		End case 
		
	: ($Task_txt="COPY")
		C_TEXT:C284($uname; $startup; $pw)
		C_LONGINT:C283($ItemRef; $newwin; $nblogin)
		C_DATE:C307($lastlogin)
		ARRAY LONGINT:C221($grparray; 0)
		If (ADDUSER_First#"") & (ADDUSER_Last#"")
			ARRAY TEXT:C222($uNames_atxt; 0)
			ARRAY LONGINT:C221($uNumbers_aL; 0)
			GET USER LIST:C609($uNames_atxt; $uNumbers_aL)
			C_TEXT:C284($olduserName_txt)
			C_LONGINT:C283($ItemRef_L)
			$olduserName_txt:=""
			If (Selected list items:C379($InactiveHL_ptr->)>0)
				//an inactive user has been selected
				GET LIST ITEM:C378($InactiveHL_ptr->; *; $ItemRef_L; $olduserName_txt)
				//strip the 4D ID
				ARRAY LONGINT:C221($match_pos_aL; 0)
				ARRAY LONGINT:C221($match_Len_aL; 0)
				C_TEXT:C284($pat_txt)
				$pat_txt:="(.*)( <-\\d*>)"
				If (Match regex:C1019($pat_txt; $olduserName_txt; 1; $match_pos_aL; $match_Len_aL))
					//the username is the first group
					$olduserName_txt:=Substring:C12($olduserName_txt; $match_pos_aL{1}; $match_Len_aL{1})
					
				End if 
			End if 
			
			If ((Find in array:C230($uNames_atxt; ADDUSER_NewUserN_txt)>0) & (ADDUSER_NewUserN_txt#$olduserName_txt))
				ALERT:C41("4D Username "+ADDUSER_NewUserN_txt+" exists already!")
			Else 
				QUERY:C277([Personnel:42]; [Personnel:42]First Name:3=ADDUSER_First; *)
				QUERY:C277([Personnel:42];  & ; [Personnel:42]Last Name:5=ADDUSER_Last; *)
				QUERY:C277([Personnel:42];  & ; [Personnel:42]Employer:9=ADDUSER_Employer)
				
				If (Records in selection:C76([Personnel:42])>0)
					
					ALERT:C41("Personnel "+ADDUSER_First+" "+ADDUSER_Last+"  at company "+ADDUSER_Employer+" exists already!")
					
				Else 
					QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=ADDUSER_CopyFrom_L)
					ARRAY INTEGER:C220($MyGroups_aL; 0)
					SELECTION TO ARRAY:C260([PERS_GroupMembers:110]GroupID_I:1; $MyGroups_aL)
					If (Not:C34(Is user deleted:C616(ADDUSER_CopyF4Drom_L)))
						GET USER PROPERTIES:C611(ADDUSER_CopyF4Drom_L; $uname; $startup; $pw; $nblogin; $lastlogin; $grparray)
					Else 
						ARRAY LONGINT:C221($grparray; 0)
					End if 
					C_DATE:C307($BlankDate)
					//check if we have selected an inactive user
					If ($inactiveUserID_ptr->#0)
						
						ADDUSER_4DUID_L:=Set user properties:C612(($inactiveUserID_ptr->); ADDUSER_NewUserN_txt; ""; ADDUSER_NewPW_txt; 0; $BlankDate; $grparray)
						ALERT:C41("Renamed User "+$olduserName_txt+" to "+ADDUSER_NewUserN_txt)
						//remove the inactive id from the list - and set list to 0
						DELETE FROM LIST:C624($InactiveHL_ptr->; $inactiveUserID_ptr->; *)
						SELECT LIST ITEMS BY POSITION:C381($InactiveHL_ptr->; 0)
						//now clear the inactive ID
						$inactiveUserID_ptr->:=0
					Else 
						ADDUSER_4DUID_L:=Set user properties:C612((-2); ADDUSER_NewUserN_txt; ""; ADDUSER_NewPW_txt; 0; $BlankDate; $grparray)
						ALERT:C41("Added User "+ADDUSER_NewUserN_txt+" ID :"+String:C10(ADDUSER_4DUID_L))
						
					End if 
					If (Type:C295(Ptr_changes)#Array 2D:K8:24)
						ARRAY POINTER:C280(Ptr_changes; 0; 0)
					End if 
					InitChangeStack(1)
					CREATE RECORD:C68([Personnel:42])
					Inc_Sequence("Personnel"; ->[Personnel:42]Person ID:1)
					[Personnel:42]Active:11:=(ADDUSER_Active=1)
					[Personnel:42]DiveTeam:10:=(ADDUSER_Dive=1)
					[Personnel:42]Division No:7:=ADDUSER_Division
					[Personnel:42]Job Code:8:=ADDUSER_JCode
					[Personnel:42]EmailAddress_s:14:=ADDUSER_Email
					[Personnel:42]Employer:9:=ADDUSER_Employer
					[Personnel:42]Phone_s:13:=ADDUSER_Phone
					[Personnel:42]Prefix:2:=ADDUSER_Prefix
					[Personnel:42]First Name:3:=ADDUSER_First
					[Personnel:42]Middle Name:4:=ADDUSER_Middle
					[Personnel:42]Last Name:5:=ADDUSER_Last
					[Personnel:42]Suffix:6:=ADDUSER_Suffix
					If (ADDUSER_4DUID_L#0)
						[Personnel:42]UserID_4D:12:=ADDUSER_4DUID_L
					Else 
						[Personnel:42]UserID_4D:12:=ADDUSER_CopyF4Drom_L
					End if 
					PushChange(1; ->[Personnel:42]Active:11)
					PushChange(1; ->[Personnel:42]DiveTeam:10)
					PushChange(1; ->[Personnel:42]Division No:7)
					PushChange(1; ->[Personnel:42]Job Code:8)
					PushChange(1; ->[Personnel:42]EmailAddress_s:14)
					PushChange(1; ->[Personnel:42]Employer:9)
					PushChange(1; ->[Personnel:42]Phone_s:13)
					PushChange(1; ->[Personnel:42]Prefix:2)
					PushChange(1; ->[Personnel:42]First Name:3)
					PushChange(1; ->[Personnel:42]Middle Name:4)
					PushChange(1; ->[Personnel:42]Last Name:5)
					PushChange(1; ->[Personnel:42]Suffix:6)
					PushChange(1; ->[Personnel:42]UserID_4D:12)
					LogNewRecord(->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 4; "Personnel")
					FlushGrpChgs(1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 1)
					SAVE RECORD:C53([Personnel:42])
					
					If (Size of array:C274($MyGroups_aL)>0)
						C_LONGINT:C283($loop_L)
						For ($loop_L; 1; Size of array:C274($MyGroups_aL))
							CREATE RECORD:C68([PERS_GroupMembers:110])
							[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
							[PERS_GroupMembers:110]GroupID_I:1:=$MyGroups_aL{$loop_L}
							SAVE RECORD:C53([PERS_GroupMembers:110])
							LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
							UNLOAD RECORD:C212([PERS_GroupMembers:110])
						End for 
						
					End if 
					UNLOAD RECORD:C212([Personnel:42])
					C_OBJECT:C1216($useradded_o)
					C_COLLECTION:C1488($users_c)
					If (Not:C34(OB Is defined:C1231(Form:C1466; "usersadded")))
						$users_c:=New collection:C1472
						$users_c.push(New object:C1471("name"; ADDUSER_NewUserN_txt; "pw"; ADDUSER_NewPW_txt))
						OB SET:C1220(Form:C1466; "usersadded"; $users_c)
					Else 
						$users_c:=Form:C1466.usersadded
						$users_c.push(New object:C1471("name"; ADDUSER_NewUserN_txt; "pw"; ADDUSER_NewPW_txt))
						OB SET:C1220(Form:C1466; "usersadded"; $users_c)
						
					End if 
					
					C_TEXT:C284($Msg_txt)
					$Msg_txt:="Created user "+ADDUSER_First+" "+ADDUSER_Middle+" "+ADDUSER_Last+"! "
					$Msg_txt:=$Msg_txt+"Keep Adding?"
					CONFIRM:C162($Msg_txt; "Add More"; "Done")
					If (Ok=1)
						ADDUSER_Prefix:=""
						ADDUSER_First:=""
						ADDUSER_Last:=""
						ADDUSER_Middle:=""
						ADDUSER_Suffix:=""
						ADDUSER_Phone:=""
						ADDUSER_Email:=""
						ADDUSER_NewUserN_txt:=""
						ADDUSER_NewPW_txt:=""
						ADDUSER_4DUID_L:=0
						SELECT LIST ITEMS BY REFERENCE:C630(PWUserHList; 0)
					Else 
						
						CANCEL:C270
					End if 
					
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Must have a First and Last name at least!!!")
		End if 
		
	: ($Task_txt="NAMECHANGE")
		ADDUSER_First:=f_TrimStr(ADDUSER_First; True:C214; True:C214)
		ADDUSER_Last:=f_TrimStr(ADDUSER_Last; True:C214; True:C214)
		If (ADDUSER_First#"") & (ADDUSER_Last#"")
			ADDUSER_NewUserN_txt:=ADDUSER_First+" "+ADDUSER_Last
			
			ADDUSER_NewPW_txt:=USR_GeneratePassword(New object:C1471("firstname"; ADDUSER_First; "lastname"; ADDUSER_Last))
			
		End if 
	: ($Task_txt="PICKUSERTOCOPY")
		
		POPUP_HL_MENUC(ADDUSER_CopyPersFrom_HL; ->ADDUSER_CopyFrom_L)
		C_LONGINT:C283($key_L)
		$key_L:=Selected list items:C379(ADDUSER_CopyPersFrom_HL)
		If ($key_L>0)
			QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=ADDUSER_CopyFrom_L)
			ADDUSER_CopyF4Drom_L:=[Personnel:42]UserID_4D:12
			If (ADDUSER_CopyF4Drom_L#0)
				SELECT LIST ITEMS BY REFERENCE:C630(ADDUSER_Copy4DFrom_HL; ADDUSER_CopyF4Drom_L)
				ADDUSER_Utils("LOADUGROUPS"; ADDUSER_CopyF4Drom_L)
				
				REDRAW:C174(ADDUSER_Copy4DFrom_HL)
			End if 
			ADDUSER_Jcode:=[Personnel:42]Job Code:8
			ADDUSER_Employer:=[Personnel:42]Employer:9
			ADDUSER_Phone:=[Personnel:42]Phone_s:13
			ADDUSER_Division:=[Personnel:42]Division No:7
			ADDUSER_Dive:=Num:C11([Personnel:42]DiveTeam:10)
			ADDUSER_Active:=Num:C11([Personnel:42]Active:11)
			aJob:=ADDUSER_Jcode
			REDRAW:C174(aJob)
		End if 
		
	: ($Task_txt="LOADUGROUPS")
		C_LONGINT:C283($2; $userID_L)
		$userID_L:=$2
		ARRAY LONGINT:C221($groups_al; 0)
		C_DATE:C307($LastLogin)
		C_TEXT:C284($pw; $stM)
		C_LONGINT:C283($nblogin)
		ARRAY TEXT:C222(ADDUSER_CopyGroups_atxt; 0)
		If ($userID_L#0)
			GET USER PROPERTIES:C611($userID_L; ADDUSER_CopyUname; $pw; $stM; $nblogin; $LastLogin; $groups_al)
		End if 
		ARRAY LONGINT:C221($Groupnos_al; 0)
		ARRAY TEXT:C222($GroupNames_atxt; 0)
		GET GROUP LIST:C610($GroupNames_atxt; $Groupnos_al)
		C_LONGINT:C283($loop_L; $key)
		For ($loop_L; 1; Size of array:C274($groups_al))
			$key:=Find in array:C230($Groupnos_al; $groups_al{$loop_L})
			APPEND TO ARRAY:C911(ADDUSER_CopyGroups_atxt; $GroupNames_atxt{$key})
		End for 
		ADDUSER_CopyGroups_atxt:=1
		
	: ($Task_txt="4DUSERCOPY")
		POPUP_HL_MENUC(ADDUSER_Copy4DFrom_HL; ->ADDUSER_CopyF4Drom_L)
		ADDUSER_Utils("LOADUGROUPS"; ADDUSER_CopyF4Drom_L)
		
	: ($Task_txt="PWUserHListOM")
		POPUP_HL_MENUC(PWUserHList; ->ADDUSER_4DUID_L)
		ADDUSER_Utils("LOADUGROUPS"; ADDUSER_4DUID_L)
		
	: ($Task_txt="MHDEMAIL")
		ADDUSER_Email:=ADDUSER_First+"."+ADDUSER_Last+"@dot.state.ma.us"
	: ($Task_txt="COPYTOCLIPBOARD")
		SET TEXT TO PASTEBOARD:C523(ADDUSER_NewUserN_txt+Char:C90(9)+ADDUSER_NewPW_txt)
		
	: ($Task_txt="COPYNAMEFROMCLIP")
		C_TEXT:C284($Clip_txt)
		ARRAY TEXT:C222($NameParts_atxt; 0)
		$Clip_txt:=Get text from pasteboard:C524
		If ($Clip_txt#"")
			ut_TextToArray($Clip_txt; ->$NameParts_atxt; " ")
			If (Size of array:C274($NameParts_atxt)>1)
				ADDUSER_First:=$NameParts_atxt{1}
				If (Size of array:C274($NameParts_atxt)>2)
					ADDUSER_Middle:=$NameParts_atxt{2}
					ADDUSER_Last:=$NameParts_atxt{3}
				Else 
					ADDUSER_Last:=$NameParts_atxt{2}
					ADDUSER_Middle:=""
				End if 
				ADDUSER_Utils("NAMECHANGE")
			Else 
				ALERT:C41("Only one piece of a name was in the clipboard <"+$Clip_txt+">")
			End if 
			
		End if 
		
End case 