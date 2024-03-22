//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_SetColumnFields2 (area; ->table; ...
	//                              ... field1 #; callback1; field2 #; callback2 ...)
	
	// A quick way to dynamically link fields to a 4D View area.  Use
	//   PV_SetColumnFields if no callback methods are needed.  Use this method 
	//   if they are.
	// Because we can't use the ${2} style compiler trick here, we've hardcoded the
	//   compiler directives and limited this to 10 columns.  If you need more, just
	//   modify the compiler directives here and in the compiler directives  method.
	
	// Method History:
	//   DB020819 - Created by Dave Batton
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$area;$masterTableNumber;$columns;$column;$fieldNumber)
//C_POINTER($2)
//C_TEXT(${3};$callbackMethod)

//$area:=$1
//$masterTableNumber:=Table($2)
//$columns:=(Count parameters-2)/2

//  // Clear any existing columns first.
//PV CLEAR DYNAMIC COLUMNS ($area;1;PV Get document property ($area;pv column count))

//  // Set the area to display a specific number of columns.
//PV SET DOCUMENT PROPERTY ($area;pv column count;$columns)

//  // Put the table and field numbers in a text array.
//ARRAY INTEGER($tableNumbersArray;$columns)  // Table numbers
//ARRAY INTEGER($fieldNumbersArray;$columns)  // Field numbers
//ARRAY TEXT($methodNamesArray;$columns)  // Callback method names

//For ($column;1;$columns)
//$fieldNumber:=Num(${($column*2)+1})  // $3, $5, $7...  Either a field number or variable type.
//$callbackMethod:=${($column*2)+2}  // $4, $6, $8...
//If ($callbackMethod="")
//$tableNumbersArray{$column}:=$masterTableNumber
//Else 
//$tableNumbersArray{$column}:=0  // The table number must be 0 to use a callback method.
//End if 
//$fieldNumbersArray{$column}:=$fieldNumber
//$methodNamesArray{$column}:=$callbackMethod
//End for 

//  // Pass the table and field numbers to the 4D View area.
//PV ADD DYNAMIC FIELDS ($area;$masterTableNumber;$tableNumbersArray;$fieldNumbersArray;$methodNamesArray)