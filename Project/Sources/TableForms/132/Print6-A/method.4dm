// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/22/12, 16:24:11
// ----------------------------------------------------
//Method: Form Method: [ScourPOA];"Print6-A"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 10:11:58)
	Mods_2012_03
	//  `Changed checkboxes to resource file "checkbox.png"
	//  `changes in some labels in 6b and 7b.
	// Modified by: Costas Manousakis-(Designer)-(10/6/14 14:49:19)
	Mods_2014_10_bug
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(1/13/15 16:23:44)
	Mods_2015_01
	//  `removed Priority str countermeasure from here - stays on summary
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		ut_getFormVariables(Current method name:C684)
		SCPOA_PrintFormsA_FM("Print6-A")
End case 

//
//End Form Method: [ScourPOA]Print6-A