If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/27/07, 10:15:11
	// ----------------------------------------------------
	// Method: Object Method: AdjustMargins
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 12:40:38`Upgrade from open form window to open window
End if 
//C_REAL($WRUnit_r)
//$WRUnit_r:=WR Get doc property (WRT_Template;wr unit)
//WR SET DOC PROPERTY (WRT_Template;wr unit;2)  //pixels - more precise, no rounding errors
//WRT_GetSetMargins (WRT_Template;"GET")

//C_LONGINT($Width_l;$Height_l;$Win_l;$Pages_l)
//C_BOOLEAN($FixedWidth_b;$FixedHeight_b)
//C_TEXT($Title_txt)
//FORM GET PROPERTIES([Dialogs];"WR_Margins";$Width_l;$Height_l;$Pages_l;$FixedWidth_b;$FixedHeight_b;$Title_txt)
//$Win_l:=ut_OpenNewWindow ($Width_l;$Height_l;0;Plain form window;$Title_txt;"ut_CloseCancel")
//  //$Temp:=Open form window([Dialogs];"WR_Margins")
//DIALOG([Dialogs];"WR_Margins")
//CLOSE WINDOW
//If (OK=1)
//WRT_GetSetMargins (WRT_Template;"SET")
//  //WR SET AREA PROPERTY (WRT_Template;wr modified ;1;"")
//  //WR REDRAW (WRT_Template)
//[Templates]TemplateName:=[Templates]TemplateName  //to force a validate
//End if 
//WR SET DOC PROPERTY (WRT_Template;wr unit;$WRUnit_r)
