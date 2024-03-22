//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_SetColumnHeaders (area; col1 header; {col2 header...})
	
	// A quick way to set the column headers.
	
	// Method History:
	//   DB020612 - Created by Dave Batton
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$area;$columns;$column)
//C_TEXT(${2};$header)

//$area:=$1

//$columns:=Count parameters-1

//  // Set the column headers.
//For ($column;1;$columns)
//$header:=${$column+1}
//PV SET COLUMN HEADER ($area;$column;$header)
//End for 