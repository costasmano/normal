//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_OneBridgeFound
// User name (OS): cjmiller
// Date and time: 04/07/06, 13:22:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_PRJSELECTION
End if 
[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7:=""
PRJ_DEBridgeNo_s:=[Bridge MHD NBIS:1]BDEPT:1
PRJ_DEBin_s:=[Bridge MHD NBIS:1]BIN:3
[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=[Bridge MHD NBIS:1]BIN:3
PRJ_CreateIncludedBINRecord([Bridge MHD NBIS:1]BIN:3; [Bridge MHD NBIS:1]BDEPT:1)
PRJ_AdditionalBridges
[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5:=PRJ_DEBridgeNo_s
[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8:=Get_Town_Name(Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; False:C215)
OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Not_editable)
OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; False:C215)
//End PRJ_OneBridgeFound