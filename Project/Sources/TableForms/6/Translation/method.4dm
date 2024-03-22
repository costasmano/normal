If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/08, 09:46:36
	// ----------------------------------------------------
	// Method: Form Method: Translation
	// Description
	//  `Form to handle the translation of MHD Design load codes to FHWA codes.
	//  `Will manage two stored parameters SIA_DESLOADCODE_MHD and
	//  `SIA_DESLOADCODE_FHWA that hold the translation table and two global arrays
	//  `◊MHDItm31Codes_atxt and ◊FHWAItm31Codes_atxt.  ` 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
	// Modified by: costasmanousakis-(Designer)-(11/8/10 10:05:25)
	Mods_2010_11
	//  `Changed dialog to ListBox, added the description
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		DESLOAD_GeneralMethod("FORMLOAD")
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 