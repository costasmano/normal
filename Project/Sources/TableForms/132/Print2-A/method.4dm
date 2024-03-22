// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/22/12, 16:24:11
// ----------------------------------------------------
//Method: Form Method: [ScourPOA];"Print2-A"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 09:59:42)
	Mods_2012_03
	//  `changes in some labels as requested by CHA.
	//  `Changed checkboxes to resource file "checkbox.png"
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	// Modified by: Costas Manousakis-(Designer)-(1/12/15 17:36:21)
	Mods_2015_01
	//  `changed labels, rasized objects per request from CHA
	// Modified by: Costas Manousakis-(Designer)-(4/9/15 12:03:01)
	Mods_2015_04_bug
	//  `fixed wrong variables for 2.a recommend and implemented check boxes
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		ut_getFormVariables(Current method name:C684)
		SCPOA_PrintFormsA_FM("Print2-A")
		
End case 

//
//End Form Method: [ScourPOA]Print2-A