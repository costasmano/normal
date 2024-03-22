//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetEntryCheckBoxes
// User name (OS): cjmiller
// Date and time: 04/27/06, 13:09:33
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5303  //r004`Select by consultant changes
End if 
PRJ_AllowBinEntry_l:=0
PRJ_AllowBridgeEntry_l:=0
PRJ_AllowProjectEntry_l:=0

If (PRJ_DEBridgeNo_s="")
	OBJECT SET VISIBLE:C603(PRJ_AllowBridgeEntry_l; False:C215)
	OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; True:C214)
	OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Editable)
	OBJECT SET VISIBLE:C603(*; "PRJ_BridgeButton"; True:C214)
Else 
	OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_AllowBridgeEntry_l; True:C214)
	OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Not_editable)
	OBJECT SET VISIBLE:C603(*; "PRJ_BridgeButton"; False:C215)
End if 
If (Size of array:C274(PRJ_SelectedBins_as)>0) | ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")
	OBJECT SET VISIBLE:C603(*; "AllowBinEntry@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "SelPrimaryBin@"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "AllowBinEntry@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "SelPrimaryBin@"; False:C215)
	OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Not_editable)
End if 

If (PRJ_DEProjectFileNo_l=0)
	OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; False:C215)
	OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; True:C214)
	OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Editable)
	OBJECT SET VISIBLE:C603(*; "PRJ_ProjectFileButton"; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_RemovePF_l; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_SelectConsultant_l; False:C215)
Else 
	OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; True:C214)
	OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Not_editable)
	OBJECT SET VISIBLE:C603(*; "PRJ_ProjectFileButton"; False:C215)
End if 
//End PRJ_SetEntryCheckBoxes