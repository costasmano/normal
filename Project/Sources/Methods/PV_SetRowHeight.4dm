//%attributes = {"invisible":true}
If (False:C215)
	
	// Project Method: PV_SetRowHeight (area; height)
	
	// A quick way to set the row height.  This applies one height to all of the
	//   currently displayed rows.  4D View doesn't let us set a default height, so we
	//   must set the value after the rows are created.
	
	// Method History:
	//   DB020820 - Created by Dave Batton
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_LONGINT($1;$2;$area;$rowCount;$height)

//$area:=$1
//$height:=$2

//$rowCount:=PV Get document property ($area;pv row count)

//If ($rowCount>0)
//PV SET ROWS HEIGHT ($area;1;$rowCount;$height)
//End if 