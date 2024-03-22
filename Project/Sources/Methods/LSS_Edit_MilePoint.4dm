//%attributes = {"invisible":true}
//Method: LSS_Edit_MilePoint
//Description
//
If (False:C215)
	Mods_2015_08_bug
	// Added code to allow change to mile marker/ kilo point on 
	//Modified by: administrator (8/13/15 12:16:35)
	// Modified by: Costas Manousakis-(Designer)-(9/28/15 17:27:41)
	Mods_2015_09_bug
	//  `changed to enable or disable edit - added parameter 1 ("EDIT" | "LOCK")
	
	C_TEXT:C284(LSS_Edit_MilePoint; $1)
End if 
C_TEXT:C284($1)

Case of 
	: ($1="EDIT")
		OBJECT SET ENTERABLE:C238(*; "NoEdit7"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "NoEdit6"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "NoEdit7"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEdit7"; <>color_editable)
		OBJECT SET RGB COLORS:C628(*; "NoEdit6"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEdit6"; <>color_editable)
		//SET FILTER(*;"LSS_SIN_2_L@";"&9"+"#####")
		GOTO OBJECT:C206(*; "NoEdit6")
		
	: ($1="LOCK")
		OBJECT SET ENTERABLE:C238(*; "NoEdit7"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "NoEdit6"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "NoEdit7"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEdit7"; <>color_not_editable)
		OBJECT SET RGB COLORS:C628(*; "NoEdit6"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEdit6"; <>color_not_editable)
		//SET FILTER(*;"LSS_SIN_2_L@";"&9"+"#####")
		
End case 


//End LSS_Edit_MilePoint