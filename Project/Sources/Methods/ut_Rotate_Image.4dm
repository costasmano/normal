//%attributes = {"invisible":true}
//Method: ut_Rotate_Image
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/24/20, 13:12:01
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12
	
	C_PICTURE:C286(ut_Rotate_Image; $1; $0)
	C_REAL:C285(ut_Rotate_Image; $2)
	
End if 
//
C_PICTURE:C286($1; $0)
C_REAL:C285($2; $w; $h)

PICTURE PROPERTIES:C457($1; $w; $h)

//$svg:=SVG_New (530;624)
C_TEXT:C284($svg; $g; $image)
$svg:=SVG_New($h; $w)

$g:=SVG_New_group($svg)
$image:=SVG_New_embedded_image($g; $1)

SVG_ROTATION_CENTERED($image; $2)
$0:=SVG_Export_to_picture($svg)
SVG_CLEAR($svg)

//End ut_Rotate_Image