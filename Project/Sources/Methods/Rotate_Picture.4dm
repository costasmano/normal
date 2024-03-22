//%attributes = {"invisible":true}
//Method: Rotate_Picture
//Description
// Rotate a picture using SVG.
// Parameters
// $0 : $RotatedPicture
// $1 : $Picture
// $2 : $Degrees
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/28/20, 18:23:19
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12  //Add code that will create PDFs of all [Inspections]InspApproved=2
	// added code to print sketches or charts in portrait by rotating image
	C_PICTURE:C286(Rotate_Picture; $0)
	C_PICTURE:C286(Rotate_Picture; $1)
	C_REAL:C285(Rotate_Picture; $2)
	
End if 
//

C_PICTURE:C286($gPicture; $rotated)
$gPicture:=$1
C_REAL:C285($rDegrees)  //Expects 90, 180, or 270
$rDegrees:=$2

C_LONGINT:C283($lWidth; $lHeight; $diag)
C_TEXT:C284($svgRef; $imageRef; $rectRef; $origPoly; $rotPoly; $boundpoly)

PICTURE PROPERTIES:C457($gPicture; $lWidth; $lHeight)
$diag:=Square root:C539(($lWidth*$lWidth)+($lHeight*$lHeight))
$svgRef:=SVG_New(2*$diag; 2*$diag)
ARRAY REAL:C219($pts_x; 4)
ARRAY REAL:C219($pts_y; 4)
ARRAY REAL:C219($rpts_x; 4)
ARRAY REAL:C219($rpts_y; 4)
// pts 1 : BotR , 2 : BotL, 3 : TopL, 4 : TopR
$pts_x{1}:=$lWidth/2
$pts_x{2}:=-($lWidth/2)
$pts_x{3}:=-($lWidth/2)
$pts_x{4}:=$lWidth/2
$pts_y{1}:=$lHeight/2
$pts_y{2}:=$lHeight/2
$pts_y{3}:=-($lHeight/2)
$pts_y{4}:=-($lHeight/2)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($pts_x))
	$rpts_x{$loop_L}:=($pts_x{$loop_L}*Cos:C18($rDegrees*Degree:K30:2))-($pts_y{$loop_L}*Sin:C17($rDegrees*Degree:K30:2))
	$rpts_y{$loop_L}:=($pts_x{$loop_L}*Sin:C17($rDegrees*Degree:K30:2))+($pts_y{$loop_L}*Cos:C18($rDegrees*Degree:K30:2))
End for 
C_REAL:C285($maxX; $MaxY; $MinX; $minY)
$MinX:=2*$diag
$minY:=2*$diag
$maxX:=0
$MaxY:=0
For ($loop_L; 1; Size of array:C274($pts_x))
	$pts_x{$loop_L}:=$pts_x{$loop_L}+$diag
	$pts_y{$loop_L}:=$pts_y{$loop_L}+$diag
	$rpts_x{$loop_L}:=$rpts_x{$loop_L}+$diag
	$rpts_y{$loop_L}:=$rpts_y{$loop_L}+$diag
End for 
$MinX:=MinNum($rpts_x{1}; $rpts_x{2}; $rpts_x{3}; $rpts_x{4})
$Miny:=MinNum($rpts_y{1}; $rpts_y{2}; $rpts_y{3}; $rpts_y{4})
$maxX:=MaxNum($rpts_x{1}; $rpts_x{2}; $rpts_x{3}; $rpts_x{4})
$MaxY:=MaxNum($rpts_y{1}; $rpts_y{2}; $rpts_y{3}; $rpts_y{4})

//$origPoly:=SVG_New_polygon_by_arrays ($svgRef;->$pts_x;->$pts_y;"black";"white:20")
$imageRef:=SVG_New_embedded_image($svgRef; $gPicture; ($diag-($lWidth/2)); ($diag-($lHeight/2)))
//SVGTool_SHOW_IN_VIEWER ($svgRef)
SVG_SET_TRANSFORM_ROTATE($imageRef; $rDegrees; $diag; $diag)
//$rotPoly:=SVG_New_polygon_by_arrays ($svgRef;->$rpts_x;->$rpts_y;"red";"red:20")
//$boundpoly:=SVG_New_rect ($svgRef;$MinX;$Miny;($maxX-$MinX);($MaxY-$minY);0;0;"green";"green:20")
//SVGTool_SHOW_IN_VIEWER ($svgRef)
//SVG_SET_TRANSFORM_TRANSLATE ($origPoly;-$MinX;-$minY)
//SVGTool_SHOW_IN_VIEWER ($svgRef)
SVG_SET_TRANSFORM_TRANSLATE($imageRef; -(($MinX*Cos:C18(Degree:K30:2*$rDegrees*-1))-($minY*Sin:C17(Degree:K30:2*$rDegrees*-1))); -(($MinX*Sin:C17(Degree:K30:2*$rDegrees*-1))+($minY*Cos:C18(Degree:K30:2*$rDegrees*-1))))
//SVGTool_SHOW_IN_VIEWER ($svgRef)
//SVG_SET_TRANSFORM_TRANSLATE ($rotPoly;-$MinX;-$minY)
//SVGTool_SHOW_IN_VIEWER ($svgRef)
//SVG_SET_TRANSFORM_TRANSLATE ($boundpoly;-$MinX;-$minY)
//SVGTool_SHOW_IN_VIEWER ($svgRef)
DOM SET XML ATTRIBUTE:C866($svgRef; "width"; String:C10(($maxX-$MinX)); "height"; String:C10(($MaxY-$minY)))
//SVGTool_SHOW_IN_VIEWER ($svgRef)
//SVG_SET_VIEWBOX ($svgRef;$MinX;$Miny;($maxX-$MinX);($MaxY-$minY);"false")
//SVG_SET_VISIBILITY ($boundpoly;False)
//SVG_SET_VISIBILITY ($rotPoly;False)
//SVG_SET_VISIBILITY ($origPoly;False)
//SVGTool_SHOW_IN_VIEWER ($svgRef)
$rotated:=SVG_Export_to_picture($imageRef)
$0:=$rotated
//SET PICTURE TO PASTEBOARD($rotated)
SVG_CLEAR($svgRef)

//End Rotate_Picture