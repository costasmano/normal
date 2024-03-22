// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/22/12, 16:24:11
// ----------------------------------------------------
//Method: Form Method: [ScourPOA];"Print5-A"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 10:10:11)
	Mods_2012_03
	//  `changes in some formatting  in 5c. requested by CHA.
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		ut_getFormVariables(Current method name:C684)
		SCPOA_PrintFormsA_FM("Print5-A")
		
End case 

//
//End Form Method: [ScourPOA]Print5-A