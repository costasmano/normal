
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/09/15, 15:46:11
//----------------------------------------------------
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/9/15 15:46:13)
	Mods_2015_08_bug
	//Modified by: administrator (8/20/15 14:34:43)
	// Modified by: Costas Manousakis-(Designer)-(9/14/15 13:40:15)
	Mods_2015_09_bug
	//  `Reload images after saving when on images tab
	Mods_2015_12_bug  // Fix bug where deletion of picture records not recorded correctly
	//Modified by: administrator (12/24/15 11:13:41)
	Mods_2016_01_bug  // Fix where UT and DMeter pictures not being saved properly
	//Modified by: administrator (1/21/16 12:42:23)
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	
End if 

If (Not:C34(Read only state:C362([TIN_Inspections:184])))
	CONFIRM:C162("Save Inspection Data?"; "Save"; "Cancel")
	If (OK=1)
		
		NTI_SaveAndUpdateComments_WP(False:C215)
		NTI_SaveInspection
		VALIDATE TRANSACTION:C240
		START TRANSACTION:C239
	End if 
	
End if 
//End Object Method: [LSS_Inspection].Inspection_Template.bValidate