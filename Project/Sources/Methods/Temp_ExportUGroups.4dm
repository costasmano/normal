//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/07, 09:57:28
	// ----------------------------------------------------
	// Method: Temp_ExportUGroups
	// Description
	// 
	// 
	// Parameters
	// $1  : $MethodPath
	//
	// Executes methods
	//ut_SaveUsersAndGroups replaced with UG_SaveUsersAndGroups which is now part of component
	
	// ----------------------------------------------------
	Mods_2009_03  //CJM  r001   `03/06/09, 14:25:28`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(3/26/09 16:21:12)
	Mods_2009_03
	//  `Added declaration of some local text vars; Added method option "EXPORTTOTABFILE"
	// Modified by: costasmanousakis-(Designer)-(7/20/10 19:08:22)
	Mods_2010_07
	//  `Additions in the exporting of the users and groups to a text file;
	//  `Additon of loading users and groups from a 4DUG type file
	//  `Also added call to execute on server method ut_SaveUsersAndGroups:
	Mods_2011_07  // CJ Miller`06/14/11, 10:27:57      ` Type all local variables for v11
	//Ugrade to v11 `ut_SaveUsersAndGroups replaced with UG_SaveUsersAndGroups which is now part of component
	//Modified by: Charles Miller (7/28/11 16:32:06)
