
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

LB_GetColumnWidths
[LB_QueryTable:147]ColumnWidths_txt:2:=ColumnWidths_txt

REDRAW WINDOW:C456
//End Object Method: SelectListBox.Button