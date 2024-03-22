//%attributes = {"invisible":true}
If (False:C215)
	
	// Project Method: PV_SetSelectedRow (area; row)
	
	// Selects the specified row. Includes a work-around that allows you to pass 0
	//   to select no rows.  4D View 6.8 currently doesn't allow you to pass 0 to
	//   the PV SELECT ROWS command. 
	// If a selection change callback method has been installed for this area, it will
	//   _not_ get run by calling this method.  This method intentionally disables the
	//   callback first.  So you'll need to call the call back method yourself if you
	//   want it to run.
	
	// Method History:
	//   DB020815 - Created by Dave Batton
	// Modified by: root-(Designer)-(10/18/2007 12:17:33)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$2;$area;$row;$property)
//C_TEXT($callbackMethod)

//$area:=$1
//$row:=$2

//$callbackMethod:=PV Get on event method ($area;pv on selection changed)
//PV ON EVENT ($area;pv on selection changed;"")

//Case of 
//: (($row=0) | ($row>PV Get document property ($area;pv row count)))
//$property:=PV Get area property ($area;pv select mode)  // So we can restore it properly.
//PV SET AREA PROPERTY ($area;pv select mode;pv select not allowed)
//PV SET AREA PROPERTY ($area;pv select mode;$property)

//Else 
//PV SELECT ROWS ($area;$row;$row;pv selection set)
//End case 

//PV ON EVENT ($area;pv on selection changed;$callbackMethod)
