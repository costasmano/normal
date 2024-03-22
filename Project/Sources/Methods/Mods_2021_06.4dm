//%attributes = {"invisible":true}
//Method: Mods_2021_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/30/21, 18:21:40
	// ----------------------------------------------------
	//Created : 
	Mods_2021_06
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(6/30/21)
// INV_TeamLeader_OM - copied from v15
//  `fix code to handle cases when team leaders are inactve
// INV_TeamMember_OM - copied from v15
//  `fix code to handle cases when team members are inactve
// [InventoryPhotoInsp];"Input" - copied from v15
//  `moved calls to INV_TeamLeader_OM INV_TeamMember_OM near the end of On load 

// PON_ExportFHWANBE - copied from v15
//  `change the search of inspections to use any that have been completed at any time ([Inspections]InspCompleteDate > !00/00/00!

//End Mods_2021_06