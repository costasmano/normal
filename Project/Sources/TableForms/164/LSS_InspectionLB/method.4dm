//Method: [LSS_Inspection].LSS_InspectionLB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/14/17, 13:05:34
	// ----------------------------------------------------
	//Created : 
	Mods_2017_07_bug
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	
End if 
//
If (Form event code:C388=On Load:K2:1)
	InDoubleClick_B:=False:C215
	
	
	
End if 
//End [LSS_Inspection].LSS_InspectionLB