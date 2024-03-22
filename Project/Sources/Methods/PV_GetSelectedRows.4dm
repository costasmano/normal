//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_GetSelectedRows (area; ->longint array)
	
	// Modifies the passed array so that it contains the row numbers
	//   for the selected (highlighted) rows for the specified area.
	// The PV_SelectedRowsArray has been defined as a generic array that can be
	//   passed to this method each time it's called.
	
	// Method History:
	//   DB020501 - Created by Dave Batton
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$i;$j;$area;$rowCount)
//C_POINTER($2;$arrayPtr)

//$area:=$1
//$arrayPtr:=$2

//ARRAY LONGINT($aLeft;0)
//ARRAY LONGINT($aTop;0)
//ARRAY LONGINT($aRight;0)
//ARRAY LONGINT($aBottom;0)

//PV GET SELECTED RANGES LIST ($area;$aLeft;$aTop;$aRight;$aBottom)

//ARRAY LONGINT($arrayPtr->;0)
//For ($i;1;Size of array($aTop))
//$rowCount:=$aBottom{$i}-$aTop{$i}+1
//INSERT IN ARRAY($arrayPtr->;1;$rowCount)
//For ($j;1;$rowCount)
//$arrayPtr->{$j}:=$aTop{$i}+$j-1
//End for 
//End for 