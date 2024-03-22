//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/08/11, 10:35:18
	// ----------------------------------------------------
	// Method: MENU_GetMenuItemByName
	// Description
	// 
	// 
	// Parameters
	// $0 : $MenuItmNo_L
	// $1 : $MenuNum_L
	// $2 : $MenuItm_txt
	// ----------------------------------------------------
	
	Mods_2011_01
	//`MenuNumber fix for v11 trans
End if 
C_LONGINT:C283($0; $MenuItmNo_L; $1; $MenuNum_L)
$MenuNum_L:=$1
C_TEXT:C284($2; $MenuItm_txt)
$MenuItm_txt:=$2
$MenuItmNo_L:=0
C_LONGINT:C283($NumMnuItems_L; $Loop_L)
$NumMnuItems_L:=Count menu items:C405($MenuNum_L)
For ($Loop_L; 1; $NumMnuItems_L)
	If (Get menu item:C422($MenuNum_L; $Loop_L)=$MenuItm_txt)
		$MenuItmNo_L:=$Loop_L
		$Loop_L:=$NumMnuItems_L+1
	End if 
End for 

$0:=$MenuItmNo_L