//%attributes = {"invisible":true}
//Method: INSP_Deficiency_OM
//Description
// object method for the deficiency field in [ElementsSafety] input forms
// made to fix CallReference #596
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/16/19, 10:31:16
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01_bug
	
End if 
//

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		PushChange(2; Self:C308)
		POPUPMENUC(->aDefCAT_; ->aDefCode_; Self:C308)
		If (Self:C308->="N")
			[ElementsSafety:29]Priority:20:=""
			PushChange(2; ->[ElementsSafety:29]Priority:20)
			aUORCAT_:=0
			OBJECT SET ENABLED:C1123(aUORCAT_; False:C215)
			OBJECT SET ENTERABLE:C238([ElementsSafety:29]Priority:20; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE Priority@"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Priority@"; <>Color_Not_editable)
		Else 
			OBJECT SET ENABLED:C1123(aUORCAT_; True:C214)
			OBJECT SET ENTERABLE:C238([ElementsSafety:29]Priority:20; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE Priority@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Priority@"; <>Color_Editable)
		End if 
End case 
//End INSP_Deficiency_OM