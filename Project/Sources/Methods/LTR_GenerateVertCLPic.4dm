//%attributes = {"invisible":true}
// Method: LTR_GenerateVertCLPic
// Description
//  ` Generate the Vert Clearance Sign
// Parameters
// $0 : $ThePicture_pic
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/17/07, 19:53:50
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(5/21/15 12:37:10)
	Mods_2015_05
	//  `testing svg - comment out svg code - run 4D chart code 
	// Modified by: Costas Manousakis-(Designer)-(9/2/15 11:09:14)
	Mods_2015_09
	//  `Use ut_Use4DChartorSVG and new method LTR_GetSVGVertCLRPic
	Mods_2015_08  //cjm Remove calls to 4D Chart area
	//Modified by: Chuck Miller (9/10/15 14:12:21)
End if 
C_PICTURE:C286($0; $ThePicture_pic)
$ThePicture_pic:=$ThePicture_pic*0
C_LONGINT:C283($ChartArea_L; $NumObjects; $i; $objID; $left; $top; $right; $bot; $ObjType; $SingleID)


$ThePicture_pic:=LTR_GetSVGVertCLRPic


$0:=$ThePicture_pic
$ThePicture_pic:=$ThePicture_pic*0