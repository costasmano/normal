//Method:" [PON_ELEM_INSP];"Output_LB"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/18/19, 12:46:19
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(1/18/19 13:04:51)
	Mods_2019_01_bug
	//  `renamed old Output form to Output_LB to use a list box; modified code in some buttons to use lsitbox sets
	//  //added button for a tool to fix NBE links
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		READ ONLY:C145(*)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		OBJECT SET ENABLED:C1123(*; "bAdd"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bDelete"; False:C215)
		WINDOW_TITLE(->[PON_ELEM_INSP:179])
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Unload:K2:2)
		
End case 

//End [PON_ELEM_INSP];"Output_LB"