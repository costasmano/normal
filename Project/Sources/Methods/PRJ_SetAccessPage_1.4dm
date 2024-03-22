//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetAccessPage_1
// User name (OS): cjmiller
// Date and time: 05/16/07, 12:22:55
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/16/07, 12:13:32  `Add code to control access 
End if 
OBJECT SET ENTERABLE:C238(*; "PRJ_NONBridgeNotes2"; False:C215)
OBJECT SET RGB COLORS:C628(*; "PRJ_NONBridgeNotes2"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_NONBridgeNotes2"; <>PRJ_Color_Not_editable)
Case of 
	: (PRJ_MembershipGroup_txt="PRJ_CreateGroup")
		OBJECT SET ENTERABLE:C238(*; "PRJ_NONBridgeNotes2"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "PRJ_NONBridgeNotes2"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_NONBridgeNotes2"; <>PRJ_Color_Editable)
		
	: (PRJ_MembershipGroup_txt="Struct Proj Managers")
		OBJECT SET ENTERABLE:C238(*; "PRJ_NONBridgeNotes2"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "PRJ_NONBridgeNotes2"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_NONBridgeNotes2"; <>PRJ_Color_Editable)
		
	: (PRJ_MembershipGroup_txt="PRJ_Tool")
		OBJECT SET ENTERABLE:C238(*; "PRJ_NONBridgeNotes2"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "PRJ_NONBridgeNotes2"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_NONBridgeNotes2"; <>PRJ_Color_Editable)
	: (PRJ_MembershipGroup_txt=[PRJ_ProjectDetails:115]PRJ_BridgeSectResp_s:44)
		OBJECT SET ENTERABLE:C238(*; "PRJ_NONBridgeNotes2"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "PRJ_NONBridgeNotes2"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_NONBridgeNotes2"; <>PRJ_Color_Editable)
		
End case 
OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_RatingRequest_d:38; False:C215)
OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_RatingRequest_d:38; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_RatingRequest_d; <>PRJ_Color_Not_editable)

//End PRJ_SetAccessPage_1