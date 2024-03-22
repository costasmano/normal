//Method: [LSS_Inspection];"StructureDamage_HS_P1"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/10/18, 15:04:30
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
End if 
//
If (Form event code:C388=On Printing Detail:K2:18)
	
	LSS_FillDamagePage_1([LSS_Inspection:164]LSS_InspectionTypeId_s:3)
	LSS_FillSignPanelForInspections
	
End if 
//End [LSS_Inspection].StructureDamage_HS_P1