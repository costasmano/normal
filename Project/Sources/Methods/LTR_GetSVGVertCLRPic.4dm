//%attributes = {"invisible":true}
//Method: LTR_GetSVGVertCLRPic
//Description
// Create the Vert Clearance Picture used in UnderClearance letters
// Parameters
// $0 : $ThePicture_pic
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/01/15, 17:33:38
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
	
	C_PICTURE:C286(LTR_GetSVGVertCLRPic; $0)
	
	// Modified by: Costas Manousakis-(Designer)-(9/14/16 17:06:05)
	Mods_2016_09
	//  //Re-enabled all SVG plugin calls - were disabled in v11
	
End if 
//
C_PICTURE:C286($0; $ThePicture_pic)
$ThePicture_pic:=$ThePicture_pic*0

C_TEXT:C284($svgfile_txt; $svgref)
$svgfile_txt:=ut_GetSysParameter("SVG_VERTCLEAR")

Case of 
	: ($svgfile_txt="")
		ALERT:C41("Missing Vertical Clearance Template SVG_VERTCLEAR")
	: (Not:C34(SVG_ParseTextSource(->$svgfile_txt; ->$svgref)))
		ALERT:C41("Corrupt System Template SVG_VERTCLEAR")
	: (Not:C34(LTR_VerifyVertCL))
	Else 
		
		//SVGTool_SHOW_IN_VIEWER ($svgref)
		//C_PICTURE($svgpic_pic)
		//$svgpic_pic:=SVG_Export_to_picture ($svgref)
		//SET PICTURE TO PASTEBOARD($svgpic_pic)
		
		//$gRef:=SVG_Find_ID ($svgref;"00C02E84")
		VERTCL_Feet_txt:=VERTCL_Feet_txt+"'-"+VERTCL_Inches_txt+Char:C90(Double quote:K15:41)
		//SVG_FindSetTspan ($svgref;"HEIGHT";VERTCL_Feet_txt)
		//$hsref:=SVG_Find_ID ($svgref;"HEIGHT")
		//C_LONGINT($count)
		//C_TEXT($hsref;$tRef;$value_txt)
		//C_BLOB($blob_blb)
		$ThePicture_pic:=$ThePicture_pic*0
		Case of 
			: (Not:C34(SVG_FindSetTspan($svgref; "HEIGHT"; VERTCL_Feet_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "TotNumSign"; VERTCL_1_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "TotNumPosts"; VERTCL_2_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atBrBoth"; VERTCL_B1_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atBrNorth"; VERTCL_B2_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atBrSouth"; VERTCL_B3_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atBrEast"; VERTCL_B4_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atBrWest"; VERTCL_B5_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atAdBoth"; VERTCL_A1_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atAdNorth"; VERTCL_A2_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atAdSouth"; VERTCL_A3_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atAdEast"; VERTCL_A4_txt)))
			: (Not:C34(SVG_FindSetTspan($svgref; "atAdWest"; VERTCL_A5_txt)))
			Else 
				//scale by 3 - the orig width and ht are also multiplied by 3 from known svg
				
				SVG_ApplyScale($svgref; 3)
				//SVGTool_SHOW_IN_VIEWER ($svgref)
				
				// *** SVG OUT *** 
				$ThePicture_pic:=SVG_Export_to_picture($svgref)
				
		End case 
		
End case 

// *** SVG OUT *** 
SVG_CLEAR($svgref)

$0:=$ThePicture_pic

//End LTR_GetSVGVertCLRPic