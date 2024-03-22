// Method: Form Method: [Inspections]CustomInput
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/07/13, 16:33:21
	// ----------------------------------------------------
	// First Release
	Mods_2013_06
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 10:03:29)
	Mods_2013_07
	//  `Added button and modified object methods to allow editing of inspection type
	// Modified by: Costas Manousakis-(Designer)-(1/16/15 11:26:35)
	Mods_2015_01
	//  `added new  inspections tracking fields
	// Modified by: Costas Manousakis-(Designer)-(1/28/19 12:22:39)
	Mods_2019_01_bug
	//  `fixed size/spacing of objects on form.
	// Modified by: Costas Manousakis-(Designer)-(2023-03-22 18:41:01)
	Mods_2023_03
	//  `make sure [Bridge MHD NBIS] is RO mode
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		UNLOAD RECORD:C212([Inspections:27])  //start with blank
		READ ONLY:C145([Bridge MHD NBIS:1])
		UNLOAD RECORD:C212([Bridge MHD NBIS:1])
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		OBJECT SET ENABLED:C1123(bValidate; False:C215)
		OBJECT SET ENABLED:C1123(Button1; False:C215)
	: (Form event code:C388=On Validate:K2:3)
		
End case 