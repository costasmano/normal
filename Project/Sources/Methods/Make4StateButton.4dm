//%attributes = {"invisible":true}
//Method: Make4StateButton
//Description
// make a 4 state button from a picture
// Parameters
// $0 : Result_pic
// $1 : Input_pic
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/02/17, 10:39:41
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
	
	C_PICTURE:C286(Make4StateButton; $1)
	C_PICTURE:C286(Make4StateButton; $0)
	
End if 
//

C_PICTURE:C286($normal; $disabled; $click; $hover)

C_PICTURE:C286($0)

$normal:=$1

$disabled:=$normal

TRANSFORM PICTURE:C988($disabled; Fade to grey scale:K61:6)
C_TEXT:C284($svg; $g; $image)

$svg:=SVG_New
$g:=SVG_New_group($svg)
$image:=SVG_New_embedded_image($g; $1)

SVG_SET_BRIGHTNESS($g; 0.9)
$click:=SVG_Export_to_picture($svg)

SVG_SET_BRIGHTNESS($g; 1.1)
$hover:=SVG_Export_to_picture($svg)

SVG_CLEAR($svg)

$0:=$normal/$click/$hover/$disabled
//End Make4StateButton