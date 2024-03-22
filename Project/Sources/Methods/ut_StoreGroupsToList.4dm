//%attributes = {"invisible":true}
//Method: ut_StoreGroupsToList
//Description
//  ` Tool to store 4D groups with theier members into hlist, save to file, compare two hLists
// Parameters
// $1 : $task_txt (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/18/12, 13:44:13
	// ----------------------------------------------------
	//Created : 
	Mods_2012_04
End if 
//
C_BLOB:C604($grouplist_blb)
C_TIME:C306($grplistDoc_t)
C_TEXT:C284($grplistDoc_txt; $task_txt)
C_LONGINT:C283(StoredGroups_HL; $memList_hL; CurrGroups_HL)
C_LONGINT:C283($loop_L)
C_TEXT:C284($grpName_txt; $uname_txt; $start_txt; $pw_txt)
C_LONGINT:C283($grpOwn_L; $nlogin_L)
C_DATE:C307($lastLogin_d)
C_LONGINT:C283($W; $H)
C_LONGINT:C283($loop1_L)
C_LONGINT:C283($locGrpList_HL; $grpID_L; $StoreGrpList_HL; $pos_in_loaded_L; $membList_hL)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$task_txt:=$1
Else 
	$task_txt:=""
End if 

Case of 
	: ($task_txt="")
		ARRAY TEXT:C222($Choises_atxt; 0)
		APPEND TO ARRAY:C911($Choises_atxt; "test")
		APPEND TO ARRAY:C911($Choises_atxt; "Compare Current with a Stored")
		APPEND TO ARRAY:C911($Choises_atxt; "Save Current")
		C_LONGINT:C283($choice_L)
		$choice_L:=G_PickFromList(->$Choises_atxt)
		
		Case of 
			: ($choice_L=1)
				ut_StoreGroupsToList("Test")
				ut_StoreGroupsToList("Clear")
				
			: ($choice_L=2)
				ut_StoreGroupsToList("MakeList"; ->CurrGroups_HL)
				ALERT:C41("Select a file containing group information")
				ut_StoreGroupsToList("LoadFromFile"; ->StoredGroups_HL)
				ut_StoreGroupsToList("Compare")
				ut_StoreGroupsToList("Clear")
			: ($choice_L=3)
				ut_StoreGroupsToList("MakeList"; ->CurrGroups_HL)
				ut_StoreGroupsToList("Display"; ->CurrGroups_HL)
				ut_StoreGroupsToList("SaveToFile"; ->CurrGroups_HL)
		End case 
		
	: ($task_txt="test")
		ALERT:C41("Building list from current groups")
		ut_StoreGroupsToList("MakeList"; ->CurrGroups_HL)
		ut_StoreGroupsToList("Display"; ->CurrGroups_HL)
		ALERT:C41("Saving list from current groups")
		ut_StoreGroupsToList("SaveToFile"; ->CurrGroups_HL)
		ut_CollapseList(->CurrGroups_HL)
		ALERT:C41("Showing collapsed list from current groups")
		ut_StoreGroupsToList("Display"; ->CurrGroups_HL)
		
		ALERT:C41("Loading list from File")
		ut_StoreGroupsToList("LoadFromFile"; ->StoredGroups_HL)
		ut_StoreGroupsToList("Display"; ->StoredGroups_HL)
		ut_CollapseList(->StoredGroups_HL)
		ALERT:C41("Showing collapsed list from File")
		ut_StoreGroupsToList("Display"; ->StoredGroups_HL)
		
		ALERT:C41("Clear")
		ut_StoreGroupsToList("Clear")
		
		
	: ($task_txt="MakeList")
		ARRAY TEXT:C222($groupNames_atxt; 0)
		ARRAY LONGINT:C221($GroupIDs_aL; 0)
		GET GROUP LIST:C610($groupNames_atxt; $GroupIDs_aL)
		SORT ARRAY:C229($groupNames_atxt; $GroupIDs_aL)
		CurrGroups_HL:=New list:C375
		$membList_hL:=New list:C375
		For ($loop_L; 1; Size of array:C274($GroupIDs_aL))
			ARRAY LONGINT:C221($grpMem_aL; 0)
			GET GROUP PROPERTIES:C613($GroupIDs_aL{$loop_L}; $grpName_txt; $grpOwn_L; $grpMem_aL)
			$membList_hL:=New list:C375
			
			For ($loop1_L; 1; Size of array:C274($grpMem_aL))
				
				If (Find in array:C230($GroupIDs_aL; $grpMem_aL{$loop1_L})>0)
					GET GROUP PROPERTIES:C613($grpMem_aL{$loop1_L}; $uname_txt; $grpOwn_L)
					APPEND TO LIST:C376($membList_hL; $uname_txt; ($grpMem_aL{$loop1_L}+200000))
				Else 
					GET USER PROPERTIES:C611($grpMem_aL{$loop1_L}; $uname_txt; $start_txt; $pw_txt; $nlogin_L; $lastLogin_d)
					APPEND TO LIST:C376($membList_hL; $uname_txt; $grpMem_aL{$loop1_L})
				End if 
			End for 
			
			APPEND TO LIST:C376(CurrGroups_HL; $grpName_txt; $GroupIDs_aL{$loop_L}; $membList_hL; True:C214)
		End for 
		//SET LIST PROPERTIES(CurrGroups_HL; _o_Ala Macintosh; _o_Macintosh node) // to be ver
		
	: ($task_txt="Display")
		C_LONGINT:C283(SelectList_Hlist)
		If (Count parameters:C259>1)
			C_POINTER:C301($2)
			SelectList_Hlist:=Copy list:C626($2->)
			FORM GET PROPERTIES:C674([Dialogs:21]; "SelectFromList"; $w; $H)
			CENTER_WINDOW($W; $H; Regular window:K27:1)
			DIALOG:C40([Dialogs:21]; "SelectFromList")
			CLOSE WINDOW:C154
			CLEAR LIST:C377(SelectList_Hlist; *)
		End if 
		
		
	: ($task_txt="SaveToFile")
		
		If (Count parameters:C259>1)
			C_POINTER:C301($2)
			If (Is a list:C621($2->))
				LIST TO BLOB:C556($2->; $grouplist_blb)
				$grplistDoc_t:=Create document:C266("")
				If (OK=1)
					$grplistDoc_txt:=Document
					CLOSE DOCUMENT:C267($grplistDoc_t)
					BLOB TO DOCUMENT:C526($grplistDoc_txt; $grouplist_blb)
					SET BLOB SIZE:C606($grouplist_blb; 0)
				End if 
			End if 
			
		End if 
		
	: ($task_txt="LoadFromFile")
		
		If (Count parameters:C259>1)
			C_POINTER:C301($2)
			$grplistDoc_t:=Open document:C264("")
			
			If (OK=1)
				$grplistDoc_txt:=Document
				CLOSE DOCUMENT:C267($grplistDoc_t)
				DOCUMENT TO BLOB:C525($grplistDoc_txt; $grouplist_blb)
				$2->:=BLOB to list:C557($grouplist_blb)
				SET BLOB SIZE:C606($grouplist_blb; 0)
			End if 
			
		End if 
		
		
	: ($task_txt="Compare")
		//compares the StoredGroups_HL loaded from a file with the CurrGroups_HL
		
		Case of 
			: (Not:C34(Is a list:C621(StoredGroups_HL)))
				ALERT:C41("List StoredGroups_HL is not defined")
			: (Not:C34(Is a list:C621(CurrGroups_HL)))
				ALERT:C41("List CurrGroups_HL is not defined")
			Else 
				//collapse both lists
				C_TEXT:C284($message_txt; $msgpart_txt)
				$message_txt:=""
				$msgpart_txt:=""
				ut_CollapseList(->CurrGroups_HL)
				ut_StoreGroupsToList("Display"; ->CurrGroups_HL)
				ut_CollapseList(->StoredGroups_HL)
				ut_StoreGroupsToList("Display"; ->StoredGroups_HL)
				
				For ($loop_L; 1; Count list items:C380(CurrGroups_HL))
					GET LIST ITEM:C378(CurrGroups_HL; $loop_L; $grpID_L; $grpName_txt; $locGrpList_HL; $expanded_b)
					//SELECT LIST ITEMS BY REFERENCE(StoredGroups_HL;$grpID_L)
					$pos_in_loaded_L:=List item position:C629(StoredGroups_HL; $grpID_L)
					If ($pos_in_loaded_L>0)
						GET LIST ITEM:C378(StoredGroups_HL; $pos_in_loaded_L; $grpID_L; $grpName_txt; $StoreGrpList_HL; $expanded_b)
						//now compare member list both ways
						C_LONGINT:C283($memID_L)
						C_TEXT:C284($memName_txt)
						For ($loop1_L; 1; Count list items:C380($locGrpList_HL))
							GET LIST ITEM:C378($locGrpList_HL; $loop1_L; $memID_L; $memName_txt)
							If (Find in list:C952($StoreGrpList_HL; $memName_txt; 0)>0)
							Else 
								$msgpart_txt:="Current Member "+$memName_txt+" missing from group from file "+$grpName_txt
								$message_txt:=$message_txt+$msgpart_txt+Char:C90(13)
								//ALERT($msgpart_txt)
							End if 
							
						End for 
						
						For ($loop1_L; 1; Count list items:C380($StoreGrpList_HL))
							
							GET LIST ITEM:C378($StoreGrpList_HL; $loop1_L; $memID_L; $memName_txt)
							If (Find in list:C952($locGrpList_HL; $memName_txt; 0)>0)
							Else 
								$msgpart_txt:="Member from file "+$memName_txt+" missing from Current group "+$grpName_txt
								$message_txt:=$message_txt+$msgpart_txt+Char:C90(13)
								//ALERT($msgpart_txt)
							End if 
							
						End for 
						
					Else 
						//Group not found!
						$msgpart_txt:="Current Group "+$grpName_txt+" not found in groups from file!"
						$message_txt:=$message_txt+$msgpart_txt+Char:C90(13)
						//ALERT($msgpart_txt)
					End if 
					
				End for 
				
				If ($message_txt#"")
					SET TEXT TO PASTEBOARD:C523($message_txt)
					$message_txt:="Text below has been copied to the pasteboard"+Char:C90(13)+$message_txt
					ut_BigAlert($message_txt)
					
				Else 
					ALERT:C41("No differences!")
				End if 
				
		End case 
		
	: ($task_txt="clear")
		
		CLEAR LIST:C377(StoredGroups_HL; *)
		CLEAR LIST:C377(CurrGroups_HL; *)
End case 

//End ut_StoreGroupsToList