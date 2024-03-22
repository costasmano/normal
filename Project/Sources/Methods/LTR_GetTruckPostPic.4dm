//%attributes = {"invisible":true}
//Method: LTR_GetTruckPostPic
//Description
//  `get a truck posting sign picture from SVG
// Parameters
// $0 : $Picture_pic
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/20/15, 14:19:20
	// ----------------------------------------------------
	//Created : 
	
	Mods_2015_05
	//svg code has been commented out for compiling
	C_PICTURE:C286(LTR_GetTruckPostPic; $0)
	// Modified by: Costas Manousakis-(Designer)-(9/2/15 11:18:41)
	Mods_2015_09
	//  `use ◊pref_TruckPost_NOL, new methods SVG_ParseTextSource SVG_FindSetTspan SVG_ApplyScale
	
	// Modified by: Costas Manousakis-(Designer)-(9/14/16 17:06:05)
	Mods_2016_09
	//  //Re-enabled all SVG plugin calls - were disabled in v11
	
End if 
//  `
//
C_PICTURE:C286($0; $svgpic_pic)

C_TEXT:C284($svgfile_txt; $svgref; $svgTemplate_txt)

$svgpic_pic:=$svgpic_pic*0

If (<>pref_TruckPost_NOL)
	$svgTemplate_txt:="SVG_TRUCKPOSTING_NOL"
Else 
	$svgTemplate_txt:="SVG_TRUCKPOSTING"
End if 
$svgfile_txt:=ut_GetSysParameter($svgTemplate_txt)

Case of 
	: ($svgfile_txt="")
		ALERT:C41("Missing Truck Posting Template "+$svgTemplate_txt)
	: (Not:C34(SVG_ParseTextSource(->$svgfile_txt; ->$svgref)))
		ALERT:C41("Corrupt System Template SVG_VERTCLEAR")
	: (Not:C34(LTR_VerifyTruckPosting))
	Else 
		
		Case of 
			: (Not:C34(SVG_FindSetTspan($svgref; "HSTRUCK"; Truck_post_1_txt+"T")))
			: (Not:C34(SVG_FindSetTspan($svgref; "TYPE3TRUCK"; Truck_post_2_txt+"T")))
			: (Not:C34(SVG_FindSetTspan($svgref; "TYPE3S2TRUCK"; Truck_post_3_txt+"T")))
			: (Not:C34(SVG_FindSetTspan($svgref; "SINGLETRUCK"; Truck_post_4_txt)))
			Else 
				//scale by 3 - the orig width and ht are also multiplied by 3 from know svg
				SVG_ApplyScale($svgref; 3)
				
				// *** SVG OUT *** 
				$svgpic_pic:=SVG_Export_to_picture($svgref)
				
		End case 
End case 

// *** SVG OUT *** 
SVG_CLEAR($svgref)

$0:=$svgpic_pic
$svgpic_pic:=$svgpic_pic*0
//
//  `End LTR_GetTruckPostPic