//Method: [LSS_Inspection].StructureDamage_Light_P1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 08/08/18, 14:10:50
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
End if 
//
If (Form event code:C388=On Printing Detail:K2:18)
	LSS_FillDamagePage_1([LSS_Inspection:164]LSS_InspectionTypeId_s:3)
	
End if 
//End [LSS_Inspection].StructureDamage_Light_P1