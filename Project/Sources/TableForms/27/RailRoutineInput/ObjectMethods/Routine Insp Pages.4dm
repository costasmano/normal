If (False:C215)
	//OM vTabRoutingPages
	//Created 5/31/04
	//AL
	//We have to keep the current record of [Combined Inspections]
	//current on this form.
	Mods_2005_CM06
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 18:03:02)
	Mods_2012_12
	//  `Fixed the object method
End if 

If (False:C215)
	//USE NAMED SELECTION("curCombinedInspection")
	//  `RELATE ONE([Combined Inspections])
	//DISPL_CUs 
	//LOAD RECORD([Combined Inspections])
Else 
	RememberCombined
End if 