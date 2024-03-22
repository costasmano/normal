//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/30/07, 09:16:18
	// ----------------------------------------------------
	// Method: G_FitPrintObject
	// Description
	// Attempt to fit a printed object within its rectangle.
	// Allow for a vertical move.
	// 
	// Parameters
	// $1 := $Object_ptr : pointer to the object
	// $2 := $StartFont_L : starting font size
	// $3 := $MinFont_L : minimum font size
	// $4 := $maxVert_L : max imum vert move up of object
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
C_POINTER:C301($1; $Object_ptr)
C_LONGINT:C283($2; $3; $4)
C_LONGINT:C283($maxVert_L; $MinFont_L; $StartFont_L; $BW; $BH; $W; $H; $L; $T; $R; $B)
$Object_ptr:=$1
$StartFont_L:=$2
$MinFont_L:=$3
$maxVert_L:=$4
OBJECT GET COORDINATES:C663($Object_ptr->; $L; $T; $R; $B)
$H:=$B-$T
$W:=$R-$L
OBJECT GET BEST SIZE:C717($Object_ptr->; $BW; $BH; $W)
While (($BH>$H) & ($StartFont_L>=$MinFont_L))
	If ($BH<=($H+$maxVert_L))
		OBJECT MOVE:C664($Object_ptr->; 0; -($maxVert_L); 0; ($maxVert_L+1))
		OBJECT GET COORDINATES:C663($Object_ptr->; $L; $T; $R; $B)
		$H:=$B-$T
	Else 
		$StartFont_L:=$StartFont_L-1
		OBJECT SET FONT SIZE:C165($Object_ptr->; $StartFont_L)
		OBJECT GET BEST SIZE:C717($Object_ptr->; $BW; $BH; $W)
	End if 
End while 