//%attributes = {"invisible":true}
//Method: Mods_2018_07
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/02/18, 17:50:58
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(7/2/18)

// Modified Method(s) : 
// NTI_LoadExportArrays
//  `Make sure that parent of element is also reportable


//Modified by: Chuck Miller (7/5/18 10:49:01)
//Continue LSS Damage Reports
//Add new fields to lss tables to handle damage reports
//[LSS_Inspection]LSS_DamBostonCopyFiorwardTo_s
//[LSS_Inspection]LSS_DamBostonOffice_d
//[LSS_Inspection]LSS_DamBostonOfficeRemarks_txt


//Modified by: Chuck Miller (7/10/18 10:49:01)
//form [LSS_Inspection];"StructureDamage_HS_P1"

//**********`Modified by: Costas Manousakis-(Designer)-(7/12/18)
// Modified Method(s) : 
// SFA_openRatingReport
//  `modified method of checking for mounted volumes on OSX - use regex matching.

//Method: LSS_PrintDamageInspection
//Description
//
//Method: LSS_CountandPrintDamagePages
//Description

//Date and time: 07/19/18, 14:19:41
//Method: LSS_FillDamagePage_1
//Description
//


//Fix page number error cause by fact that there were no image records loaded before while getting page count
//Modified by: Chuck Miller (7/26/18 14:41:48)

//NTI_PrintInspection
// [LSS_Inventory];"Input".LSS_Print_L
//Add code to print damage inspections
// LSS_PrintMultipleInspections
//Add code to print damage inspections

//End Mods_2018_07