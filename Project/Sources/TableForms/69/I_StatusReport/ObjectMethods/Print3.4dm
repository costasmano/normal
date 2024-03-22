//Method: [Status Report].I_StatusReport.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/03/19, 16:12:10
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09
End if 
//

SET PRINT OPTION:C733(Orientation option:K47:2; 1)
SET PRINT OPTION:C733(Scale option:K47:3; 100)

PRINT SETTINGS:C106

Print form:C5([Status Report:69]; "P_StatusRpt_MDOT_POFA_detail")

PAGE BREAK:C6

//End [Status Report].I_StatusReport.Button