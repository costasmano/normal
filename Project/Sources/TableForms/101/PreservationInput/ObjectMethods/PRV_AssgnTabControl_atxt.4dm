//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.Tab Control
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/12, 22:52:58
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//

If (Self:C308->=1)
	OBJECT SET VISIBLE:C603(*; "PRV_DELASSIGN_BTN"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "PRV_DELASSIGN_BTN"; False:C215)
End if 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.Tab Control