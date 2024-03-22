//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_FixColWidths (->area; {dynamic column number})
	
	// This method dynamically sizes one of the columns so everything fits nicely into
	//   the available space.  If no column is specified, the last column will be
	//   resized.
	// Call this method when the area is first displayed (if needed), and from the
	//   form's On Resize event.
	// Note that unlike most of the PV routines, this one requires a pointer to the
	//   area rather than a longint.  That's so we can get the object's size.
	
	// Method History:
	//   DB020614 - Created by Dave Batton
	//   DB020918 - Modified by Dave Batton
	//      Now we make sure the dynamic column number is not a hidden column.
	//      Changed the minimum column width from 50 to 10.
	//   DB021204 - Detects if the user passed the area directly, rather than a
	//      pointer to the area.  This has been designed to work in an interpreted
	//      database.  It shouldn't be a problem compiled.
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 

//C_POINTER($areaPtr)  // $1 intentionally left out here. Handled below.
//C_LONGINT($2;$dynamicColumn;$columnCount;$left;$top;$right;$bottom;$width;$column;$colWidth)

//If (Type($1)#Is pointer)
//ALERT("You must pass a pointer to the 4D View area when calling "+Current method name+".")
//TRACE

//Else 
//C_POINTER($1)
//$areaPtr:=$1

//$columnCount:=PV Get document property ($areaPtr->;pv column count)
//If (Count parameters>=2)
//$dynamicColumn:=$2  // Resize the specified column.
//Else 
//$dynamicColumn:=$columnCount  // Resize the last column.
//End if 

//  // Get the new usable width of the 4D View area.
//OBJECT GET COORDINATES($areaPtr->;$left;$top;$right;$bottom)
//$width:=$right-$left-15  // The 15 accounts for the scroll bar.

//  // Subtract from the area width the widths of all of the columns we aren't
//  //   going to resize.  This will give us the new size of our dynamic column.
//  // DB020918 - We go from the last column to the first, so we can switch the
//  //   dynamic column if the one we selected is hidden (has a width of 0).
//For ($column;$columnCount;1;-1)
//$colWidth:=PV Get column width ($areaPtr->;$column)
//If (($column=$dynamicColumn) & ($colWidth=0))
//$dynamicColumn:=$dynamicColumn-1
//End if 
//If ($column#$dynamicColumn)
//$width:=$width-$colWidth
//End if 
//End for 

//  // Too small is no good.  Pick a minimum width.
//If ($width<30)  // DB020918 - Changed to 30 pixels.
//$width:=30
//End if 

//  // Whatever's left over is available for the dynamic column.  If the column isn't 
//  //   already this size, resize it.
//If ($width<PV Get column width ($areaPtr->;$dynamicColumn))
//PV SET COLUMNS WIDTH ($areaPtr->;$dynamicColumn;$dynamicColumn;$width)
//PV REDRAW ($areaPtr->)
//End if 
//End if 