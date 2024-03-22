// ----------------------------------------------------
// Object Method: bPrint
// User name (OS): charlesmiller
// Date and time: 03/27/09, 15:14:11
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 15:14:22
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 16:28:59)
	Mods_2013_05
	//  `Added redraw window
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 

//INSP_Check4DWriteChgs 
INSP_SaveInspCommts
Print_Dive_F
REDRAW WINDOW:C456
//End Object Method: bPrint