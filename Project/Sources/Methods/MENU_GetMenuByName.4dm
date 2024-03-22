//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/08/11, 08:51:10
	// ----------------------------------------------------
	// Method: Method: MENU_GetMenuByName
	// Description
	// 
	// 
	// Parameters
	// $0 : $MenuNo_L
	// $1 : $MenuName_txt
	// ----------------------------------------------------
	
	Mods_2011_01
	//`MenuNumber fix for v11 trans
End if 
C_TEXT:C284($1; $MenuName_txt; $MenuTitle_txt)
C_LONGINT:C283($0; $MenuNo_L)
$MenuName_txt:=$1
$MenuNo_L:=0
C_LONGINT:C283($numMenus_L; $loop_L)
$numMenus_L:=Count menus:C404
For ($loop_L; 1; $numMenus_L)
	If (Get menu title:C430($loop_L)=$MenuName_txt)
		$MenuNo_L:=$loop_L
		$loop_L:=$numMenus_L+1
	End if 
End for 

$0:=$MenuNo_L