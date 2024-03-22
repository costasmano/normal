//%attributes = {"invisible":true}
//Method: MENU_BuildMenuFromArrays
//Description
// Build a menu from arrays. menu can be used as a dynamic pop up menu
// Parameters
// $0 : $MenuRef_txt
// $1 : $MenuLines_ptr : pointer to text array of menu lines
// $2 : $MenuAttributes_ptr : pointer to text array of attributes for each menu line
// $3 : $BranchSeparator_txt : string used to separate submenus
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/13/17, 11:58:44
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
	C_TEXT:C284(MENU_BuildMenuFromArrays; $0)
	C_POINTER:C301(MENU_BuildMenuFromArrays; $1)
	C_POINTER:C301(MENU_BuildMenuFromArrays; $2)
	C_TEXT:C284(MENU_BuildMenuFromArrays; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(4/5/18 16:28:03)
	Mods_2018_04
	//  `added the "*" param at end of append menu to allow display of special chars like "/" or "("
End if 
//
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_POINTER:C301($MenuLines_ptr; $MenuAttributes_ptr)
$MenuLines_ptr:=$1
$MenuAttributes_ptr:=$2

C_TEXT:C284($BranchSeparator_txt)
$BranchSeparator_txt:=$3

//SORT ARRAY($MenuLines_ptr->;$MenuAttributes_ptr->;>)

C_TEXT:C284($mainmenu_txt)
$mainmenu_txt:=Create menu:C408
ARRAY TEXT:C222($menuTitles_atxt; 0)
ARRAY TEXT:C222($menuRefs_atxt; 0)
C_TEXT:C284($Folder_txt; $Submenu_txt)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($MenuLines_ptr->))
	
	If ($MenuLines_ptr->{$loop_L}#"")  //& (Substring($MenuLines_ptr->{$loop_L};Length($MenuLines_ptr->{$loop_L}))#$BranchSeparator_txt)
		//split into paths
		ARRAY TEXT:C222($itempaths_atxt; 0)
		ut_TextToArray($MenuLines_ptr->{$loop_L}; ->$itempaths_atxt; $BranchSeparator_txt)
		If (Size of array:C274($itempaths_atxt)>1)
			//more than one path in the line - travel the path to find the proper branch
			C_LONGINT:C283($loop2_L; $Index_L)
			C_TEXT:C284($menuRef_txt)
			$menuRef_txt:=$mainmenu_txt  // start from the base
			//check if branches exist
			For ($loop2_L; 1; (Size of array:C274($itempaths_atxt)-1))
				GET MENU ITEMS:C977($menuRef_txt; $menuTitles_atxt; $menuRefs_atxt)
				$Index_L:=Find in array:C230($menuTitles_atxt; $itempaths_atxt{$loop2_L})
				If ($Index_L>0)
					//found it, load next
					$menuRef_txt:=$menuRefs_atxt{$Index_L}
				Else 
					$Submenu_txt:=Create menu:C408
					APPEND MENU ITEM:C411($Submenu_txt; Char:C90(0))
					APPEND MENU ITEM:C411($menuRef_txt; $itempaths_atxt{$loop2_L}; $Submenu_txt; 0; *)
					
					//check if the menu has only one line
					
					RELEASE MENU:C978($Submenu_txt)
					GET MENU ITEMS:C977($menuRef_txt; $menuTitles_atxt; $menuRefs_atxt)
					//check to see if the first line in the menu is a char(0)
					If ($menuTitles_atxt{1}=Char:C90(0))
						DELETE MENU ITEM:C413($menuRef_txt; 1)
						DELETE FROM ARRAY:C228($menuTitles_atxt; 1; 1)
						DELETE FROM ARRAY:C228($menuRefs_atxt; 1; 1)
					End if 
					//this is the new base
					$menuRef_txt:=$menuRefs_atxt{Find in array:C230($menuTitles_atxt; $itempaths_atxt{$loop2_L})}
					//need to add it
				End if 
				
			End for 
			//last element of menu line
			//is it a folder ? (menuline ends in \)
			
			GET MENU ITEMS:C977($menuRef_txt; $menuTitles_atxt; $menuRefs_atxt)  // get the items in the last menu
			
			If (Substring:C12($MenuLines_ptr->{$loop_L}; Length:C16($MenuLines_ptr->{$loop_L}))=$BranchSeparator_txt)
				//menu line ends in a 'folder'
				$Index_L:=Find in array:C230($menuTitles_atxt; $itempaths_atxt{$loop2_L})
				
				If ($Index_L>0)
					//already there - no need to add a new menu
				Else 
					$Submenu_txt:=Create menu:C408
					APPEND MENU ITEM:C411($Submenu_txt; Char:C90(0))
					APPEND MENU ITEM:C411($menuRef_txt; $itempaths_atxt{$loop2_L}; $Submenu_txt; 0; *)
					RELEASE MENU:C978($Submenu_txt)
					GET MENU ITEMS:C977($menuRef_txt; $menuTitles_atxt; $menuRefs_atxt)
					//check to see if the first line in the menu is a char(0)
					If ($menuTitles_atxt{1}=Char:C90(0))
						DELETE MENU ITEM:C413($menuRef_txt; 1)
						DELETE FROM ARRAY:C228($menuTitles_atxt; 1; 1)
						DELETE FROM ARRAY:C228($menuRefs_atxt; 1; 1)
					End if 
					//this is the new base
					$menuRef_txt:=$menuRefs_atxt{Find in array:C230($menuTitles_atxt; $itempaths_atxt{$loop2_L})}
					//DELETE MENU ITEM($menuRef_txt;1)  //delete the first one
					
				End if 
				
			Else 
				//append or replace the first blank line in last menu
				APPEND MENU ITEM:C411($menuRef_txt; $itempaths_atxt{$loop2_L}; ""; 0; *)
				SET MENU ITEM PARAMETER:C1004($menuRef_txt; -1; $MenuAttributes_ptr->{$loop_L})
				//check to see if the first line in the menu is a char(0)
				GET MENU ITEMS:C977($menuRef_txt; $menuTitles_atxt; $menuRefs_atxt)
				If ($menuTitles_atxt{1}=Char:C90(0))
					DELETE MENU ITEM:C413($menuRef_txt; 1)
				End if 
				
			End if 
			
			
		Else 
			If (Substring:C12($MenuLines_ptr->{$loop_L}; Length:C16($MenuLines_ptr->{$loop_L}))=$BranchSeparator_txt)
				//ends in folder - we add a menu
				$Folder_txt:=$itempaths_atxt{1}
				//do we have the folder?
				//this is top so 
				GET MENU ITEMS:C977($mainmenu_txt; $menuTitles_atxt; $menuRefs_atxt)
				If (Find in array:C230($menuTitles_atxt; $Folder_txt)>0)
					//exists - leave it
				Else 
					//add the menu
					$Submenu_txt:=Create menu:C408
					APPEND MENU ITEM:C411($Submenu_txt; Char:C90(0))
					APPEND MENU ITEM:C411($mainmenu_txt; $Folder_txt; $Submenu_txt; 0; *)
					RELEASE MENU:C978($Submenu_txt)
					GET MENU ITEMS:C977($mainmenu_txt; $menuTitles_atxt; $menuRefs_atxt)
					//check to see if the first line in the menu is a char(0)
					If ($menuTitles_atxt{1}=Char:C90(0))
						DELETE MENU ITEM:C413($mainmenu_txt; 1)
						DELETE FROM ARRAY:C228($menuTitles_atxt; 1; 1)
						DELETE FROM ARRAY:C228($menuRefs_atxt; 1; 1)
					End if 
					//this is the new base
					$menuRef_txt:=$menuRefs_atxt{Find in array:C230($menuTitles_atxt; $Folder_txt)}
					//DELETE MENU ITEM($menuRef_txt;1)  //delete the first one
					
				End if 
			Else 
				//a file
				APPEND MENU ITEM:C411($mainmenu_txt; $MenuLines_ptr->{$loop_L}; ""; 0; *)
				SET MENU ITEM PARAMETER:C1004($mainmenu_txt; -1; $MenuAttributes_ptr->{$loop_L})
				//check to see if the first line in the menu is a char(0)
				GET MENU ITEMS:C977($mainmenu_txt; $menuTitles_atxt; $menuRefs_atxt)
				If ($menuTitles_atxt{1}=Char:C90(0))
					DELETE MENU ITEM:C413($menuRef_txt; 1)
				End if 
				
			End if 
		End if 
	End if 
	
End for 

$0:=$mainmenu_txt

//End MENU_BuildMenuFromArrays