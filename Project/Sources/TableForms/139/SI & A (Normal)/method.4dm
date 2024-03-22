If (False:C215)
	// Method: Form Method: SI & A (Normal)
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 12:45:33
	// ----------------------------------------------------
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 13:49:46)
	Mods_2012_03
	//  `changed sMissingSignstext from A(30) to text
	// Modified by: Costas Manousakis-(Designer)-(10/30/18 12:52:33)
	Mods_2018_10
	//  `Added single posting values - use method ARCH_Utils
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	
	ARCH_Utils("TOWNLINE")
	
	ARCH_Utils("FILLPRINTVARIABLES")
	
	//added to get the Recommended Posting values from the [RatingReports] table
	ARCH_Utils("RATINGS")
	ARCH_Utils("RANK")
End if 