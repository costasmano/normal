//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/13/07, 15:32:59
	// ----------------------------------------------------
	// Method: MENU_EnableEnterItem
	// Description
	// Enable an Item in the Enter Menu, (menu 2)
	// 
	// Parameters
	// $1 : $Itemname_txt
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/5/10 09:09:36)
	Mods_2010_08
	//  `Fixed problem with District 6 search. added "@" at front and back of the search item.
	// Modified by: costasmanousakis-(Designer)-(1/11/11 16:17:50)
	Mods_2011_01
	//`  Fix for v11 transition
End if 
C_TEXT:C284($1; $Itemname_txt)
C_BOOLEAN:C305($On_b)
$Itemname_txt:=$1

$On_b:=True:C214
C_LONGINT:C283($ItemNum_L)
$ItemNum_L:=Find in array:C230(Menu2Items_atxt; "@"+$Itemname_txt+"@")
If ($ItemNum_L>0)
	If ($On_b)
		ENABLE MENU ITEM:C149(MNU_ENTERMENU_NO_L; $ItemNum_L)
	Else 
		DISABLE MENU ITEM:C150(MNU_ENTERMENU_NO_L; $ItemNum_L)
	End if 
End if 
