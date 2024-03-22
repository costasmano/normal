If (False:C215)
	//[Bridge MHD NBIS];"Bridge Input".bMisc
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Bring up the SI & A input form
	
	// Modified by: costasmanousakis-(Designer)-(11/19/05 16:40:39)
	Mods_2005_CM19
	DIALOG:C40([Bridge MHD NBIS:1]; "Other Info")
	// Modified by: Costas Manousakis-(Designer)-(5/15/13 16:23:58)
	Mods_2013_05
	//  `make sure table is in read write mode
End if 
READ WRITE:C146([Bridge MHD NBIS:1])
SIA_MountModule("Other Info")