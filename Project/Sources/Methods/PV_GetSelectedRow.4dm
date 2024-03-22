//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_GetSelectedRow (area) --> Number
	
	// Returns the first highlighted row number. Returns 0 if no rows are highlighted.
	
	// Method History:
	//   DB020807 - Created by Dave Batton
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($0;$1;$row;$area)

//$area:=$1

//ARRAY LONGINT(PV_SelectedRowsArray;0)
//PV_GetSelectedRows ($area;->PV_SelectedRowsArray)

//If (Size of array(PV_SelectedRowsArray)>0)
//$row:=PV_SelectedRowsArray{1}
//Else 
//$row:=0
//End if 

//$0:=$row