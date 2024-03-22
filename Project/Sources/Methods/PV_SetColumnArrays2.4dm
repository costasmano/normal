//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_SetColumnArrays2 (area; Ptr to Array of array names)
	
	// A quick way to dynamically link arrays to a 4D View area.
	
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302
End if 

//C_LONGINT($1;$area;$columns)
//C_POINTER($2;$arrayNames)

//$area:=$1
//$arrayNames:=$2
//  // Clear any existing columns first.
//PV CLEAR DYNAMIC COLUMNS ($area;1;PV Get document property ($area;pv column count))
//$columns:=Size of array($arrayNames->)
//  // Set the area to display a specific number of columns.
//PV SET DOCUMENT PROPERTY ($area;pv column count;$columns)

//  // Pass the array names to the 4D View area.
//PV ADD DYNAMIC ARRAYS ($area;$arrayNames->)