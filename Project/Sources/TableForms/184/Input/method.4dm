//Method: Form Method: [TIN_Inspections]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/16, 12:30:21
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(9/9/16 10:20:26)
	Mods_2016_09
	//  `Added 4th page for the review comments
	// Modified by: Costas Manousakis-(Designer)-(3/23/18 16:24:47)
	Mods_2018_03
	//  `added Cond rtg in NTE LB, "Add prot sys"; set number of locked cols to 0 ; tool button
	//  `hide combine BINs button
	// Modified by: Costas Manousakis-(Designer)-(4/20/18 15:31:48)
	Mods_2018_04_bug
	//  `added call to NTI_CalcClearances in vert clearance entry variables
	// Modified by: Costas Manousakis-(Designer)-(3/18/19 16:44:59)
	Mods_2019_03_bug
	//  `changed label of INSP_DIE_atxt to District Tunnel Engr
	// Modified by: Costas Manousakis-(Designer)-(4/10/19 17:13:28)
	Mods_2019_04_bug
	//  `Removed Roof girder , etc. from Rating report data.
	// Modified by: Costas Manousakis-(Designer)-(10/2/19 17:00:58)
	Mods_2019_10_bug
	//  `removed District Tunnel Eng'r
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form eveny in method tp redraw listboxes
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	
End if 
//
NTI_InspectionInput_FM
//End Form Method: [TIN_Inspections]Input