//Method: PRJ_BIN_Hierarchy
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/05/19, 16:10:58
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12  //add code to modify how bin groups are created and maintained for a project
	//by Chuck Miller
End if 
//
If (Form event code:C388=On Load:K2:1)
	
	PRJ_LoadForBINHierarchyDialog
	
	
	
End if 

//End "PRJ_BIN_Hierarchy"