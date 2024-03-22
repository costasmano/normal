//%attributes = {"invisible":true}
// ----------------------------------------------------
// Report_Gen_FindRelatedTables
// User name (OS): cjmiller
// Date and time: 04/19/07, 13:07:24
// ----------------------------------------------------
// Description
//   ` This routine will build an array of table pointers to
//   all tables that have some relation to the table passed.

// Parameters:
//   $1: The primary table number
//   $2: Pointer to an array of pointers


//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 

C_LONGINT:C283($1; $primaryTableNumber; $tableNumber; $fieldNumber; $oneTable; $oneField; $element)
C_POINTER:C301($2; $aTableNos)

$primaryTableNumber:=$1
$aTableNos:=$2


If ($primaryTableNumber>0)
	// For ($tableNumber;1;Count tables)
	
	$tableNumber:=$primaryTableNumber
	For ($fieldNumber; 1; Get last field number:C255($tableNumber))
		GET RELATION PROPERTIES:C686($tableNumber; $fieldNumber; $oneTable; $oneField)
		
		If ($oneTable#0)
			$element:=Size of array:C274($aTableNos->)+1
			INSERT IN ARRAY:C227($aTableNos->; $element)
			$aTableNos->{$element}:=$oneTable
		End if 
	End for 
	// End for 
End if 
//End Report_Gen_FindRelatedTables