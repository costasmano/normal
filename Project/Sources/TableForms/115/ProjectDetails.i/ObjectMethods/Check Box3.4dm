// ----------------------------------------------------
// Object Method: PRJ_AllowProjectEntry_l
// User name (OS): cjmiller
// Date and time: 02/03/06, 13:27:51
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5302  //r003 `10/09/07, 11:15:44`Change for chapter 85
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:19:41`0`Fix to use chapter 85 booloean
End if 
If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
	If (PRJ_AllowProjectEntry_l=1)
		OBJECT SET ENTERABLE:C238(PRJ_ConsultantName_txt; True:C214)
		OBJECT SET RGB COLORS:C628(PRJ_ConsultantName_txt; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_ConsultantName_txt; <>PRJ_Color_Editable)
	Else 
		OBJECT SET ENTERABLE:C238(PRJ_ConsultantName_txt; False:C215)
		OBJECT SET RGB COLORS:C628(PRJ_ConsultantName_txt; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_ConsultantName_txt; <>PRJ_Color_Not_editable)
	End if 
Else 
	If (PRJ_AllowProjectEntry_l=1)
		OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; True:C214)
		OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Editable)
		OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; True:C214)
	Else 
		OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; False:C215)
		OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Not_editable)
		OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; False:C215)
	End if 
End if 
//End Object Method: PRJ_AllowProjectEntry_l