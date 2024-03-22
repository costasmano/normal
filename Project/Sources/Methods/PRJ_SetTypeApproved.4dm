//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetTypeApproved
// User name (OS): cjmiller
// Date and time: 11/13/07, 15:58:57
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r001 `11/13/07, 15:59:17`Make typ_approved_d enetrable only if structure type has value
	Mods_2007_CJM_v54  //r003 `11/27/07, 12:40:15    `Make sure structrue type actually has something other than spaces in it
End if 

C_TEXT:C284($StructureType_txt)
$StructureType_txt:=Replace string:C233([PRJ_TypeStudy:121]TYP_StructureType_s:4; " "; "")

If ($StructureType_txt="")
	OBJECT SET VISIBLE:C603(*; "CEButton@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CEHelpText"; True:C214)
	OBJECT SET ENABLED:C1123(*; "CEButton@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENTERABLE:C238([PRJ_TypeStudy:121]TYP_Approved_d:10; False:C215)
	OBJECT SET RGB COLORS:C628([PRJ_TypeStudy:121]TYP_Approved_d:10; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_TypeStudy]TYP_Approved_d; <>PRJ_Color_Not_editable)
Else 
	OBJECT SET VISIBLE:C603(*; "CEButton@"; True:C214)
	OBJECT SET ENABLED:C1123(*; "CEButton@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET VISIBLE:C603(*; "CEHelpText"; False:C215)
	If (PRJ_ReturnAccessAllowed)
		OBJECT SET ENTERABLE:C238([PRJ_TypeStudy:121]TYP_Approved_d:10; True:C214)
		OBJECT SET RGB COLORS:C628([PRJ_TypeStudy:121]TYP_Approved_d:10; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_TypeStudy]TYP_Approved_d; <>PRJ_Color_Editable)
	End if 
End if 
//End PRJ_SetTypeApproved