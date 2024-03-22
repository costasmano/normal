// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/27/12, 16:45:27
// ----------------------------------------------------
//Method: Form Method: [ScourPOA];"FieldVerificationCardpg1"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 09:56:16)
	Mods_2012_03
	//  `Changed checkboxes to resource file "checkbox.png"
	//  `Changed vertical text to resource files also
	// Modified by: Costas Manousakis-(Designer)-(4/19/12 16:26:51)
	Mods_2012_04
	//  `Added "fileds" for lat/lon , structure type
	//  `removed some sections
	//  `Adjusted size and location of objects so that a better left margin is left for 3-hole punching
	// Modified by: Costas Manousakis-(Designer)-(5/10/12 09:45:50)
	Mods_2012_05
	//  `Adjustments to object sizes, locations for better fit
	// Modified by: Costas Manousakis-(Designer)-(6/8/12 09:08:56)
	Mods_2012_06
	//  `Increased vert size of SCPOA_OthScCritElev_txt
	// Modified by: Costas Manousakis-(Designer)-(12/21/12 12:01:21)
	Mods_2012_12
	//  `Moved obejcts to left to align w 2nd page
	// Modified by: Costas Manousakis-(Designer)-(2/7/13 10:10:34)
	Mods_2013_02
	//  `Changed NOAA label from "Stage (WSE) at Gage" to "Storm Surge at Gage"
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	// Modified by: Costas Manousakis-(Designer)-(2/23/15 15:55:08)
	Mods_2015_02
	//  `added extra space for the NWS river forrecast info link
	// Modified by: Costas Manousakis-(Designer)-(3/4/15 15:13:15)
	Mods_2015_03_bug
	//  `adjusted location of SCPOA_USGSStProxBrg_s
	// Modified by: Costas Manousakis-(Designer)-(10/28/15 17:24:47)
	Mods_2015_10_bug
	//  `fixed spelling in  "Scour critical feature"
End if 
//
SCPOA_PrintFormsA_FM("FieldVerificationCardpg1")
//End Form Method: [ScourPOA]FieldVerificationCardpg1