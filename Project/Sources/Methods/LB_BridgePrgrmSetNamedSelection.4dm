//%attributes = {"invisible":true}
//Method: LB_BridgePrgrmSetNamedSelection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 10/06/20, 15:15:40
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 18:58:14)
	Mods_2021_10
	//  `Unload the record
End if 
//
CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; v_115_002_aL; "SortedPRJDetails")
USE NAMED SELECTION:C332("SortedPRJDetails")
CLEAR NAMED SELECTION:C333("SortedPRJDetails")
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
//End LB_BridgePrgrmSetNamedSelection