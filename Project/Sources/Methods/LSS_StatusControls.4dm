//%attributes = {"invisible":true}
//Method: LSS_StatusControls
//Description
// method that applies controls to objects on input form depending on status
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 05/03/23, 19:39:22
	// ----------------------------------------------------
	//Created : 
	Mods_2023_LSSNew
End if 
//

Case of 
	: ([LSS_Inventory:165]LSS_Status_s:35="Proposed")
		OBJECT SET ENTERABLE:C238(*; "LSS_Built@"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "LSSReplace@"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "@Rehab@"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "LSS_Built@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"NoEdit@";<>Color_Not_Editable)
		OBJECT SET RGB COLORS:C628(*; "LSSReplace@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"NoEdit@";<>Color_Not_Editable)
		OBJECT SET RGB COLORS:C628(*; "@Rehab@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"NoEdit@";<>Color_Not_Editable)
		OBJECT SET ENABLED:C1123(*; "LSS_Built@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "LSSReplace@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "@Rehab@"; False:C215)
	Else 
		OBJECT SET ENTERABLE:C238(*; "LSS_Built@"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSSReplace@"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "@Rehab@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "LSS_Built@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "LSSReplace@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "@Rehab@"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "LSS_Built@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"NoEdit@";<>Color_Not_Editable)
		OBJECT SET RGB COLORS:C628(*; "LSSReplace@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"NoEdit@";<>Color_Not_Editable)
		OBJECT SET RGB COLORS:C628(*; "@Rehab@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"NoEdit@";<>Color_Not_Editable)
		
End case 

//End LSS_StatusControls