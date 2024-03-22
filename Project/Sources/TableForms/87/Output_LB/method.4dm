//Method: Form Method: [ServerProcesses];"Output_LB"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/21/13, 15:40:11
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
	// Modified by: Costas Manousakis-(Designer)-(10/30/17 15:09:16)
	Mods_2017_10
	//  `changes to make it better when used in a DIALOG - left only "Running" as enterable
	// Modified by: Costas Manousakis-(Designer)-(9/2/20 11:46:23)
	Mods_2020_09_bug
	//  `add Code in form method to make table read only on Load
	//  `Changed hilite set of LB to Userset
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		UNLOAD RECORD:C212(Current form table:C627->)
		READ ONLY:C145(Current form table:C627->)
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End Form Method: [ServerProcesses];"Output_LB"