//%attributes = {"invisible":true}
//G_ElmtDefPopup 
//Popupmenu for Deficiency drop down in [ElementsSafety] input forms.
// $1 : $FormEvent (Optional)
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(1/16/19 09:54:04)
	Mods_2019_01_bug
	//  `changed _o_ commands to OBJECT SET - CallReference #596
	
	// Modified by: Costas Manousakis-(Designer)-(9/20/21 13:39:58)
	Mods_2021_09
	//  `added optional parameter $1 for $formEvent
	
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 

POPUPMENUC(->aDefCAT_; ->aDefCode_; ->[ElementsSafety:29]Deficiency:3; $FormEvent)
If ($formEvent=On Clicked:K2:4)
	PushChange(2; ->[ElementsSafety:29]Deficiency:3)
	If ([ElementsSafety:29]Deficiency:3="N")
		[ElementsSafety:29]Priority:20:=""
		PushChange(2; ->[ElementsSafety:29]Priority:20)
		aUORCAT_:=0
		OBJECT SET ENABLED:C1123(aUORCAT_; False:C215)  // **replaced _ o _DISABLE BUTTON(aUORCAT_)
		OBJECT SET ENTERABLE:C238([ElementsSafety:29]Priority:20; False:C215)
		OBJECT SET RGB COLORS:C628(*; "DE Priority@"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Priority@"; <>Color_Not_editable)
	Else 
		OBJECT SET ENABLED:C1123(aUORCAT_; True:C214)  // **replaced _ o _ENABLE BUTTON(aUORCAT_)
		OBJECT SET ENTERABLE:C238([ElementsSafety:29]Priority:20; True:C214)
		OBJECT SET RGB COLORS:C628(*; "DE Priority@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Priority@"; <>Color_Editable)
	End if 
End if 
If ([ElementsSafety:29]Deficiency:3="N")
	OBJECT SET ENABLED:C1123(aUORCAT_; False:C215)  // **replaced _ o _DISABLE BUTTON(aUORCAT_)
Else 
	OBJECT SET ENABLED:C1123(aUORCAT_; True:C214)  // **replaced _ o _ENABLE BUTTON(aUORCAT_)
End if 