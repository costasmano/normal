//%attributes = {"invisible":true}
//Method: INSP_SaveInspCommts
//Description
// save inspection report comments - needed because on losing focus event does not fire when clicking some buttons.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-12-23T00:00:00, 13:38:49
	// ----------------------------------------------------
	//Created : 
	Mods_2021_12_bug
End if 
//
If (Not:C34(vbInspectionLocked))
	//check the WP areas if on the current page
	ARRAY TEXT:C222($objects; 0)
	ARRAY POINTER:C280($vars; 0)
	ARRAY LONGINT:C221($pages; 0)
	FORM GET OBJECTS:C898($objects; $vars; $pages; Form current page:K67:6)
	If (Find in array:C230($objects; "DE@WP")>0)
		//WP areas are in the current page
		INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE GenRemarks_WP"; "fieldptr"; ->[Inspections:27]InspComments:171; "formEvent"; On Losing Focus:K2:8; "changeStack"; 1))
		INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE Orientation_WP"; "fieldptr"; ->[Inspections:27]OrientationText:204; "formEvent"; On Losing Focus:K2:8; "changeStack"; 1))
	End if 
	
End if 
//End INSP_SaveInspCommts