//%attributes = {"invisible":true}
//  `Method: TEST_SVGTruck
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/18/14, 09:24:47
	// ----------------------------------------------------
	//Created : 
	Mods_2014_08
	// Modified by: Costas Manousakis-(Designer)-(4/27/15 15:59:12)
	Mods_2015_04
	//  `Worked on moving / adjusting an svg truck picture
	//  `scaling and then changing size of object
End if 

C_TEXT:C284($T; $svgref; $objref)

//$T:=Request(" Draw or Read or Move or Color or vertclr")
//Case of 
//: ($T="draw")
//$svgref:=SVG_New 
//  `
//  `$objref:=SVG_New_rect ($svgref;100;45;200;150;-1;-1;"black";"white:0")
//  `
//  `$objref:=SVG_New_rect ($svgref;350;45;200;150;-1;-1;"black";"white:0")
//  `
//  `$objref:=SVG_New_text ($svgref;"TYPE :";90;50;"ARIAL";16;1;4;"black")
//  `$objref:=SVG_New_text ($svgref;"WEIGHT LIMIT";200;50;"ARIAL";16;1;3;"black")
//  `$objref:=SVG_New_text ($svgref;"WEIGHT LIMIT";450;50;"ARIAL";16;1;3;"black")
//  `
//  `$objref:=SVG_New_rect ($svgref;350;90;100;100;-1;-1;"black";"white:0")
//  `$objref:=SVG_New_rect ($svgref;350;200;100;100;-1;-1;"black";"white:0")
//  `$objref:=SVG_New_rect ($svgref;350;310;100;100;-1;-1;"black";"white:0")
//  `
//  `$objref:=SVG_New_text ($svgref;"T";460;140;"ARIAL";16;1;2;"black")
//  `$objref:=SVG_New_text ($svgref;"T";460;250;"ARIAL";16;1;2;"black")
//  `$objref:=SVG_New_text ($svgref;"T";460;360;"ARIAL";16;1;2;"black")
//  `
//  `$objref:=SVG_New_rect ($svgref;120;140;40;30;-1;-1;"black";"black")
//  `$objref:=SVG_New_rect ($svgref;160;100;40;70;-1;-1;"black";"black")
//  `$objref:=SVG_New_rect ($svgref;202;90;100;80;-1;-1;"black";"black")
//  `
//  `$objref:=SVG_New_circle ($svgref;130;180;10;"black";"black")
//  `$objref:=SVG_New_circle ($svgref;287;180;10;"black";"black")
//
//  `
//  `SVGTool_SHOW_IN_VIEWER ($svgref)
//  `C_PICTURE($svgpic_pic)
//  `$svgpic_pic:=SVG_Export_to_picture ($svgref)
//  `SET PICTURE TO PASTEBOARD($svgpic_pic)
//  `SVG_CLEAR ($svgref)
//
//: ($T="read")
//C_TEXT($svgfile_txt)
//CONFIRM("Use Label or no Label?";"Label";"No Label")
//
//If (ok=1)
//$svgfile_txt:=ut_GetSysParameter ("SVG_TRUCKPOSTING")
//Else 
//$svgfile_txt:=ut_GetSysParameter ("SVG_TRUCKPOSTING_NOL")
//End if 
//
//$svgref:=DOM Parse XML variable($svgfile_txt)
//SVGTool_SHOW_IN_VIEWER ($svgref)
//C_PICTURE($svgpic_pic)
//$svgpic_pic:=SVG_Export_to_picture ($svgref)
//SET PICTURE TO PASTEBOARD($svgpic_pic)
//
//  `$gRef:=SVG_Find_ID ($svgref;"00C02E84")
//$hsref:=SVG_Find_ID ($svgref;"HSTRUCK")
//C_LONGINT($count)
//C_TEXT($hsref;$tRef;$value_txt)
//C_BLOB($blob_blb)
//If ($hsref#"")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;Truck_post_1_txt+"T")
//$hsref:=SVG_Find_ID ($svgref;"TYPE3TRUCK")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;Truck_post_2_txt+"T")
//$hsref:=SVG_Find_ID ($svgref;"TYPE3S2TRUCK")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;Truck_post_3_txt+"T")
//$hsref:=SVG_Find_ID ($svgref;"SINGLETRUCK")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;Truck_post_4_txt)
//
//End if 
//
//  `useless
//  `DOM SET XML ATTRIBUTE($svgref;"xmlns:ns4d";"http://www.4d.com")
//  `SVG_SET_ATTRIBUTES ($svgref;"ns4d:DPI";"2400")
//
//SVGTool_SHOW_IN_VIEWER ($svgref)
//If (False)
//C_PICTURE($svgpic_pic)
//$svgpic_pic:=SVG_Export_to_picture ($svgref)
//SET PICTURE TO PASTEBOARD($svgpic_pic)
//
//End if 
//  `scale by 3 - the orig width and ht are also multiplied by 3 from know svg
//SVG_SET_TRANSFORM_SCALE ($svgref;3;3)
//ARRAY TEXT($svgattrs_atxt;0)
//ARRAY TEXT($svgattrsVals_atxt;0)
//SVG_GET_ATTRIBUTES ($svgref;->$svgattrs_atxt;->$svgattrsVals_atxt)
//C_LONGINT($newDim_L;$dimAttr_L)
//$dimAttr_L:=Find in array($svgattrs_atxt;"width")
//$newDim_L:=3*(Num($svgattrsVals_atxt{$dimAttr_L}))
//SVG_SET_ATTRIBUTES ($svgref;"width";String($newDim_L))
//$dimAttr_L:=Find in array($svgattrs_atxt;"height")
//$newDim_L:=3*(Num($svgattrsVals_atxt{$dimAttr_L}))
//SVG_SET_ATTRIBUTES ($svgref;"height";String($newDim_L))
//
//SVGTool_SHOW_IN_VIEWER ($svgref)
//
//$svgpic_pic:=SVG_Export_to_picture ($svgref)
//SET PICTURE TO PASTEBOARD($svgpic_pic)
//$svgpic_pic:=$svgpic_pic*0
//SVG_CLEAR ($svgref)
//
//: ($t="Move")
//
//C_TEXT($svgfile_txt;$svgSource_txt)
//
//CONFIRM("Label , no label";"label";"nolabel")
//
//If (ok=1)
//$svgfile_txt:=ut_GetSysParameter ("SVG_TRUCKPOSTING")
//Else 
//$svgfile_txt:=ut_GetSysParameter ("SVG_TRUCKPOSTING_NOL")
//End if 
//
//  `$svgfile_txt:=ut_GetSysParameter ("SVG_TRUCKPOSTING")
//$svgref:=DOM Parse XML variable($svgfile_txt)
//SVGTool_SHOW_IN_VIEWER ($svgref)
//C_BOOLEAN($done_b)
//$done_b:=False
//C_REAL($trans_x_L;$trans_Y_L)
//$trans_x_L:=0
//ARRAY TEXT($objRefs_atxt;0)
//ARRAY TEXT($objTypes_atxt;0)
//ARRAY TEXT($objIDS_atxt;0)
//SVG_GetALLObjects ($svgref;->$objRefs_atxt;->$objTypes_atxt;->$objIDS_atxt)
//
//Repeat 
//$trans_x_L:=Num(Request("X Translation?"))
//$trans_Y_L:=Num(Request("Y Translation?"))
//
//ARRAY TEXT($objAttrs_atxt;0)
//ARRAY TEXT($objAttrVals_atxt;0)
//C_LONGINT($loop_L;$Xcoor_L)
//
//  `go through all objects and actually change the x,y values - don't use the SVG TRANSLATE command.
//For ($loop_L;1;Size of array($objRefs_atxt))
//SVG_GET_ATTRIBUTES ($objRefs_atxt{$loop_L};->$objAttrs_atxt;->$objAttrVals_atxt)
//Case of 
//: ($objTypes_atxt{$loop_L}="rect")
//$Xcoor_L:=Find in array($objAttrs_atxt;"x")
//SVG_SET_ATTRIBUTES ($objRefs_atxt{$loop_L};"x";String((Num($objAttrVals_atxt{$Xcoor_L})+$trans_x_L)))
//$Xcoor_L:=Find in array($objAttrs_atxt;"y")
//SVG_SET_ATTRIBUTES ($objRefs_atxt{$loop_L};"y";String((Num($objAttrVals_atxt{$Xcoor_L})+$trans_Y_L)))
//
//: ($objTypes_atxt{$loop_L}="text")
//ARRAY TEXT($textrefs_atxt;0)
//ARRAY TEXT($textTypes_atxt;0)
//ARRAY TEXT($textIDs_atxt;0)
//C_TEXT($tspan_txt;$nexttspan_txt)
//$tspan_txt:=DOM Get first child XML element($objRefs_atxt{$loop_L})
//APPEND TO ARRAY($textrefs_atxt;$tspan_txt)
//$nexttspan_txt:=$tspan_txt
//While (ok=1)
//$nexttspan_txt:=DOM Get next sibling XML element($nexttspan_txt)
//APPEND TO ARRAY($textrefs_atxt;$nexttspan_txt)
//End while 
//  `assume that the Text object has tspan children where each has a pait of X, y attributes
//C_LONGINT($txtloop_L)
//For ($txtloop_L;1;Size of array($textrefs_atxt))
//SVG_GET_ATTRIBUTES ($textrefs_atxt{$txtloop_L};->$objAttrs_atxt;->$objAttrVals_atxt)
//$Xcoor_L:=Find in array($objAttrs_atxt;"x")
//SVG_SET_ATTRIBUTES ($textrefs_atxt{$txtloop_L};"x";String((Num($objAttrVals_atxt{$Xcoor_L})+$trans_x_L)))
//$Xcoor_L:=Find in array($objAttrs_atxt;"y")
//SVG_SET_ATTRIBUTES ($textrefs_atxt{$txtloop_L};"y";String((Num($objAttrVals_atxt{$Xcoor_L})+$trans_Y_L)))
//End for 
//
//: ($objTypes_atxt{$loop_L}="circle")
//$Xcoor_L:=Find in array($objAttrs_atxt;"cx")
//SVG_SET_ATTRIBUTES ($objRefs_atxt{$loop_L};"cx";String((Num($objAttrVals_atxt{$Xcoor_L})+$trans_x_L)))
//$Xcoor_L:=Find in array($objAttrs_atxt;"cy")
//SVG_SET_ATTRIBUTES ($objRefs_atxt{$loop_L};"cy";String((Num($objAttrVals_atxt{$Xcoor_L})+$trans_Y_L)))
//: ($objTypes_atxt{$loop_L}="path")
//$Xcoor_L:=Find in array($objAttrs_atxt;"d")
//C_TEXT($path_txt)
//$path_txt:=$objAttrVals_atxt{$Xcoor_L}
//SVG_TranslatePath (->$path_txt;$trans_x_L;$trans_Y_L)
//SVG_SET_ATTRIBUTES ($objRefs_atxt{$loop_L};"d";$path_txt)
//
//End case 
//
//End for 
//
//SVGTool_SHOW_IN_VIEWER ($svgref)
//
//$svgSource_txt:=SVG_Export_to_XML ($svgref)
//
//SET TEXT TO PASTEBOARD($svgSource_txt)
//CONFIRM("keep going?")
//$done_b:=(OK=0)
//Until ($done_b)
//SVG_CLEAR ($svgref)
//
//: ($t="Color")
//C_LONGINT($color_L)
//$color_L:=0
//C_TEXT($txtColor)
//$color_L:=Select RGB Color($color_L;"Yellow")
//$txtColor:=SVG_Color_RGB_from_long ($color_L;3)
//
//: ($T="vertclr")
//C_TEXT($svgfile_txt)
//
//LTR_VerifyVertCL 
//
//$svgfile_txt:=ut_GetSysParameter ("SVG_VERTCLEAR")
//
//$svgref:=DOM Parse XML variable($svgfile_txt)
//SVGTool_SHOW_IN_VIEWER ($svgref)
//C_PICTURE($svgpic_pic)
//$svgpic_pic:=SVG_Export_to_picture ($svgref)
//SET PICTURE TO PASTEBOARD($svgpic_pic)
//
//  `$gRef:=SVG_Find_ID ($svgref;"00C02E84")
//$hsref:=SVG_Find_ID ($svgref;"HEIGHT")
//C_LONGINT($count)
//C_TEXT($hsref;$tRef;$value_txt)
//C_BLOB($blob_blb)
//If ($hsref#"")
//VERTCL_Feet_txt:=VERTCL_Feet_txt+"'-"+VERTCL_Inches_txt+Char(Double quote )
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_Feet_txt)
//$hsref:=SVG_Find_ID ($svgref;"TotNumSign")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_1_txt)
//$hsref:=SVG_Find_ID ($svgref;"TotNumPosts")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_2_txt)
//$hsref:=SVG_Find_ID ($svgref;"atBrBoth")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_B1_txt)
//$hsref:=SVG_Find_ID ($svgref;"atBrNorth")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_B2_txt)
//$hsref:=SVG_Find_ID ($svgref;"atBrSouth")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_B3_txt)
//$hsref:=SVG_Find_ID ($svgref;"atBrEast")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_B4_txt)
//$hsref:=SVG_Find_ID ($svgref;"atBrWest")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_B5_txt)
//
//$hsref:=SVG_Find_ID ($svgref;"atAdBoth")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_A1_txt)
//$hsref:=SVG_Find_ID ($svgref;"atAdNorth")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_A2_txt)
//$hsref:=SVG_Find_ID ($svgref;"atAdSouth")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_A3_txt)
//$hsref:=SVG_Find_ID ($svgref;"atAdEast")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_A4_txt)
//$hsref:=SVG_Find_ID ($svgref;"atAdWest")
//$count:=DOM Count XML elements($hsref;"tspan")
//$tRef:=DOM Find XML element($hsref;"text/tspan")
//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
//DOM SET XML ELEMENT VALUE($tRef;VERTCL_A5_txt)
//
//End if 
//
//
//SVGTool_SHOW_IN_VIEWER ($svgref)
//If (False)
//C_PICTURE($svgpic_pic)
//$svgpic_pic:=SVG_Export_to_picture ($svgref)
//SET PICTURE TO PASTEBOARD($svgpic_pic)
//
//End if 
//  `scale by 3 - the orig width and ht are also multiplied by 3 from know svg
//SVG_SET_TRANSFORM_SCALE ($svgref;3;3)
//ARRAY TEXT($svgattrs_atxt;0)
//ARRAY TEXT($svgattrsVals_atxt;0)
//SVG_GET_ATTRIBUTES ($svgref;->$svgattrs_atxt;->$svgattrsVals_atxt)
//C_LONGINT($newDim_L;$dimAttr_L)
//$dimAttr_L:=Find in array($svgattrs_atxt;"width")
//$newDim_L:=3*(Num($svgattrsVals_atxt{$dimAttr_L}))
//SVG_SET_ATTRIBUTES ($svgref;"width";String($newDim_L))
//$dimAttr_L:=Find in array($svgattrs_atxt;"height")
//$newDim_L:=3*(Num($svgattrsVals_atxt{$dimAttr_L}))
//SVG_SET_ATTRIBUTES ($svgref;"height";String($newDim_L))
//
//SVGTool_SHOW_IN_VIEWER ($svgref)
//
//$svgpic_pic:=SVG_Export_to_picture ($svgref)
//SET PICTURE TO PASTEBOARD($svgpic_pic)
//$svgpic_pic:=$svgpic_pic*0
//SVG_CLEAR ($svgref)
//End case 
//
//  `End TEST_SVGTruck