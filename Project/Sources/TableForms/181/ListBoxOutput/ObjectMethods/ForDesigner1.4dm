
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/27/11, 16:12:05
//----------------------------------------------------
//Method: Object Method: SelectListBox.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r003
	//Modified by: Charles Miller (12/27/11 16:12:07)
	
End if 
ColumnWidths_txt:=""
ARRAY TEXT:C222(arrColNames; 0)
ARRAY TEXT:C222(arrHeaderNames; 0)
ARRAY POINTER:C280(arrColVars; 0)
ARRAY POINTER:C280(arrHeaderVars; 0)
ARRAY BOOLEAN:C223(arrColsVisible; 0)
ARRAY POINTER:C280(arrStyles; 0)
LISTBOX GET ARRAYS:C832(*; "SelectListBox"; arrColNames; arrHeaderNames; arrColVars; arrHeaderVars; arrColsVisible; arrStyles)
LB_GetColumnWidths
[LB_QueryTable:147]ColumnWidths_txt:2:=ColumnWidths_txt

REDRAW WINDOW:C456
//End Object Method: SelectListBox.Button