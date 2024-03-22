//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_NoBridgeFound
// User name (OS): cjmiller
// Date and time: 04/07/06, 13:21:13
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CM12_5301
End if 
[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7:=PRJ_DEBridgeNo_s
[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5:=""
[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8:=Get_Town_Name(Substring:C12(PRJ_DEBridgeNo_s; 1; 6))
OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; True:C214)
OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; False:C215)
OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Not_editable)

OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Editable)
OBJECT SET VISIBLE:C603(*; "PRJ_BinsButton"; False:C215)
//End PRJ_NoBridgeFound