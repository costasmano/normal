If (False:C215)
	//[Bridge MHD NBIS];"Bridge Input".bDesign
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Bring up the Bridge Design input form
	
	// Modified by: costasmanousakis-(Designer)-(11/19/05 16:40:39)
	Mods_2005_CM19
	DIALOG:C40([Bridge MHD NBIS:1]; "Bridge Design")
	// Modified by: Costas Manousakis-(Designer)-(3/6/12 14:12:43)
	Mods_2012_03
	//Fix in case problems in the [LB_QueryTable] to revert to the old method
	// Modified by: Costas Manousakis-(Designer)-(5/4/12 16:15:21)
	Mods_2012_05
	//  `use SIA_NewOpenModule
End if 
SIA_NewOpenModule("BridgeDesign"; 6; "Bridge Design")