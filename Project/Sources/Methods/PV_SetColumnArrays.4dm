//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_SetColumnArrays (area; col1 array name; {col2 array...
	
	// A quick way to dynamically link arrays to a 4D View area.
	
	// Method History:
	//   DB020612 - Created by Dave Batton
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$area;$columns;$column)
//C_TEXT(${2};$arrayName)

//$area:=$1

//$columns:=Count parameters-1

//  // Clear any existing columns first.
//PV CLEAR DYNAMIC COLUMNS ($area;1;PV Get document property ($area;pv column count))

//  // Set the area to display a specific number of columns.
//PV SET DOCUMENT PROPERTY ($area;pv column count;$columns)

//  // Put the array names in a text array..
//ARRAY TEXT($arrayOfArrayNames;$columns)
//For ($column;1;$columns)
//$arrayName:=${$column+1}
//$arrayOfArrayNames{$column}:=$arrayName
//End for 

//  // Pass the array names to the 4D View area.
//PV ADD DYNAMIC ARRAYS ($area;$arrayOfArrayNames)