//%attributes = {"invisible":true}
// Method: LTR_GenerateTruckPic
// Description
// Generate the truck posting image for the letter from the chart area
// 
// Parameters
// $0 : $ThePicture_pic
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/17/07, 18:54:42
	// ----------------------------------------------------
	
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(8/28/14 10:30:41)
	Mods_2014_08
	//  `for design user allow converting image to another codec.
	// Modified by: Costas Manousakis-(Designer)-(5/29/15 11:51:30)
	Mods_2015_05
	//  `testing svg -  use method LTR_GetTruckPostPic - run 4D chart code only
	// Modified by: Costas Manousakis-(Designer)-(9/1/15 16:18:20)
	Mods_2015_09
	//  `use ut_Use4DChartorSVG
	//  `LTR_GetTruckPostPic was re-written to include the LTR_VerifyTruckPosting call
	Mods_2015_08  //cjm Remove calls to 4D Chart area
	//Modified by: Chuck Miller (9/10/15 14:12:21)
	
End if 
C_PICTURE:C286($0; $ThePicture_pic)
$ThePicture_pic:=$ThePicture_pic*0
C_LONGINT:C283($ChartArea_L; $NumObjects; $i; $objID; $left; $top; $right; $bot; $ObjType; $SingleID)


$ThePicture_pic:=LTR_GetTruckPostPic

$0:=$ThePicture_pic
$ThePicture_pic:=$ThePicture_pic*0