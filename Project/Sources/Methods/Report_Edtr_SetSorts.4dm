//%attributes = {"invisible":true}
// ----------------------------------------------------
// Report_Edtr_SetSorts
// User name (OS): cjmiller
// Date and time: 04/19/07, 13:13:42
// ----------------------------------------------------
// Description
// Updates the report area with the sort specified in the Report_SortList_l hierarchical list.
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 

C_LONGINT:C283($styles; $elements; $position; $column; $itemRef; $styles; $icon; $tableNum; $fieldNum)
C_POINTER:C301($fieldPtr)
C_BOOLEAN:C305($enterable)
C_TEXT:C284($itemText)

$elements:=Count list items:C380(Report_SortList_l)

ARRAY LONGINT:C221($aColumns; $elements)
ARRAY LONGINT:C221($aOrders; $elements)

For ($position; 1; $elements)
	GET LIST ITEM:C378(Report_SortList_l; $position; $itemRef; $itemText)
	GET LIST ITEM PROPERTIES:C631(Report_SortList_l; $itemRef; $enterable; $styles; $icon)
	$tableNum:=$itemRef\1000
	$fieldNum:=$itemRef%1000
	
	$fieldPtr:=Field:C253($tableNum; $fieldNum)
	
	$column:=QR Find column:C776(Report_Area_l; $fieldPtr)
	
	$aColumns{$position}:=$column
	If ($icon=Report_AscendingIcon_l)
		$aOrders{$position}:=1
	Else 
		$aOrders{$position}:=-1
	End if 
End for 

QR SET SORTS:C752(Report_Area_l; $aColumns; $aOrders)

//End Report_Edtr_SetSorts