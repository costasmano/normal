If (False:C215)
	
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at end
	
End if 

M_SearchBridgeinDesign
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("List box")
//End of script