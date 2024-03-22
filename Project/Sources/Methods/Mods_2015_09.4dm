//%attributes = {"invisible":true}
//Method: Mods_2015_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/01/15, 17:39:47
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(9/1/15)
// Modified Method(s) : 
//EditTeam 
//INSP_VerifySIAChanges
//ut_SelectTables
//LSS_EditTeam
//  `The TwoListMove dialog is a Project Form now

// Created Method(s) : 
//SVG_FindSetTspan
//Description
// set the text of a Tspan element in an element based on ID 
// Parameters
// $0 : $success_b
// $1 : $svgRef
// $2 : $ID_txt
// $3 :  $IDValue_txt

//Method: ut_ArrayToPopupMenu
//Description
//  convert an array to a string to be used in the Pop up menu command
// Parameters
//$0 : $popupmenu_txt
// $1 : $Array_ptr
// $2 : $Format_txt : optional

//Method: ut_ArrayToDynamicMenu
//Description
// return a menu reference for use in  dynamic pop up menu 
// Parameters
// $0 : $menuRef (A16)
// $1 : $menuitems_ptr : ptr to array with the menu items 
// $2 : $nenuparameters_ptr : ptr to array with the menu item parameter 
// $3 : $Star_ (A1) : (optional) star option for ADD menu item. to ignore special chars in the menu item

//Method: SVG_ParseTextSource
//Description
// Parse the variable paased in pointer 1 and return the svg ref in pointer 2
// Parameters
// $0 : $Success_B
// $1 : $XMLsource_ptr
// $2 : $svgref_ptr

//Method: ut_Use4DChartorSVG
//Description
// Set whether to use 4D Chart or new SVG method
// Parameters
// $0 : $Use4DChart_b

//Method: SVG_ApplyScale
//Description
// Apply an x and y scale to an svg picture. adjusts the picture size to fit the new scaled pic
// Parameters
// $1 : $svgRef_txt
// $2 : $xScale_r
// $3 : $yScale_r (Optional - If not passed assumed equal to $2)

//Method: LTR_GetSVGVertCLRPic
//Description
// Create the Vert Clearance Picture used in UnderClearance letters
// Parameters
// $0 : $ThePicture_pic

// Modified Method(s) : 
// Method: LTR_GenerateVertCLPic
//  `Use ut_Use4DChartorSVG and new method LTR_GetSVGVertCLRPic

//LTR_GetTruckPostPic
//  `use ◊pref_TruckPost_NOL, new methods SVG_ParseTextSource SVG_FindSetTspan SVG_ApplyScale

//LTR_GenerateTruckPic
//  `use ut_Use4DChartorSVG
//  `LTR_GetTruckPostPic was re-written to include the LTR_VerifyTruckPosting call

//ut_ControlUserPrefs
//  `added pref prefTruckPostNOL-  ◊pref_TruckPost_NOL

// Modified Form/Form Methods : 
//[Dialogs];"Preferences"
//  `Added CBHideLabel for ◊pref_TruckPost_NOL - visible only for designer or if above v11 version
//  `Moved form to Project Forms

// Modified Method(s) : 
//M_HandlePrefs
//  `added ◊pref_TruckPost_NOL
//  `form "Preferences" is now a project form

// Modified Forms : 
//"VertCLR_Sign"
//  `allow only one char in the at bridge , at advance boxes

// Created Method(s) : 
//Compiler_Preferences
//Compiler_SVG

//**********`Modified by: Costas Manousakis-(Designer)-(9/18/15)
// Created Method(s) : 
//dev_convertPicLibToJPEG
//  `convert picture library pictures to JPEG for upgrade to v14


//End Mods_2015_09