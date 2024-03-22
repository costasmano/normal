// Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.Button
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 07/02/12, 09:32:55
	// ----------------------------------------------------
	// First Release
	Mods_2012_07
End if 
//
PRV_NEWMTGTYPE_txt:="PUBLIC"
FORM SET INPUT:C55([Preservation_Meetings:148]; "PreservationInput")
ADD RECORD:C56([Preservation_Meetings:148])
If (OK=1)
	PRV_CTRLSelections("PUBMTGS")
End if 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.Button