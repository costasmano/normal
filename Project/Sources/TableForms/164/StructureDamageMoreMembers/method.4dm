//Method: [LSS_Inspection].StructureDamageMoreMembers
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/13/18, 11:14:50
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 11:36:17)
	Mods_2020_04
	//  `fixed size of labels for Previous , present, deficiencies
End if 
//


Case of 
		//3-3-03 ASL change events to form events    
	: (Form event code:C388=On Printing Detail:K2:18)
		//vPageNo:=vPageNo+1
		FORM_FixHairLine
		
		
		
		
End case 
//End [LSS_Inspection].StructureDamageMoreMembers