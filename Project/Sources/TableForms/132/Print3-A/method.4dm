// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/22/12, 16:24:11
// ----------------------------------------------------
//Method: Form Method: [ScourPOA];"Print3-A"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 10:08:19)
	Mods_2012_03
	//  `Changed checkboxes to resource file "checkbox.png"
	//  `changes in some layout in 2d.
	// Modified by: Costas Manousakis-(Designer)-(5/10/12 09:09:47)
	Mods_2012_05
	//  `Moved var SCPOA_EmergFacYN_txt to clear the label
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	// Modified by: Costas Manousakis-(Designer)-(10/6/14 16:55:09)
	Mods_2014_10_bug
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(11/3/14 11:59:34)
	Mods_2014_11
	//  `minor adjustments in labels
	// Modified by: Costas Manousakis-(Designer)-(3/6/15 15:29:31)
	Mods_2015_03_bug
	//  `removed the last text and variables in section 2d, replaced with a two line static text
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		ut_getFormVariables(Current method name:C684)
		SCPOA_PrintFormsA_FM("Print3-A")
		
End case 

//
//End Form Method: [ScourPOA]Print3-A