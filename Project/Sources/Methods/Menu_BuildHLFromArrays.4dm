//%attributes = {"invisible":true}
//Method: Menu_BuildHLFromArrays
//Description
// build an HL list from arrays - HL list will be created expanded
// Parameters
// $1 : $HL_L : HL list , nust exist
// $2 : $MenuLines_ptr : pointer to text array of menu lines
// $3 : $MenuAttributes_ptr : pointer to text array of parameters for each menu line
// $4 : $BranchSeparator_txt : string used to separate submenus
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/03/19, 13:23:50
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	
	C_LONGINT:C283(Menu_BuildHLFromArrays; $1)
	C_POINTER:C301(Menu_BuildHLFromArrays; $2)
	C_POINTER:C301(Menu_BuildHLFromArrays; $3)
	C_TEXT:C284(Menu_BuildHLFromArrays; $4)
	
End if 
//
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_TEXT:C284($4)

C_LONGINT:C283($HL_L; $BaseList_L)
$HL_L:=$1

C_POINTER:C301($MenuLines_ptr; $MenuAttributes_ptr)
$MenuLines_ptr:=$2
$MenuAttributes_ptr:=$3

C_TEXT:C284($BranchSeparator_txt; $mainmenu_txt; $menuRef_txt)
$BranchSeparator_txt:=$4

ARRAY TEXT:C222($menuTitles_atxt; 0)
ARRAY TEXT:C222($menuRefs_atxt; 0)
C_TEXT:C284($Folder_txt; $Submenu_txt)
C_LONGINT:C283($loop_L; $currRef_L)
C_LONGINT:C283($loop2_L; $Index_L; $parRef_L)
C_LONGINT:C283($HL_count_L; $ListItem_L; $subL_L; $BaseList_L)

For ($loop_L; 1; Size of array:C274($MenuLines_ptr->))
	If ($MenuLines_ptr->{$loop_L}#"")  //& (Substring($MenuLines_ptr->{$loop_L};Length($MenuLines_ptr->{$loop_L}))#$BranchSeparator_txt)
		//split into paths
		ARRAY TEXT:C222($itempaths_atxt; 0)
		ut_TextToArray($MenuLines_ptr->{$loop_L}; ->$itempaths_atxt; $BranchSeparator_txt)
		If (Size of array:C274($itempaths_atxt)>1)
			//more than one path in the line - travel the path to find the proper branch
			
			// start from the base
			$BaseList_L:=$HL_L
			$HL_count_L:=Count list items:C380($BaseList_L)
			ARRAY TEXT:C222($Basename_atxt; 0)
			ARRAY LONGINT:C221($BaseRef_aL; 0)
			For ($ListItem_L; 1; $HL_count_L)
				GET LIST ITEM:C378($BaseList_L; $ListItem_L; $ItemRef_L; $ItemText_txt; $subL_L; $exp_b)
				$parRef_L:=List item parent:C633($BaseList_L; $ItemRef_L)
				If ($parRef_L=0)
					//no parent - top level
					APPEND TO ARRAY:C911($Basename_atxt; $ItemText_txt)
					APPEND TO ARRAY:C911($BaseRef_aL; $ItemRef_L)
				End if 
			End for 
			
			//check if branches exist
			For ($loop2_L; 1; (Size of array:C274($itempaths_atxt)))
				
				$Index_L:=Find in array:C230($Basename_atxt; $itempaths_atxt{$loop2_L})
				If ($Index_L>0)
					//found it, load next level
					SELECT LIST ITEMS BY REFERENCE:C630($BaseList_L; $BaseRef_aL{$Index_L})
					GET LIST ITEM:C378($BaseList_L; *; $ItemRef_L; $ItemText_txt; $subl_L; $exp_b)
					$currRef_L:=$BaseRef_aL{$Index_L}
					$BaseList_L:=$subl_L
					$HL_count_L:=Count list items:C380($BaseList_L)
					ARRAY TEXT:C222($Basename_atxt; 0)
					ARRAY LONGINT:C221($BaseRef_aL; 0)
					
					For ($ListItem_L; 1; $HL_count_L)
						GET LIST ITEM:C378($BaseList_L; $ListItem_L; $ItemRef_L; $ItemText_txt; $subL_L; $exp_b)
						$parRef_L:=List item parent:C633($BaseList_L; $ItemRef_L)
						If ($parRef_L=$currRef_L)
							//parent ref is the ref of the branch we found 
							APPEND TO ARRAY:C911($Basename_atxt; $ItemText_txt)
							APPEND TO ARRAY:C911($BaseRef_aL; $ItemRef_L)
						End if 
					End for 
					
				Else   //need to add the new branch
					
					$subL_L:=New list:C375
					C_LONGINT:C283($newItemRef_L)
					$newItemRef_L:=Count list items:C380($HL_L; *)+1
					APPEND TO LIST:C376($BaseList_L; $itempaths_atxt{$loop2_L}; $newItemRef_L; $subL_L; True:C214)  //expanded state
					//GET LIST ITEM($BaseList_L;Count list items($BaseList_L);$BaseList_L;$ItemText_txt)
					ARRAY TEXT:C222($Params_atxt; 0)
					ut_TextToArray($MenuAttributes_ptr->{$loop_L}; ->$Params_atxt; ";")
					C_LONGINT:C283($param_L)
					For ($param_L; 1; Size of array:C274($Params_atxt))
						SET LIST ITEM PARAMETER:C986($HL_L; $newItemRef_L; "Param"+String:C10($param_L); $Params_atxt{$param_L})
					End for 
					
					$BaseList_L:=$subL_L
					//branches below are empty
					ARRAY TEXT:C222($Basename_atxt; 0)
					ARRAY LONGINT:C221($BaseRef_aL; 0)
					
				End if 
				
			End for 
			
		Else 
			//single item line
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

//End Menu_BuldHLFromArrays