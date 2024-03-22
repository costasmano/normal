//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/03/05, 09:21:38
	// ----------------------------------------------------
	// Method: MENU_ClearMenu
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM19
End if 
C_LONGINT:C283($1; $MenuNo; $NumMenuItems_I; $i)  //Command Replaced was o_C_INTEGER
$MenuNo:=$1
$NumMenuItems_I:=Count menu items:C405($MenuNo)
For ($i; $NumMenuItems_I; 1; -1)
	DELETE MENU ITEM:C413($MenuNo; $i)  //enable transfer
End for 
DISABLE MENU ITEM:C150($MenuNo; 0)