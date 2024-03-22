//%attributes = {"invisible":true}
//G_InspExtraCmtsBtn
//v3.3f3
//Usage :
//G_InspExtraCmtsBtn (VsLabel;vCommentsFieldPtr;Self;Stack)
// VsLabel : string : Label for the comments
// vCommentsFieldPtr : pointer : pointer to the field where the comments are store
// Self : pointer : pointer to the button calling this method
// Stack : number of the stack for PushChange
If (False:C215)
	Mods_2004_CM12
	Mods_2009_03  //CJM  r001   `03/06/09, 14:19:18`Upgrade from open form window to open window
	// Modified by: Costas Manousakis-(Designer)-(12/3/13 10:01:45)
	Mods_2013_12
	//  `added 4th optional param for the change stack number
	// Modified by: Costas Manousakis-(Designer)-(2022-05-13 15:44:18)
	Mods_2022_05
	//  `changed window type to Plain form window, added parameter Multistyle in the DIALOG command.
	//  `use method f_TrimStyledText to trim the styled text
End if 

C_TEXT:C284($1; vsExtraTextLabel)  // Command Replaced was o_C_STRING length was 132
C_POINTER:C301($2; $vpCmtsField; $3; $vpButton)
vsExtraTextLabel:=$1
$vpCmtsField:=$2
$vpButton:=$3
C_LONGINT:C283($ChangeStack_L)
$ChangeStack_L:=1

If (Count parameters:C259>3)
	C_LONGINT:C283($4)
	$ChangeStack_L:=$4
End if 

C_TEXT:C284(vtExtraText)
vtExtraText:=$vpCmtsField->

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "GetInspExtraCmts"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10)
//$tempwin:=Open form window([Dialogs];"GetInspExtraCmts";Movable form dialog box )
DIALOG:C40([Dialogs:21]; "GetInspExtraCmts"; New object:C1471("Multistyle"; True:C214))
CLOSE WINDOW:C154
If (OK=1)
	$vpCmtsField->:=f_TrimStyledText(New object:C1471("texttotrim"; vtExtraText; "trimleading"; True:C214; "trimtrailing"; True:C214))
	PushChange($ChangeStack_L; $vpCmtsField)
	If (Length:C16($vpCmtsField->)>0)
		OBJECT SET RGB COLORS:C628($vpButton->; Col_paletteToRGB(Abs:C99(-(Black:K11:16))%256); Col_paletteToRGB(Abs:C99(-(Black:K11:16))\256))  // **Replaced o OBJECT SET COLOR($vpButton->; -(Black))
	Else 
		OBJECT SET RGB COLORS:C628($vpButton->; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR($vpButton->; -(Red))
	End if 
End if 
