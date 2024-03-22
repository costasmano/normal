// ----------------------------------------------------
// Object Method: PRJ_DEProjectFileNo_l
// User name (OS): cjmiller
// Date and time: 01/20/06, 10:33:16
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2  // 01/20/06, 10:33:16
	Mods_PRJSELECTION
	Mods_2007_CJMv2  // 05/30/07 `Add bility to seach by design contract
	// Modified by: costasmanousakis-(Designer)-(6/25/2007 13:44:08)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v54  //r003 `11/27/07, 10:53:36`Make sure file number selection always based upon number of digits entered
End if 

PRJ_ControlSelectFileNumber
OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; True:C214)
OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Editable)
//End Object Method: PRJ_DEProjectFileNo_s
