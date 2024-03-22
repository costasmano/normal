//%attributes = {"invisible":true}
//Method: INSP_CreateWPPopupMenu
//Description
//
// Parameters
// $0 : $MenuRef_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/15/21, 14:29:45
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_TEXT:C284(INSP_CreateWPPopupMenu; $0)
End if 
//
C_TEXT:C284($0; $menuref_txt)

$menuref_txt:=Create menu:C408
APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; ak cut:K76:53)
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Cut")
APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; ak copy:K76:54)
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Copy")

APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; ak paste:K76:55)
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Paste")

APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; ak select all:K76:57)
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Select all")
APPEND MENU ITEM:C411($menuref_txt; "-")

APPEND MENU ITEM:C411($menuref_txt; "Style")
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; "fontStyle")
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Styles")

//insert menu item
//APPEND MENU ITEM($menuref_txt;ak standard action title)
//SET MENU ITEM PROPERTY($menuref_txt;-1;Associated standard action;ak spell)
//SET MENU ITEM PARAMETER($menuref_txt;-1;"Spell")
APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; "spell/showDialog")
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Show spell dialog")
APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; "spell/suggestion?index=1")
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Show option1")
APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; "spell/suggestion?index=2")
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Show option2")
APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; "spell/suggestion?index=3")
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Show option3")
APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; "spell/suggestion?index=4")
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "Show option4")

APPEND MENU ITEM:C411($menuref_txt; "-")

APPEND MENU ITEM:C411($menuref_txt; ak standard action title:K76:83)
SET MENU ITEM PROPERTY:C973($menuref_txt; -1; Associated standard action name:K28:8; "visibleHorizontalRuler")
SET MENU ITEM PARAMETER:C1004($menuref_txt; -1; "HorizontalRuler")

$0:=$menuref_txt

//End INSP_CreateWPPopupMenu