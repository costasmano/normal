//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_DisableMenuShortcuts (area)
	
	// Disables all of the 4D View area's menu commands with keyboard shortcuts so 
	//   the user can't accidentally trigger one.
	
	// Method History:
	//   DB020612 - Created by Dave Batton
	//   DB021219 - Added a few more submitted by Dick Gillett.
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302
End if 

C_LONGINT:C283($1; $area)

$area:=$1

//  // File menu
//PV SET COMMAND STATUS ($area;pv cmd file new;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd file open;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd file save;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd file print document;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd go to full screen;pv value off)  // File: Go To Full Screen

//  // Edit menu
//PV SET COMMAND STATUS ($area;pv cmd edit undo;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit redo;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit repeat;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit cut;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit copy;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit paste;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit find;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit find next;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit replace;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit replace next;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit set name;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit go to;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd edit fill down;pv value off)  // DB021219
//PV SET COMMAND STATUS ($area;pv cmd edit fill right;pv value off)  // DB021219

//  // View menu
//PV SET COMMAND STATUS ($area;pv cmd view menu bar;pv value off)

//  // Insert menu
//PV SET COMMAND STATUS ($area;pv cmd insert cell;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd insert column;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd insert row;pv value off)

//  // Style menu
//PV SET COMMAND STATUS ($area;pv cmd format cells;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd format borders;pv value off)
//PV SET COMMAND STATUS ($area;pv cmd format style sheets;pv value off)

//  // Other
//PV SET COMMAND STATUS ($area;pv cmd calculate now;pv value off)  // DB021219