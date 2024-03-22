//%attributes = {"invisible":true}
//Method: Mods_2021_11_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-11-05 18:22:04
	// ----------------------------------------------------
	//Created : 
	Mods_2021_11_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2021-11-05)
// ADDUSER_Utils   - copied from v15Dev
//  `added a check if we are re-using the same name as a user that is inactive

//**********`Modified by: Costas Manousakis-(Designer)-(2021-11-08)
// BrgRank_DoRankCalc        ***** Copied from v15dev
//  `replaced FO column with FAIR (True|False)
//  `Replaced old progress with the 4D progress component.

//**********`Modified by: Costas Manousakis-(Designer)-(2021-11-24T00:00:00)
// SQL_ControlClone        ***** Copied from v15dev
//  `if $1 is a wildcard , ie search all districts, adjust the search in personnel too.

//**********`Modified by: Costas Manousakis-(Designer)-(2021-11-19)
// [Inspections];"PedestrianInspection-PED"        ***** Copied from v15bug        ***** Copied from v15dev
//  `added item 61 data in page 2

// [Inspections];"PedBridge_p1"        ***** Copied from v15bug        ***** Copied from v15dev
//  `use Choose instead of f_Boolean2String ; Added filling of vOvrHead
//  `Added missing vars for 4th element of approaches
//  `fix wrong var name for vRN59_8
//  `added item 60 from UW and item 60 cur

// [Inspections];"PedBridge_p2"        ***** Copied from v15bug        ***** Copied from v15dev
//  `added vNeedAccOther var on form - adjusted width of field [Inspections]AccessOther
//  `added call to INSP_LoadESForReport ("PED") to account for adding item 61 data.
//  `added item 61 elements and data ; re arranged item 61 and accessibility blocks

// [Inspections];"PedestrianInspection-PED".Page Preview Btn        ***** Copied from v15bug        ***** Copied from v15dev
//  `include page 2 when printing from input pages 1,2,3 (general, 58-61, elements)

// INSP_ConvertSKCH        ***** Copied from v15bug        ***** Copied from v15dev
//  `added check for max os version over 13 - do not transform for later versions - causes skewed images

// PON_PONHELP_FM       ***** Copied from v15bug
//  `use WA SET PAGE CONTENT instead of loading a temp file; set on timer (1) on load with a blank page.


//End Mods_2021_11_bug