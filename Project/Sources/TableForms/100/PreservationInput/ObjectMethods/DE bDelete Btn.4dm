//Method: Object Method: [Contract_Project_Maintenance].PreservationInput.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/07/12, 12:04:20
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete the Project for Bridge "+vBridgeNo+"?"; "Yes"; "No")
	If (OK=1)
		DELETE RECORD:C58([Contract_Project_Maintenance:100])
		CANCEL:C270
	End if 
End if 
//End Object Method: [Contract_Project_Maintenance].PreservationInput.bDelete