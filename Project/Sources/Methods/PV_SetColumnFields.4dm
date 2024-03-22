//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_SetColumnFields (area; ->field1; {...->fieldN})
	
	// A quick way to dynamically link fields to a 4D View area.
	
	// Method History:
	//   DB020814 - Created by Dave Batton
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$area;$masterTableNumber;$columns;$column)
//C_POINTER(${2})

//$area:=$1

//$columns:=Count parameters-1
//$masterTableNumber:=Table($2)

//  // Clear any existing columns first.
//PV CLEAR DYNAMIC COLUMNS ($area;1;PV Get document property ($area;pv column count))

//  // Set the area to display a specific number of columns.
//PV SET DOCUMENT PROPERTY ($area;pv column count;$columns)

//  // Put the table and field numbers in a text array.
//ARRAY INTEGER($tableNumbersArray;$columns)  // Table numbers
//ARRAY INTEGER($fieldNumbersArray;$columns)  // Field numbers
//ARRAY TEXT($methodNamesArray;$columns)  // Callback method names//Command Replaced was o_ARRAY string length was 30

//For ($column;1;$columns)
//$tableNumbersArray{$column}:=Table(${$column+1})
//$fieldNumbersArray{$column}:=Field(${$column+1})
//$methodNamesArray{$column}:=""
//End for 

//  // Pass the table and field numbers to the 4D View area.
//PV ADD DYNAMIC FIELDS ($area;$masterTableNumber;$tableNumbersArray;$fieldNumbersArray;$methodNamesArray)