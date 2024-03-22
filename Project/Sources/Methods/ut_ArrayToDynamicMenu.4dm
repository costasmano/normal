//%attributes = {"invisible":true}
//Method: ut_ArrayToDynamicMenu
//Description
// return a menu reference for use in  dynamic pop up menu 
// Parameters
// $0 : $menuRef (A16)
// $1 : $menuitems_ptr : ptr to array with the menu items 
// $2 : $nenuparameters_ptr : ptr to array with the menu item parameter 
// $3 : $Star_ (A1) : (optional) star option for ADD menu item. to ignore special chars in the menu item
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/01/15, 17:30:06
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09_bug
	C_TEXT:C284(ut_ArrayToDynamicMenu; $0)  // was length of 16
	C_POINTER:C301(ut_ArrayToDynamicMenu; $1)
	C_POINTER:C301(ut_ArrayToDynamicMenu; $2)
	C_TEXT:C284(ut_ArrayToDynamicMenu; $3)  // was length of 1
End if 
//
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 16
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($menu)  // Command Replaced was o_C_STRING length was 16
$menu:=Create menu:C408
C_BOOLEAN:C305($Star_b)
$Star_b:=False:C215
If (Count parameters:C259>2)
	$Star_b:=True:C214
End if 
Case of 
	: (Not:C34((Type:C295($1->)=Text array:K8:16) | (Type:C295($1->)=String array:K8:15)))
	: (Not:C34((Type:C295($2->)=Text array:K8:16) | (Type:C295($2->)=String array:K8:15)))
	: (Size of array:C274($1->)#Size of array:C274($2->))
	: (Size of array:C274($1->)=0)
	Else 
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($1->))
			If ($Star_b)
				APPEND MENU ITEM:C411($menu; $1->{$loop_L}; ""; -1; *)
			Else 
				APPEND MENU ITEM:C411($menu; $1->{$loop_L})
			End if 
			SET MENU ITEM PARAMETER:C1004($menu; -1; $2->{$loop_L})
		End for 
End case 
$0:=$menu
//End ut_ArrayToDynamicMenu