End if 
If (((Current user:C182="Designer") | (Current user:C182="Administrator")))
	
	C_TEXT:C284($1; $MethodPath; $vsGrname)
	If (Count parameters:C259>0)
		$MethodPath:=$1
	Else 
		$MethodPath:=""
	End if 
	C_LONGINT:C283($vlNUsers; $vlNGroups; $vlNmemberships; $vlNmembers; $i; $j; $k; $numUsers)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284($vsUname; $vsStartup; $vsPwd)
	C_LONGINT:C283(User_Group_list; $vlUsersublist; $vlnbLogin)
	C_LONGINT:C283($tempWindow; $numSubs; $TempSubList; $vsGrowner)
	C_BOOLEAN:C305(USGRP_UserListActive_b)
	C_BOOLEAN:C305(UGROUPSDONE_B)
	C_TEXT:C284(UGROUPSNEXTSTEP_txt)
	C_DATE:C307($vdLastlogin)
	//Export user list
	Case of 
		: ($MethodPath="")
			UGROUPSNEXTSTEP_txt:=""
			UGROUPSDONE_B:=False:C215
			Temp_ExportUGroups("LOAD")
			Temp_ExportUGroups("SHOWUSERS")
			Repeat 
				Case of 
					: (UGROUPSNEXTSTEP_txt="RELOAD")
						Temp_ExportUGroups("")
					: (UGROUPSNEXTSTEP_txt="SHOWGROUPS")
						Temp_ExportUGroups("SHOWGROUPS")
					: (UGROUPSNEXTSTEP_txt="SHOWUSERS")
						Temp_ExportUGroups("SHOWUSERS")
				End case 
				
			Until (UGROUPSDONE_B)
			Temp_ExportUGroups("CLEAR")
			
			
		: ($MethodPath="LOAD")
			//LOAD arrays
			SHORT_MESSAGE("Getting User data....")
			SET CURSOR:C469(128)
			ARRAY TEXT:C222(asUNames; 0)  //Command Replaced was o_ARRAY string length was 132
			ARRAY TEXT:C222(asGrNames; 0)  //Command Replaced was o_ARRAY string length was 80
			ARRAY LONGINT:C221(alUIDs; 0)
			ARRAY LONGINT:C221(alGrIDs; 0)
			
			GET USER LIST:C609(asUNames; alUIDs)
			SORT ARRAY:C229(asUNames; alUIDs; >)
			GET GROUP LIST:C610(asGrNames; alGRIDs)
			SORT ARRAY:C229(asGrNames; alGRIDs; >)
			$vlNUsers:=Size of array:C274(asUNames)
			$vlNGroups:=Size of array:C274(asGrNames)
			ARRAY LONGINT:C221(alMembers; $vlNGroups; 0)
			For ($i; 1; $vlNGroups)
				GET GROUP PROPERTIES:C613(alGrIDs{$i}; $vsGrname; $vsGrowner; alMembers{$i})
			End for 
			SET CURSOR:C469(0)
			CLOSE WINDOW:C154
		: ($MethodPath="SHOWUSERS")
			//Build User list
			SHORT_MESSAGE("Preparing user list data....")
			SET CURSOR:C469(128)
			$vlNUsers:=Size of array:C274(asUNames)
			C_LONGINT:C283(User_Group_list; $vlUsersublist)
			If (Is a list:C621(User_Group_list))
				CLEAR LIST:C377(User_Group_list; *)
			End if 
			User_Group_list:=New list:C375
			For ($i; 1; $vlNUsers)
				If (Not:C34(Is user deleted:C616(alUIDs{$i})))
					ARRAY LONGINT:C221($alPartof; 0)
					GET USER PROPERTIES:C611(alUIDs{$i}; $vsUname; $vsStartup; $vsPwd; $vlnbLogin; $vdLastlogin; $alPartof)
					asUNames{$i}:=asUNames{$i}+" - "+String:C10($vdLastlogin)
					$vlNmemberships:=Size of array:C274($alPartof)
					If ($vlNmemberships>0)
						$vlUsersublist:=New list:C375
						For ($j; 1; $vlNmemberships)
							G_Add_to_PList($alPartof{$j}; $vlUsersublist)
						End for 
						APPEND TO LIST:C376(User_Group_list; asUNames{$i}; alUIDs{$i}; $vlUsersublist; False:C215)
					Else 
						APPEND TO LIST:C376(User_Group_list; asUNames{$i}; alUIDs{$i})
					End if   //if memberships>0
					
				End if   //if user deleted
				
			End for 
			SET CURSOR:C469(0)
			CLOSE WINDOW:C154
			USGRP_UserListActive_b:=True:C214
			
			C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
			C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
			C_TEXT:C284($Title_txt)
			FORM GET PROPERTIES:C674([Dialogs:21]; "User_group_list"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
			//$tempWindow:=Open form window([Dialogs];"User_group_list")
			DIALOG:C40([Dialogs:21]; "User_group_list")
			CLOSE WINDOW:C154($Win_l)
			CLEAR LIST:C377(User_Group_list; *)
			
		: ($MethodPath="SHOWGROUPS")
			//build group List
			SHORT_MESSAGE("Preparing group list data....")
			SET CURSOR:C469(128)
			$vlNGroups:=Size of array:C274(asGrNames)
			If (Is a list:C621(User_Group_list))
				CLEAR LIST:C377(User_Group_list; *)
			End if 
			User_Group_list:=New list:C375
			
			For ($i; 1; $vlNgroups)
				$numSubs:=Size of array:C274(alMembers{$i})
				ARRAY LONGINT:C221(alGroupUserIDs; 0)
				ut_addGroupMembers(alGRIDs{$i})
				$numUsers:=Size of array:C274(alGroupUserIDs)
				If ($numUsers>0)
					$TempSubList:=New list:C375
					For ($j; 1; $numUsers)
						$k:=Find in array:C230(alUIDs; alGroupUserIDs{$j})
						APPEND TO LIST:C376($TempSubList; asUNames{$k}; alUIDs{$k})
					End for 
					SORT LIST:C391($TempSubList)
					C_LONGINT:C283($NumListItems; $loop_L; $prv_L; $currItmRef_L; $prevItmRef_L)
					C_TEXT:C284($CurrName_txt; $PrevName_txt)
					$NumListItems:=Count list items:C380($TempSubList; *)
					For ($loop_L; $NumListItems; 2; -1)
						$prv_L:=$loop_L-1
						GET LIST ITEM:C378($TempSubList; $loop_L; $currItmRef_L; $CurrName_txt)
						SELECT LIST ITEMS BY POSITION:C381($TempSubList; $loop_L)
						GET LIST ITEM:C378($TempSubList; $prv_L; $prevItmRef_L; $PrevName_txt)
						If ($CurrName_txt=$PrevName_txt)
							DELETE FROM LIST:C624($TempSubList; *)
						End if 
						
					End for 
					
					APPEND TO LIST:C376(User_Group_list; asGrNames{$i}; alGRIDs{$i}; $TempSubList; False:C215)
				Else 
					APPEND TO LIST:C376(User_Group_list; asGrNames{$i}; alGRIDs{$i})
				End if 
			End for 
			SET CURSOR:C469(0)
			CLOSE WINDOW:C154
			USGRP_UserListActive_b:=False:C215
			
			C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
			C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
			C_TEXT:C284($Title_txt)
			FORM GET PROPERTIES:C674([Dialogs:21]; "User_group_list"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
			//$tempWindow:=Open form window([Dialogs];"User_group_list")
			DIALOG:C40([Dialogs:21]; "User_group_list")
			CLOSE WINDOW:C154($Win_l)
			CLEAR LIST:C377(User_Group_list; *)
			
		: ($MethodPath="EXPORTTOTABFILE")
			C_TIME:C306($fileExport_t)
			$fileExport_t:=Create document:C266(""; "TEXT")
			If (OK=1)
				SHORT_MESSAGE("Exporting to file user list data....")
				C_TEXT:C284($FileSpec_txt; $LineExport_txt)
				$FileSpec_txt:=Document
				$vlNUsers:=Size of array:C274(asUNames)
				For ($i; 1; $vlNUsers)
					If (Not:C34(Is user deleted:C616(alUIDs{$i})))
						ARRAY LONGINT:C221($alPartof; 0)
						GET USER PROPERTIES:C611(alUIDs{$i}; $vsUname; $vsStartup; $vsPwd; $vlnbLogin; $vdLastlogin; $alPartof)
						$LineExport_txt:=asUNames{$i}+Char:C90(9)+String:C10($vdLastlogin)+Char:C90(9)+String:C10(alUIDs{$i})
						$vlNmemberships:=Size of array:C274($alPartof)
						If ($vlNmemberships>0)
							For ($j; 1; $vlNmemberships)
								$K:=Find in array:C230(alGRIDs; $alPartof{$j})
								$LineExport_txt:=$LineExport_txt+Char:C90(9)+asGrNames{$k}
							End for 
							
						End if   //if memberships>0
						SEND PACKET:C103($fileExport_t; $LineExport_txt+Char:C90(13))
					End if   //if user deleted
					
				End for 
				C_LONGINT:C283($loop_L; $GrOwner_L)
				For ($loop_L; 1; Size of array:C274(asGrNames))
					$LineExport_txt:=asGrNames{$loop_L}+Char:C90(9)+""+Char:C90(9)+String:C10(alGrIDs{$loop_L})
					ARRAY LONGINT:C221($alPartof; 0)
					GET GROUP PROPERTIES:C613(alGrIDs{$loop_L}; $vsUname; $GrOwner_L; $alPartof)
					C_LONGINT:C283($loop2_L)
					For ($loop2_L; 1; Size of array:C274($alPartof))
						If (Abs:C99($alPartof{$loop2_L})<=15000)
							//$K:=Find in array(alUIDs;$alPartof{$loop2_L})
							//user
							//$LineExport_txt:=$LineExport_txt+Char(9)+asUNames{$k}
						Else 
							$K:=Find in array:C230(alGRIDs; $alPartof{$loop2_L})
							$LineExport_txt:=$LineExport_txt+Char:C90(9)+asGrNames{$k}
							//group
						End if 
						
					End for 
					
					SEND PACKET:C103($fileExport_t; $LineExport_txt+Char:C90(13))
				End for 
				
				CLOSE WINDOW:C154
				CLOSE DOCUMENT:C267($fileExport_t)
				//_ O _SET DOCUMENT TYPE($FileSpec_txt;"TEXT")
				//_ O _SET DOCUMENT CREATOR($FileSpec_txt;"????")
			End if 
			
		: ($MethodPath="CLEAR")
			//clear arrays
			ARRAY TEXT:C222(asUNames; 0)  //Command Replaced was o_ARRAY string length was 132
			ARRAY TEXT:C222(asGrNames; 0)  //Command Replaced was o_ARRAY string length was 80
			ARRAY LONGINT:C221(alUIDs; 0)
			ARRAY LONGINT:C221(alGrIDs; 0)
			ARRAY LONGINT:C221(alMembers; 0; 0)
			
		: ($MethodPath="LOADFROMFILE")
			C_TIME:C306($infile)
			$infile:=Open document:C264(""; "4DUG")
			If (OK=1)
				C_TEXT:C284($doc_txt)
				$doc_txt:=Document
				CLOSE DOCUMENT:C267($infile)
				C_BLOB:C604($user_blb)
				DOCUMENT TO BLOB:C525($doc_txt; $user_blb)
				
				BLOB TO USERS:C850($user_blb)
				SET BLOB SIZE:C606($user_blb; 0)
				ALERT:C41("Now you have to Click the RELOAD button")
			End if 
		: ($MethodPath="SAVEONSERVER")
			C_LONGINT:C283($pid_L)
			
			$pid_L:=Execute on server:C373("UG_SaveUsersAndGroups"; <>LStackSize; "SaveUsersAndGroups")
			If ($pid_L=0)
				ALERT:C41("Error Executing method ut_SaveUsersAndGroups on server!")
			Else 
				ALERT:C41("Executed method to save User and Groups")
			End if 
			
	End case 
	
End if 