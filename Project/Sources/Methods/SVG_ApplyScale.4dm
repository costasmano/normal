//%attributes = {"invisible":true}
//Method: SVG_ApplyScale
//Description
// Apply an x and y scale to an svg picture. adjusts the picture size to fit the new scaled pic
// Parameters
// $1 : $svgRef_txt
// $2 : $xScale_r
// $3 : $yScale_r (Optional - If not passed assumed equal to $2)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/01/15, 16:27:51
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
	
	C_TEXT:C284(SVG_ApplyScale; $1)
	C_REAL:C285(SVG_ApplyScale; $2)
	C_REAL:C285(SVG_ApplyScale; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(9/14/16 17:06:05)
	Mods_2016_09
	//  //Re-enabled all SVG plugin calls - were disabled in v11
End if 
//
C_TEXT:C284($1)
C_REAL:C285($2)

C_TEXT:C284($svgref)
C_REAL:C285($xScale_r; $yScale_r)
$svgref:=$1
$xScale_r:=$2
If (Count parameters:C259>2)
	$yScale_r:=$3
Else 
	$yScale_r:=$xScale_r
End if 

// *** SVG OUT *** 
SVG_SET_TRANSFORM_SCALE($svgref; $xScale_r; $yScale_r)
ARRAY TEXT:C222($svgattrs_atxt; 0)
ARRAY TEXT:C222($svgattrsVals_atxt; 0)
// *** SVG OUT *** 
SVG_GET_ATTRIBUTES($svgref; ->$svgattrs_atxt; ->$svgattrsVals_atxt)
C_LONGINT:C283($newDim_L; $dimAttr_L)
$dimAttr_L:=Find in array:C230($svgattrs_atxt; "width")
$newDim_L:=$xScale_r*(Num:C11($svgattrsVals_atxt{$dimAttr_L}))
// *** SVG OUT *** 
SVG_SET_ATTRIBUTES($svgref; "width"; String:C10($newDim_L))
$dimAttr_L:=Find in array:C230($svgattrs_atxt; "height")
$newDim_L:=$yScale_r*(Num:C11($svgattrsVals_atxt{$dimAttr_L}))
// *** SVG OUT *** 
SVG_SET_ATTRIBUTES($svgref; "height"; String:C10($newDim_L))

//End SVG_ApplyScale