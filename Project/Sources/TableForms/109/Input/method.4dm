If (False:C215)
	//Form Method:[PERS_Groups];"Input"
	// Modified by: costasmanousakis-(Designer)-(5/15/2006 16:28:40)
	Mods_2006_CMy3
	// Modified by: costasmanousakis-(Designer)-(9/17/2007 09:13:54)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/10/08 16:49:44)
	Mods_2008_CM_5403
	//Goto the available pers list on load if the Grp name is not blank!
	// Modified by: costasmanousakis-(Designer)-(9/17/10 15:29:07)
	Mods_2010_09
	//  `Enable the Primary and Acting fields. Added buttons to handle that. 
	// Modified by: costasmanousakis-(Designer)-(9/20/10 09:31:32)
	Mods_2010_09
	//  `Added var GRP_NotAllowGrpNmEdit_b to lock changes to the group name
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-8/14/15
	Mods_2015_08_bug
	//  `Fix case where Groupmember id not found in Personnel table
	// Modified by: Costas Manousakis-(Designer)-(5/7/18 10:19:11)
	Mods_2018_05
	//  `Added field [PERS_Groups]PERS_ActingTitle and deleted checkbox "Loging Changes" .
	//  `use object set title to show/clear names of acting/primary
	// Modified by: Costas Manousakis-(Designer)-(2022-03 16:14:26)
	Mods_2022_03
	//  `added ability to have groups as members of groups. the ID of the groups is stored as a negative number
	// Modified by: Costas Manousakis-(Designer)-(2022-12-27 18:37:37)
	Mods_2022_12_bug
	//  `added missing code when duplicating a group
	// Modified by: Costas Manousakis-(Designer)-(2024-03-14 15:53:07)
	Mods_2024_LSS_1
	//  `added missing pushchange on the group name when duplicating a group
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		
		C_LONGINT:C283($Width_L; $Height_L; $WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L)
		FORM GET PROPERTIES:C674([PERS_Groups:109]; "Input"; $Width_L; $Height_L)
		GET WINDOW RECT:C443($WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L)
		
		$WPosRight_L:=$Width_L+$WPosLeft_L
		$WPosBottom_L:=$Height_L+$WPosTop_L
		
		
		SET WINDOW RECT:C444($WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L)
		
		utl_SetSpellandContextMenu
		C_BOOLEAN:C305(GRP_LogChanges_b)
		GRP_LogChanges_b:=True:C214
		If (Is new record:C668([PERS_Groups:109]))
			Inc_Sequence("PersUserGroups"; ->[PERS_Groups:109]PERS_GroupID_I:1)
		End if 
		InitChangeStack(1)
		READ ONLY:C145([Personnel:42])
		ARRAY INTEGER:C220($GRP_AvailPersID_aI; 0)
		ARRAY INTEGER:C220($GRP_GrpMembID_aI; 0)
		ARRAY TEXT:C222($LastName_as; 0)
		ARRAY TEXT:C222($FirstName_as; 0)
		ARRAY TEXT:C222($Employer_as; 0)
		ARRAY TEXT:C222($Division_as; 0)
		ARRAY TEXT:C222($Midn_as; 0)
		ARRAY BOOLEAN:C223($Active_ab; 0)
		ARRAY TEXT:C222($grpNames_atxt; 0)
		ARRAY INTEGER:C220($grpIds_aI; 0)
		C_LONGINT:C283($currID_I)
		$currID_I:=[PERS_Groups:109]PERS_GroupID_I:1
		Begin SQL
			select
			concat(' >',[PERS_Groups].[PERS_GroupName_s] ),
			(-1 * [PERS_Groups].[PERS_GroupID_I])
			from 
			[PERS_Groups]
			where [PERS_Groups].[PERS_GroupID_I] <> :$currID_I
			order by [PERS_Groups].[PERS_GroupName_s]
			into :$grpNames_atxt , :$grpIds_aI ;
		End SQL
		
		C_LONGINT:C283(AllPersonnelList_hL; GroupMemberList_hL)
		If (Is a list:C621(AllPersonnelList_hL))
			CLEAR LIST:C377(AllPersonnelList_hL; *)
		End if 
		If (Is a list:C621(GroupMemberList_hL))
			CLEAR LIST:C377(GroupMemberList_hL; *)
		End if 
		AllPersonnelList_hL:=New list:C375
		GroupMemberList_hL:=New list:C375
		OBJECT SET TITLE:C194(*; "PERS_Acting_txt"; "")
		OBJECT SET TITLE:C194(*; "PERS_Primary_txt"; "")
		QUERY:C277([Personnel:42]; [Personnel:42]Last Name:5#"")
		SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $GRP_AvailPersID_aI; [Personnel:42]Last Name:5; $LastName_as; \
			[Personnel:42]First Name:3; $FirstName_as; [Personnel:42]Middle Name:4; $Midn_as; \
			[Personnel:42]Employer:9; $Employer_as; [Personnel:42]Division No:7; $Division_as; [Personnel:42]Active:11; $Active_ab)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($grpNames_atxt))
			APPEND TO ARRAY:C911($LastName_as; $grpNames_atxt{$loop_L})
			APPEND TO ARRAY:C911($GRP_AvailPersID_aI; $grpIds_aI{$loop_L})
			APPEND TO ARRAY:C911($FirstName_as; "")
			APPEND TO ARRAY:C911($Midn_as; "")
			APPEND TO ARRAY:C911($Employer_as; "")
			APPEND TO ARRAY:C911($Division_as; "")
			APPEND TO ARRAY:C911($Active_ab; False:C215)
		End for 
		
		//check if we are duplicating 
		
		If (GRP_NewUserGrpName#"")
			[PERS_Groups:109]PERS_GroupName_s:2:=GRP_NewUserGrpName
			PushChange(1; ->[PERS_Groups:109]PERS_GroupName_s:2)
			COPY ARRAY:C226(GRP_GrpMembIDs_aI; $GRP_GrpMembID_aI)
		Else 
			QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
			SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $GRP_GrpMembID_aI)
			
		End if 
		
		C_LONGINT:C283($NumMembers; $NumAll; $i; $pos)
		$NumMembers:=Size of array:C274($GRP_GrpMembID_aI)
		$NumAll:=Size of array:C274($GRP_AvailPersID_aI)
		C_TEXT:C284($name)
		For ($i; 1; $NumMembers)
			$pos:=Find in array:C230($GRP_AvailPersID_aI; $GRP_GrpMembID_aI{$i})
			
			If ($pos>0)
				
				If ($GRP_GrpMembID_aI{$i}>0)
					//person
					$name:=$LastName_as{$pos}+", "+$FirstName_as{$pos}+" "+$Midn_as{$pos}+" ("+Substring:C12($Employer_as{$pos}; 1; 12)
					If ($Employer_as{$pos}="Mass@")
						$name:=$name+"-D"+Substring:C12($Division_as{$pos}; 4)
					End if 
					$name:=$name+") - "+f_Boolean2String($Active_ab{$pos}; "AI")
					
				Else 
					//group
					$name:=$LastName_as{$pos}
				End if 
				
			Else 
				$name:="Unknown ID "+String:C10($GRP_GrpMembID_aI{$i})
			End if 
			
			APPEND TO LIST:C376(GroupMemberList_hL; $name; $GRP_GrpMembID_aI{$i})
			If ($GRP_GrpMembID_aI{$i}=[PERS_Groups:109]PERS_Primary:4)
				OBJECT SET TITLE:C194(*; "PERS_Primary_txt"; $name)
			End if 
			If ($GRP_GrpMembID_aI{$i}=[PERS_Groups:109]PERS_Acting:3)
				OBJECT SET TITLE:C194(*; "PERS_Acting_txt"; $name)
			End if 
		End for 
		
		SORT LIST:C391(GroupMemberList_hL)
		
		For ($i; 1; $NumAll)
			$pos:=Find in array:C230($GRP_GrpMembID_aI; $GRP_AvailPersID_aI{$i})
			If ($pos>0)
			Else 
				
				If ($GRP_AvailPersID_aI{$i}>0)
					//person
					$name:=$LastName_as{$i}+", "+$FirstName_as{$i}+" "+$Midn_as{$i}+" ("+Substring:C12($Employer_as{$i}; 1; 12)
					If ($Employer_as{$i}="Mass@")
						$name:=$name+"-D"+Substring:C12($Division_as{$i}; 4)
					End if 
					$name:=$name+") - "+f_Boolean2String($Active_ab{$i}; "AI")
				Else 
					//group
					$name:=$LastName_as{$i}
				End if 
				
				APPEND TO LIST:C376(AllPersonnelList_hL; $name; $GRP_AvailPersID_aI{$i})
			End if 
			
		End for 
		SORT LIST:C391(AllPersonnelList_hL)
		READ WRITE:C146([Personnel:42])
		If ([PERS_Groups:109]PERS_GroupName_s:2#"")
			GOTO OBJECT:C206(AllPersonnelList_hL)
		End if 
		C_BOOLEAN:C305(GRP_NotAllowGrpNmEdit_b)
		If (GRP_NotAllowGrpNmEdit_b)
			OBJECT SET ENABLED:C1123(bDelete; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(*; "GroupName_s"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "GroupName_s"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "GroupName_s"; <>Color_Not_Editable)
		Else 
			
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		CLEAR LIST:C377(GroupMemberList_hL; *)
		CLEAR LIST:C377(AllPersonnelList_hL; *)
End case 