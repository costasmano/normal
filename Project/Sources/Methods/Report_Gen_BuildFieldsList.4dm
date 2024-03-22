//%attributes = {"invisible":true}
// ----------------------------------------------------
//  Report_Gen_BuildFieldsList (->list)

// User name (OS): cjmiller
// Date and time: 04/19/07, 13:09:04
// ----------------------------------------------------
// Description
// Creates the hierarchical list of the fields from which the user can select the fields to print.
// Assumes the Report_DefaultTableNumber_l variable holds the number of the primary report table.
// The primary table will be listed first (expanded), followed by any related tables (collapsed).

// Parameters:
//   $0: Returns a list reference number
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 


C_LONGINT:C283($0; $primaryTableNumber; $subList; $tableNumber; $fieldNumber; $itemRef; $fieldType; $fieldLength; $i)
C_POINTER:C301($1; $listPtr)
C_TEXT:C284($itemName)
C_BOOLEAN:C305($indexed; $unique; $invisible)

$listPtr:=$1

Report_Gen_ClearList($listPtr)

// First, add the default table, even if it's invisible.
If (Report_DefaultTableNumber_l#0)
	$subList:=New list:C375
	For ($fieldNumber; 1; Get last field number:C255(Report_DefaultTableNumber_l))
		GET FIELD PROPERTIES:C258(Report_DefaultTableNumber_l; $fieldNumber; $fieldType; $fieldLength; $indexed; $unique; $invisible)
		If (Not:C34($invisible))
			$itemName:=Field name:C257(Report_DefaultTableNumber_l; $fieldNumber)
			$itemRef:=(Report_DefaultTableNumber_l*1000)+$fieldNumber
			APPEND TO LIST:C376($subList; $itemName; $itemRef)
			$fieldType:=Type:C295(Field:C253(Report_DefaultTableNumber_l; $fieldNumber)->)
			SET LIST ITEM PROPERTIES:C386($subList; $itemRef; False:C215; Plain:K14:1; 1150+$fieldType)
		End if 
	End for 
	$itemName:="["+Table name:C256(Report_DefaultTableNumber_l)+"]"
	$itemRef:=$tableNumber*1000
	APPEND TO LIST:C376($listPtr->; $itemName; $itemRef; $subList; True:C214)
	SET LIST ITEM PROPERTIES:C386($listPtr->; $itemRef; False:C215; Plain:K14:1; 450)
End if 

ARRAY LONGINT:C221(Report_TableNumbers_al; 0)
Report_Gen_FindRelatedTables(Report_DefaultTableNumber_l; ->Report_TableNumbers_al)

// Then add all of the other visible tables that have a relation to this table.
For ($i; 1; Size of array:C274(Report_TableNumbers_al))
	$tableNumber:=Report_TableNumbers_al{$i}
	GET TABLE PROPERTIES:C687($tableNumber; $invisible)
	If (Not:C34($invisible) & ($tableNumber#Report_DefaultTableNumber_l))
		$subList:=New list:C375
		
		For ($fieldNumber; 1; Get last field number:C255($tableNumber))
			GET FIELD PROPERTIES:C258($tableNumber; $fieldNumber; $fieldType; $fieldLength; $indexed; $unique; $invisible)
			If (Not:C34($invisible))
				$itemName:=Field name:C257($tableNumber; $fieldNumber)
				$itemRef:=($tableNumber*1000)+$fieldNumber
				APPEND TO LIST:C376($subList; $itemName; $itemRef)
				$fieldType:=Type:C295(Field:C253($tableNumber; $fieldNumber)->)
				SET LIST ITEM PROPERTIES:C386($subList; $itemRef; False:C215; Plain:K14:1; 1150+$fieldType)
			End if 
		End for 
		
		$itemName:="["+Table name:C256($tableNumber)+"]"
		$itemRef:=$tableNumber*1000
		APPEND TO LIST:C376($listPtr->; $itemName; $itemRef; $subList; False:C215)
		SET LIST ITEM PROPERTIES:C386($listPtr->; $itemRef; False:C215; Plain:K14:1; 450)
	End if 
End for 

//End Report_Gen_BuildFieldsList