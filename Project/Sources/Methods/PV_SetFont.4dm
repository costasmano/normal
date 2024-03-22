//%attributes = {"invisible":true}
If (False:C215)
	
	// Project Method: PV_SetFont (area; font name; font size; font style)
	
	// Sets the default font and font size for the area.  Leave the font name blank to
	//   use the system font.
	
	// Method History:
	//   DB020820 - Created by Dave Batton
	
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 
//C_LONGINT($1;$3;$4;$area;$fontNum;$size;$style)
//C_TEXT($2;$font)

//$area:=$1
//$font:=$2
//$size:=$3
//$style:=$4

//If ($font="")
//ARRAY TEXT($FontList_atxt;0)
//ARRAY LONGINT($FontIds_al;0)

//PV GET FONT LIST ($area;$FontIds_al;$FontList_atxt)
//$font:=$FontList_atxt{1}  //_ o _Font name(0)  // If a blank string is passed, use the system font.
//End if 

//$fontNum:=PV Add font ($area;$font)

//PV SET STYLE PROPERTY ($area;pv style cells;pv style text font;$fontNum)
//PV SET STYLE PROPERTY ($area;pv style cells;pv style text size;$size)
//PV SET STYLE PROPERTY ($area;pv style cells;pv style text face;$style)
//PV SET STYLE PROPERTY ($area;pv style cells;pv style color back even;PV RGB to color (255;255;255))
//PV SET STYLE PROPERTY ($area;pv style cells;pv style color back odd;PV RGB to color (200;200;200))
//PV SET STYLE PROPERTY ($area;pv style cells;pv style color text odd;PV RGB to color (0;0;255))
//PV SET STYLE PROPERTY ($area;pv style cells;pv style color text even;PV RGB to color (0;0;255))