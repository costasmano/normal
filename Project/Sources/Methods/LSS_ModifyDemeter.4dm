//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/04/14, 16:49:00
// ----------------------------------------------------
// Method: LSS_ModifyDemeter
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($LBCol_L; $LBRow_L; $Choice_L)

LISTBOX GET CELL POSITION:C971(*; "DMeter_LB"; $LBCol_L; $LBRow_L)
If ($LBRow_L>0)
	GOTO SELECTED RECORD:C245([LSS_DMeter:161]; $LBRow_L)
	$Choice_L:=ut_LoadRecordInteractiveV2(->[LSS_Inspection:164])
	OBJECT SET VISIBLE:C603(*; "DMeterInput@"; True:C214)
	Case of 
		: ($Choice_L=1)
			OBJECT SET ENABLED:C1123(*; "DMeterButton_L"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET RGB COLORS:C628(*; "DMeterInput_@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DMeterInput_@"; <>Color_editable)
			OBJECT SET RGB COLORS:C628(*; "DMeterInput_16"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DMeterInput_16"; <>Color_Not_Editable)
			OBJECT SET RGB COLORS:C628(*; "DMeterInput_8"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DMeterInput_8"; <>Color_Not_Editable)
			OBJECT SET ENTERABLE:C238(*; "DMeterInput@"; True:C214)
		: ($Choice_L=2)
			OBJECT SET ENTERABLE:C238(*; "DMeterInput@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DMeterButton_L"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET RGB COLORS:C628(*; "DMeterInput_@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DMeterInput_@"; <>Color_Not_Editable)
	End case 
Else 
	OBJECT SET VISIBLE:C603(*; "DMeterInput@"; False:C215)
End if 