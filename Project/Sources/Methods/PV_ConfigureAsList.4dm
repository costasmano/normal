//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_ConfigureAsList (area)
	
	// When we want to use the 4D View plug-in just to display a  group of
	//   arrays, without all of the menus and other junk, this routine handles
	//   most of the setup.
	
	// Method History:
	//   DB020814 - Created by Dave Batton
	//   DB021025 - Modified by Dave Batton
	//      Now this method tries to hide all of the columns and rows, rather than
	//      setting a default value for all areas.
	//   DB030515 - Modified by Dave Batton
	//      Sets the row background color to white so we get normal OS style
	//      highlighting, rather than black highlighting.
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied 
End if 

C_LONGINT:C283($1; $area; $columnCount; $rowCount)

//$area:=$1

//  // DB021025 - Start out with just one column (so we can see the header).
//$columnCount:=PV Get document property ($area;pv column count)
//If ($columnCount>1)
//PV DELETE COLUMNS ($area;2;$columnCount-1)
//PV SET COLUMN HEADER ($area;1;" ")  // Set the header to a blank string.
//End if 

//  // DB021025 - Start out with no rows.  This doesn't actually work.  I think it's
//  //   a View bug.
//$rowCount:=PV Get document property ($area;pv row count)
//If ($rowCount>0)
//PV DELETE ROWS ($area;1;$rowCount)
//End if 

//  // Intercept any 4D View menu commands so they aren't executed.
//If (<>CurrentUser_Name#"Designer")
//PV_DisableMenuShortcuts ($area)
//End if 

//  // Hide the menu bar, and all of the toolbars.
//PV SET AREA PROPERTY ($area;pv show menu bar;pv value off)
//PV SET AREA PROPERTY ($area;pv show standard toolbar;pv value off)
//PV SET AREA PROPERTY ($area;pv show numbers toolbar;pv value off)
//PV SET AREA PROPERTY ($area;pv show style toolbar;pv value off)
//PV SET AREA PROPERTY ($area;pv show borders toolbar;pv value off)
//PV SET AREA PROPERTY ($area;pv show formula toolbar;pv value off)

//  // Hide the horizontal scrollbar.
//  //PV EXECUTE COMMAND ($area;pv cmd view Hscrollbar )

//  // Hide the splitters.
//PV SET HOR PANE PROPERTY ($area;1;pv pane view splitter cursor;0)
//PV SET VERT PANE PROPERTY ($area;1;pv pane view splitter cursor;0)

//  // Don't allow the user to modify the record directly in the list.
//PV SET AREA PROPERTY ($area;pv input trigger;pv trigger none)

//  // Hide the grid lines.
//PV SET AREA PROPERTY ($area;pv show hor grid;pv value off)
//PV SET AREA PROPERTY ($area;pv show vert grid;pv value off)

//  // Hide the row headers.
//PV SET AREA PROPERTY ($area;pv show row headers;pv value off)

//  // Change from cell selection to full row selection.
//PV SET AREA PROPERTY ($area;pv select mode;pv select multiple rows)
//PV SET AREA PROPERTY ($area;pv current cell highlight;pv value off)

//  // Disable the dialog that asks the user if they want to save changes.
//PV SET AREA PROPERTY ($area;pv saving dialog;pv value off)

//  // DB030515 - Set the background color so we get normal OS style highlighting.
//PV SET STYLE PROPERTY ($area;pv style cells;pv style color back odd;0x00FFFFFF)
//PV SET STYLE PROPERTY ($area;pv style cells;pv style color back even;0x00FFFFFF)