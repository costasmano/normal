//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/08/11, 10:29:28
	// ----------------------------------------------------
	// Method: MENU_MenuItemUtil
	// Description
	// Utility method for Menu item commands by name instead of number
	// 
	// Parameters
	// $1 : $Task_txt (ENABLE | DISABLE | DELETE | SETKEY)
	// $2 : $MenuName_txt
	// $3 : $MenuItemName_txt
	
	// ----------------------------------------------------
	
	Mods_2011_01
	//`MenuNumber fix for v11 trans
End if 
C_TEXT:C284($1; $Task_txt; $2; $MenuName_txt; $3; $MenuItemName_txt)
$Task_txt:=$1
$MenuName_txt:=$2
$MenuItemName_txt:=$3
C_LONGINT:C283($MenuNum_L; $MenuItemNo_L; $vinumitems)
$MenuNum_L:=MENU_GetMenuByName($MenuName_txt)
$MenuItemNo_L:=MENU_GetMenuItemByName($MenuNum_L; $MenuItemName_txt)

Case of 
	: ($MenuNum_L=0) | ($MenuItemNo_L=0)
	: ($Task_txt="ENABLE")
		ENABLE MENU ITEM:C149($MenuNum_L; $MenuItemNo_L)
	: ($Task_txt="DISABLE")
		DISABLE MENU ITEM:C150($MenuNum_L; $MenuItemNo_L)
	: ($Task_txt="DELETE")
		DELETE MENU ITEM:C413($MenuNum_L; $MenuItemNo_L)
	: ($Task_txt="SETKEY")
		C_TEXT:C284($4; $keyChar_txt)
		$keyChar_txt:=Substring:C12($4; 1; 1)
		SET MENU ITEM SHORTCUT:C423($MenuNum_L; $MenuItemNo_L; Character code:C91($keyChar_txt))
End case 