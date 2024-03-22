//%attributes = {"invisible":true}
//Method: PRV_PopupMenuC
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/06/13, 11:03:32
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
C_POINTER:C301($1; $2; $3)
C_TEXT:C284($4)
C_TEXT:C284($TheOther_txt)

If (Count parameters:C259>4)
	C_TEXT:C284($5)
	$TheOther_txt:=$5
Else 
	$TheOther_txt:="Other:"
End if 

POPUPMENUC($1; $2; $3)

If (Form event code:C388=On Clicked:K2:4)
	If ($3->=$TheOther_txt)
		$3->:=$4
		OBJECT SET ENTERABLE:C238($3->; True:C214)
		OBJECT SET RGB COLORS:C628($3->; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR($3->; <>Color_Editable)
		GOTO OBJECT:C206($3->)
		POST KEY:C465(Tab key:K12:28)
		POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
	Else 
		//SET ENTERABLE($3->;False)
		//SET COLOR($3->;◊Color_not_Editable)
	End if 
	
End if 

//End PRV_PopupMenuC