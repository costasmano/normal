//Method: [TIN_Inspections];"Input".TINInspCommentTypes_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/21/17, 15:00:07
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	
End if 
//

NTI_SaveAndUpdateComments_WP(True:C214)
TINInspCommentTypes_atxt{0}:=TINInspCommentTypes_atxt{TINInspCommentTypes_atxt}
//End [TIN_Inspections].Input.TINInspCommentTypes_atxt