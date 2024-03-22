//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_GetCellTextValue (area; column; row) --> Text
	
	// Returns the text value of the specified cell. Removes the ' character 4D View
	//   puts at the beginning.
	
	// Method History:
	//   DB021107 - Created by Dave Batton
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_TEXT($0;$value)
//C_LONGINT($1;$2;$3;$area;$row;$column)

//$area:=$1
//$column:=$2
//$row:=$3

//$value:=PV Get cell text value ($area;$column;$row)

//If ($value="'@")  // If it starts with a single quote, remove it.
//$value:=Substring($value;2)  // I'm not sure why the single quote is there.  It's not documented in 4D View.
//End if 

//$0:=$value