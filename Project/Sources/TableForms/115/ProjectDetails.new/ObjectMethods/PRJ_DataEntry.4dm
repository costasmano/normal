// ----------------------------------------------------
// Object Method: PRJ_DEDBridgeNo_s
// User name (OS): cjmiller
// Date and time: 01/10/06, 15:52:34
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
PRJ_BridgesEntry
OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; True:C214)
OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Editable)
OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; False:C215)

//End Object Method: PRJ_DEDBridgeNo_s