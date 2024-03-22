//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_SetColumnHeaders2 (area; ptr to array of column headers)
	
	// A quick way to set the column headers.
	
	// Method History:
	//   DB020612 - Created by Dave Batton
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302
End if 

//C_LONGINT($1;$area;$columns;$column)
//C_POINTER($2;$header)

//$area:=$1
//$header:=$2
//$columns:=Size of array($header->)

//  // Set the column headers.
//For ($column;1;$columns)
//PV SET COLUMN HEADER ($area;$column;$header->{$column})
//End for 