// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/22/12, 16:24:11
// ----------------------------------------------------
//Method: Form Method: [ScourPOA];"Print4-A"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 10:09:28)
	Mods_2012_03
	//  `Changed checkboxes to resource file "checkbox.png"
	// Modified by: Costas Manousakis-(Designer)-(2/7/13 10:10:34)
	Mods_2013_02
	//  `Changed NOAA label from "Stage (WSE) at Gage" to "Storm Surge at Gage"
	// Modified by: Costas Manousakis-(Designer)-(8/8/13 14:17:08)
	Mods_2013_08
	//  `Fixed spelling of Dropline Readings (item 4a)
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	// Modified by: Costas Manousakis-(Designer)-(10/23/14 17:27:06)
	Mods_2014_10
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(1/13/15 15:51:48)
	Mods_2015_01
	//  `changed wording of 3f.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		ut_getFormVariables(Current method name:C684)
		SCPOA_PrintFormsA_FM("Print4-A")
		
End case 

//
//End Form Method: [ScourPOA]Print4-A