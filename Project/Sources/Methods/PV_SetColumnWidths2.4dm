//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_SetColumnWidths2 (->area; Ptr to array of column widths)
	
	// A quick way to set the column widths.
	
	// Method History:
	//   DB020815 - Created by Dave Batton
	//   DB020918 - Modified by Dave Batton
	//      If a width is not 0, it's unhidden, to undo the hiding we do if it is 0.
	//   DB021113 - Updated so that if the total of all columns is 100, the widths
	//      will be treated as percentages rather than absolute values.  Or, if a
	//      column (only one) is set to -1, then it will be given whatever space is
	//      left.
	// The area must
	//      now be passed as a pointer rather than as a longint.
	//   DB021204 - Now restores the original selection.  Also detects if the user
	//   passed the area directly, rather than a pointer to the area.  This has been
	//   designed to work in an interpreted database.  It shouldn't be a problem
	//   compiled.
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //modified to use a pointer to an array of col widths
End if 

//C_POINTER($areaPtr;$2;$ColWidthsptr)  // $1 intentionally left out here. Handled below.
//C_LONGINT($columns;$width;$totalWidth;$column;$areaWidth)
//C_BOOLEAN($percentages)

//If (Type($1)#Is pointer)
//ALERT("You must pass a pointer to the 4D View area when calling "+Current method name+".")
//TRACE

//Else 
//C_POINTER($1)
//$areaPtr:=$1
//$ColWidthsptr:=$2
//$columns:=Size of array($ColWidthsptr->)

//  // DB021113 - Determine if we should treat the widths as percentages.
//$totalWidth:=0
//For ($column;1;$columns)
//$totalWidth:=$totalWidth+$ColWidthsptr->{$column}
//End for 

//If ($totalWidth=100)
//$percentages:=True
//$totalWidth:=0  // We'll reuse this in the loop.
//Else 
//$percentages:=False
//End if 

//OBJECT GET COORDINATES($areaPtr->;$left;$top;$right;$bottom)
//$areaWidth:=$right-$left-15  // The 15 accounts for the scroll bar.

//  // Get the current selection, so we can restore it. - DB021204
//ARRAY LONGINT(PV_SelectedRowsArray;0)
//PV_GetSelectedRows ($areaPtr->;->PV_SelectedRowsArray)

//  // Set the column headers.
//For ($column;1;$columns)
//Case of 
//: ($percentages)
//If (($column=$columns))  // If it's the last column, make it fit.  Handles rounding errors.
//$width:=$areaWidth-$totalWidth
//Else 
//$width:=$areaWidth*($ColWidthsptr->{$column}/100)
//$totalWidth:=$totalWidth+$width
//End if 
//: ($ColWidthsptr->{$column}=-1)  // This is our variable column in a fixed width world.
//$width:=$areaWidth-$totalWidth-1
//Else 
//$width:=$ColWidthsptr->{$column}
//End case 

//PV SET COLUMNS WIDTH ($areaPtr->;$column;$column;$width)

//  // If the width is 0, then hide the column.  This prevents the user from
//  //   revealing the column by resizing it.
//PV SELECT COLUMNS ($areaPtr->;$column;$column;pv selection set)
//If ($width=0)
//PV EXECUTE COMMAND ($areaPtr->;pv cmd format column hide)
//Else 
//PV EXECUTE COMMAND ($areaPtr->;pv cmd format column show)  // DB020918
//End if 
//End for 

//PV_SetSelectedRows ($areaPtr->;->PV_SelectedRowsArray)
//End if 