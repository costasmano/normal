If (False:C215)
	//Object Method: [TIN_Inspections];"Input".bPrint 
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 11:01:11)
	Mods_2016_08_bug
	//  `added check for changes in AreaGeneralRemarks
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 
If (Not:C34(Read only state:C362([TIN_Inspections:184])))
	
	NTI_SaveAndUpdateComments_WP(False:C215)
	
End if 
InspectionPreviewToCheck_txt:=""


NTI_PrintInspection