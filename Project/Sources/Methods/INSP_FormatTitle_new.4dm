//%attributes = {"invisible":true}
//Method: INSP_FormatTitle_New
//Description
//  `Adjust the font and size of the inspection title on page 1s.
//  `Assumes that the starting size of the title object is the max size.
//  `Uses a 30 pixel total hor margin 

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/09/13, 18:57:37
	// ----------------------------------------------------
	//Created : 
	Mods_2013_01
End if 
//
C_LONGINT:C283($NewW_L; $maxVert_L; $MinFont_L; $StartFont_L; $BW; $BH; $W; $H; $L; $T; $R; $B; $Margin_L; $MoveH; $MoveV; $ResizeH; $ResizeV)
OBJECT GET COORDINATES:C663(*; "Inspection Title"; $L; $T; $R; $B)
$H:=$B-$T
$W:=$R-$L
$Margin_L:=30  // Margin on text block

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$Margin_L:=$1
End if 
$StartFont_L:=14  //Start font size
$MinFont_L:=9  //Min Font size
OBJECT GET BEST SIZE:C717(*; "Inspection Title"; $BW; $BH; ($W-$Margin_L))
While (($BH>$H) & ($StartFont_L>=$MinFont_L))
	$StartFont_L:=$StartFont_L-1
	OBJECT SET FONT SIZE:C165(*; "Inspection Title"; $StartFont_L)
	OBJECT GET BEST SIZE:C717(*; "Inspection Title"; $BW; $BH; ($W-$Margin_L))
End while 
$NewW_L:=$BW+$Margin_L
$MoveH:=($W-$NewW_L)\2
$MoveV:=($H-$BH)\2
$ResizeH:=$NewW_L-$W
$ResizeV:=($BH+1)-$H
OBJECT MOVE:C664(*; "Inspection Title"; $MoveH; $MoveV; $ResizeH; $ResizeV)

//End INSP_FormatTitle_New