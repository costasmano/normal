//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/02/09, 01:00:25
	// ----------------------------------------------------
	// Method: WKHR_GetItemNo
	// Description
	// Get the printable item number - allows renumbering of items.
	// 
	// Parameters
	// $0 : $ItemNo_txt
	// $1 : $ItemRef_L
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  //("WKHRMODS2")
End if 
C_LONGINT:C283($1; $ItemRef_L)
C_TEXT:C284($0; $ItemNo_txt)
$ItemRef_L:=$1
$ItemNo_txt:=""
If (Is a list:C621(AllCategoriesNos_HL))
	SELECT LIST ITEMS BY REFERENCE:C630(AllCategoriesNos_HL; $ItemRef_L)
	GET LIST ITEM:C378(AllCategoriesNos_HL; Selected list items:C379(AllCategoriesNos_HL); $ItemRef_L; $itemNo_txt)
End if 
$0:=$ItemNo_txt