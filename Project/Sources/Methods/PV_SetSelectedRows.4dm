//%attributes = {"invisible":true}
If (False:C215)
	
	// Project Method: PV_SetSelectedRows (area; ->longint array)
	
	// Selects the rows specified by the array.
	// If a selection change callback method has been installed for this area, it will
	//   _not_ get run by calling this method.  This method intentionally disables the
	//   callback first.  So you'll need to call the call back method yourself if you
	//   want it to run.
	// The PV_SelectedRowsArray has beπen defined as a generic array that can be
	//   passed to this method each time it's called.
	
	// Method History:
	//   DB021204 - Created by Dave Batton
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:20)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$area;$i;$columns;$rows)
//C_POINTER($2;$arrayPtr)
//C_TEXT($callbackMethod)

//$area:=$1
//$arrayPtr:=$2

//$rows:=Size of array($arrayPtr->)

//If ($rows=0)
//PV_SetSelectedRow ($area;0)
//Else 
//  // Temporarily disable the callback method.
//$callbackMethod:=PV Get on event method ($area;pv on selection changed)
//PV ON EVENT ($area;pv on selection changed;"")

//ARRAY LONGINT($aLeft;$rows)
//ARRAY LONGINT($aTop;$rows)
//ARRAY LONGINT($aRight;$rows)
//ARRAY LONGINT($aBottom;$rows)

//$columns:=PV Get document property ($area;pv column count)

//For ($i;1;$rows)
//$aLeft{$i}:=1
//$aTop{$i}:=$arrayPtr->{$i}
//$aRight{$i}:=$columns
//$aBottom{$i}:=$arrayPtr->{$i}
//End for 

//PV SELECT RANGES LIST ($area;$aLeft;$aTop;$aRight;$aBottom;pv selection set)

//  // Restore the callback method.
//PV ON EVENT ($area;pv on selection changed;$callbackMethod)
//End if 