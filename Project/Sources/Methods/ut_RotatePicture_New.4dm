//%attributes = {"invisible":true}
//Method: ut_RotatePicture_New
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/24/20, 15:17:21
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12  //Add code that will create PDFs of all [Inspections]InspApproved=2
	// added code to print sketches or charts in portrait by rotating image
	
	C_PICTURE:C286(ut_RotatePicture_New; $1)
	C_REAL:C285(ut_RotatePicture_New; $2)
	C_PICTURE:C286(ut_RotatePicture_New; $0)
	
End if 
//
C_PICTURE:C286($1; $gPicture)
C_REAL:C285($2; $rDegrees)  //Expects 90, 180, or 270
C_PICTURE:C286($0)

$gPicture:=$1
$rDegrees:=$2

C_LONGINT:C283($lWidth; $lHeight)
C_TEXT:C284($svgRef; $imageRef)

PICTURE PROPERTIES:C457($gPicture; $lWidth; $lHeight)
$svgRef:=SVG_New($lWidth; $lHeight)
$imageRef:=SVG_New_embedded_image($svgRef; $gPicture; 0; 0; ".jpeg")

If (($rDegrees=90) | ($rDegrees=270))
	SVG_SET_TRANSFORM_ROTATE($imageRef; $rDegrees; ($lHeight/2); ($lWidth/2))
	SVG_SET_TRANSFORM_TRANSLATE($imageRef; (($lHeight-$lWidth)/2); (($lWidth-$lHeight)/2))
	DOM SET XML ATTRIBUTE:C866($svgRef; "height"; String:C10($lWidth); "width"; String:C10($lHeight))
Else   //180
	SVG_SET_TRANSFORM_ROTATE($imageRef; $rDegrees; ($lWidth/2); ($lHeight/2))
End if 

$0:=SVG_Export_to_picture($svgRef)
SVG_CLEAR($svgRef)

//End ut_RotatePicture_New