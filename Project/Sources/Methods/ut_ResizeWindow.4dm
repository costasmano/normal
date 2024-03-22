//%attributes = {"invisible":true}
// ut_ResizeWindow
// Description
// Resize a window
// Parameters
// $1 : WindowID
// $2 : $newwidth
// $3 : $newheight
// $4 : CenterOption (Horizontally centered | Vertically centered | 0)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): cjmiller
	// Date and time: 12/13/05, 10:31:37
	// ----------------------------------------------------
	Mods_2005_CJM04
	Mods_2006_CJMv2  //10/13/06, 10:59:25
	// Modified by: Costas Manousakis-(Designer)-(2022-03-25 16:15:17)
	Mods_2022_03
	//  `added 4th optional parameter to center the new window around the current center of window
End if 
C_LONGINT:C283($1; $newleft; $newtop; $newright; $newbottom; $2; $3)
C_LONGINT:C283($left; $top; $right; $bottom; $width; $height)

C_LONGINT:C283($Center_option)
$Center_option:=0
If (Count parameters:C259>3)
	C_LONGINT:C283($4)
	$Center_option:=$4
End if 
GET WINDOW RECT:C443($left; $top; $right; $bottom; $1)

$width:=$2
$height:=$3

Case of 
		
	: ($Center_option=Horizontally centered:K39:1)
		$newleft:=($left+$right)/2-($width/2)
		$newtop:=$top
		
	: ($Center_option=Vertically centered:K39:4)
		$newleft:=$left
		$newtop:=($top+$bottom)/2-($height/2)
		
	Else 
		$newleft:=$left
		$newtop:=$top
		
End case 

$newright:=$newleft+$width
$newbottom:=$top+$height

SET WINDOW RECT:C444($newleft; $newtop; $newright; $newbottom; $1)

//End ut_ResizeWindow